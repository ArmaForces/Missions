#include "script_component.hpp"

minviewdistance = 500;
maxviewdistance = 10000;

#define DEV_DEBUG
#define MAX_HP 10
#define NO_ARMOR [0, 0, 0, 0]
WestIconColor = getArray (missionConfigFile >> "CfgWargay" >> "westMarkerColor");
EastIconColor = getArray (missionConfigFile >> "CfgWargay" >> "eastMarkerColor");
IconMode = 0;
OnlyReconCanSpot = false;

/* Custom test things */

#ifdef DEV_DEBUG
HitpointHits = [];
PositionHits = [];
SurfaceVectors = [];
VelocityVectors = [];
#endif

fnc_shouldStillBeVisible = {
    params ["_target"];

    private _anyoneKnowsAbout = groups WEST findIf {leader _x targetKnowledge _target select 0} != -1;

    _anyoneKnowsAbout
};

fnc_visibilityCheckLoop = {
    params [["_targetsToCheck", []]];

    if (_targetsToCheck isEqualTo []) then {
        _targetsToCheck = vehicles select {side effectiveCommander _x isEqualTo EAST};
    };
    if (_targetsToCheck isEqualTo []) exitWith {
        [fnc_visibilityCheckLoop, [], 5] call CBA_fnc_waitAndExecute;
    };

    private _target = _targetsToCheck deleteAt (count _targetsToCheck - 1);

    #ifdef DEV_DEBUG
    diag_log format ["WARGAY DEBUG VISIBILITY CHECK [%1]: Checking Target %2", diag_tickTime, _target];
    #endif

    private _shouldBeVisible = [_target] call fnc_shouldStillBeVisible;
    private _isVisible = _target getVariable ["MDL_IsVisible", false];
    if (_isVisible && {!_shouldBeVisible}) then {
        #ifdef DEV_DEBUG
        diag_log format ["WARGAY DEBUG VISIBILITY CHECK [%1]: Making Target %2 not visible", diag_tickTime, _target];
        #endif
        _target setVariable ["MDL_IsVisible", false, false];
    };

    [fnc_visibilityCheckLoop, [_targetsToCheck], 1] call CBA_fnc_waitAndExecute;
};

call fnc_visibilityCheckLoop;

fnc_getVehicleInfo = {
    params ["_unitOrGroup", ["_key", ""], ["_defaultValue", objNull]];

    private _unit = if (_unitOrGroup isEqualType objNull) then {
        vehicle _unitOrGroup
    } else {
        vehicle leader _unitOrGroup
    };

    private _vehicleInfo = VehicleTypes getOrDefault [toUpper typeOf _unit, objNull];
    if (_vehicleInfo isEqualTo objNull) exitWith { _defaultValue };

    if (_key isEqualTo "") exitWith { _vehicleInfo };

    _vehicleInfo getOrDefault [_key, _defaultValue]
};

fnc_isReconVehicle = {
    params ["_unitOrGroup"];
    [_unitOrGroup, "isRecon", false] call fnc_getVehicleInfo isEqualTo 1
};

{
    _x addEventHandler ["KnowsAboutChanged", {
        params ["_group", "_targetUnit", "_newKnowsAbout", "_oldKnowsAbout"];

        if (side _targetUnit isNotEqualTo EAST) exitWith {};

        if (OnlyReconCanSpot && {!([_group] call fnc_isReconVehicle)}) exitWith {};

        #ifdef DEV_DEBUG
        diag_log format ["WARGAY DEBUG KNOWS ABOUT CHANGED [%1]: Group: %2, Target: %3, KnowsAbout: %4 -> %5", diag_tickTime, _group, _targetUnit, _oldKnowsAbout, _newKnowsAbout];
        #endif

        private _isRevealed = _targetUnit getVariable ["MDL_IsVisible", false];

        if (_newKnowsAbout > 0.75 && {!_isRevealed}) then {

            _targetUnit setVariable ["MDL_IsVisible", true, true];
            #ifdef DEV_DEBUG
            diag_log format ["WARGAY DEBUG KNOWS ABOUT CHANGED [%1]: Revealing Target: %3 detected by Group: %2", diag_tickTime, _group, _targetUnit, _oldKnowsAbout, _newKnowsAbout];
            #endif
            _group reveal _targetUnit;
        };
    }];

    _x addEventHandler ["EnemyDetected", {
        params ["_group", "_newTarget"];

        #ifdef DEV_DEBUG
        diag_log format ["WARGAY DEBUG ENEMY DETECTED [%1]: Group %1, Target: %2", diag_tickTime, _group, _newTarget];
        #endif
    }];
} forEach (groups WEST);

AmmoTypes = createHashMapFromArray
    ("true" configClasses (missionConfigFile >> "CfgWargay" >> "Ammo")
    apply {
        private _hashMap = createHashMap;
        _hashMap set ["damage", getNumber (_x >> "damage")];
        _hashMap set ["type", getText (_x >> "type")];
        [toUpper configName _x, _hashMap]
    });
VehicleTypes = createHashMapFromArray
    ("true" configClasses (missionConfigFile >> "CfgWargay" >> "Vehicles")
    apply {
        private _hashMap = createHashMap;
        _hashMap set ["hitpoints", getNumber (_x >> "hitpoints")];
        _hashMap set ["armor", getArray (_x >> "armor")];
        _hashMap set ["isRecon", getNumber (_x >> "isRecon")];
        [toUpper configName _x, _hashMap]
    });

// ["AllVehicles", "HandleDamage", ] call CBA_fnc_addClassEventHandler;

{
    _x addEventHandler ["HandleDamage", {
        params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit", "_context"];

        call {
            // Exclude total damage info (_context == 0), FakeHeadHit (3) and TotalDamageBeforeBleeding (4)
            if (_context isEqualTo 0 || {_context > 2}) exitWith { damage _unit };
            
            // Most likely a collision so let the engine handle it
            if (_projectile isEqualTo "" && {isNull _instigator}) exitWith {};
            // TODO: Consider changing HP afterwards somehow

            #ifdef DEV_DEBUG
            diag_log format ["WARGAY DEBUG HANDLE DAMAGE [%1]: %2", diag_tickTime, str _this];
            #endif

            private _selectionHitpointName = getText (configOf _unit >> "Hitpoints" >> _hitPoint >> "name");
            private _modelHitpointPosition = _unit selectionPosition _selectionHitpointName;

            #ifdef DEV_DEBUG
            diag_log format ["WARGAY DEBUG HANDLE DAMAGE [%1]: Model hitpoint name '%2' and position %3", diag_tickTime, _selectionHitpointName, str _modelHitpointPosition];
            #endif

            if (_modelHitpointPosition isEqualTo [0, 0, 0]) exitWith { damage _unit };

            #ifdef DEV_DEBUG
            HitpointHits pushBackUnique (_unit modelToWorld _modelHitpointPosition);
            #endif

            0
        }
    }];

    private _ehId = _x addEventHandler ["HitPart", {
        (_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect", "_instigator"];

        // if (_selection isEqualTo []) exitWith {};
        if (!alive _target) exitWith {};

        private _isHandledForTarget = _projectile getVariable [str _target, false];

        if (_isHandledForTarget) exitWith {};

        #ifdef DEV_DEBUG
        diag_log format ["WARGAY DEBUG HIT PART [%1]: Selection: %2 Vector: %3, Velocity: %4", diag_tickTime, str _selection, str _vector, str _velocity];
        #endif

        // Do not handle projectiles coming at a surface at extreme angles
        private _velocityAndSurfaceProduct = vectorNormalized _velocity vectorDotProduct _vector;
        if (_velocity isNotEqualTo [0, 0, 0] && {_velocityAndSurfaceProduct < 0.15 && {_velocityAndSurfaceProduct > -0.15}}) exitWith {};

        private _hitDir = [_target, _vector, _velocity, _position] call fnc_getHitDir;

        #ifdef DEV_DEBUG
        PositionHits pushBack (_position);
        SurfaceVectors pushBack ([_position, _vector]);
        VelocityVectors pushBack ([_position, _velocity]);
        #endif

        _projectile setVariable [str _target, true];

        private _hitPosition = if (_isDirect) then { [] } else { ASLToAGL _position };

        [_target, _hitDir, _hitPosition, _velocity, _ammo] call fnc_handleDamage;
    }];

    _x setVariable ["MDL_HitPartEHID", _ehId];
    private _vehicleHitpoints = [_x, "hitpoints"] call fnc_getVehicleInfo;
    if (_vehicleHitpoints isEqualTo objNull) then {
        private _defaultHitpoints = 10;
        _vehicleHitpoints = _defaultHitpoints;
        diag_log format ["WARGAY WARNING Hitpoints not defined for %1. Setting default hitpoints %2", typeof _x, _defaultHitpoints];
    } else {
        diag_log format ["WARGAY DEBUG Hitpoints %1", str _vehicleHitpoints];
    };
    
    _x setVariable ["MDL_currentHp", _vehicleHitpoints];
    _x setVariable ["MDL_maxHp", _vehicleHitpoints];

    // 
    _x setFuelConsumptionCoef 10;
} forEach vehicles;

fnc_getHitDir = {
    params ["_target", "_surfaceVector", "_velocity", "_hitWorldPosition"];

    private _hitModelPosition = _target worldToModel _hitWorldPosition;
    private _surfaceVectorNormalized = vectorNormalized _surfaceVector;
    private _velocityVectorNormalized = vectorNormalized _velocity;

    #ifdef DEV_DEBUG
    diag_log format ["WARGAY DEBUG GET HIT DIR [%1]: Target: %2, Vector: %3, Velocity: %4, HitPosition: %5", diag_tickTime, _target, _surfaceVector, _velocity, _hitModelPosition];
    #endif
    
    private _targetDir = vectorDir _target;
    
    private _dotProduct = _targetDir vectorDotProduct _surfaceVectorNormalized;
    private _topHitDir = _surfaceVector#2 atan2 sqrt (_surfaceVector#0^2 + _surfaceVector#1^2);
    
    private _hitDir = if (_topHitDir > 70) then {
        "TOP"
    } else {
        if (_dotProduct > 0.5) exitWith { "FRONT" };
        if (_dotProduct < -0.5) exitWith { "REAR" };
        "SIDE"
    };

    #ifdef DEV_DEBUG
    diag_log format ["WARGAY DEBUG GET HIT DIR [%1]: Target Dir: %2, Dot product: %3, Top='%4'", diag_tickTime, _targetDir, _dotProduct, _topHitDir];
    #endif

    _hitDir
};

addMissionEventHandler ["Draw3D", {
    #ifdef DEV_DEBUG
    {
        drawIcon3D ["#(argb,8,8,3)color(1,0,0,1)", [1,1,1,1], _x, 0.25, 0.25, 0, "Hit", 0, 0.03];
    } forEach HitpointHits;
    {
        drawIcon3D ["#(argb,8,8,3)color(0,0,1,1)", [1,1,1,1], ASLToAGL _x, 0.25, 0.25, 0, "Hit", 0, 0.03];
    } forEach PositionHits;
    {
        _x params ["_position", "_vector"];
        drawLine3D [ASLToAGL _position, ASLToAGL _position vectorAdd vectorNormalized _vector, [0,1,0,1]];
    } forEach SurfaceVectors;
    {
        _x params ["_position", "_vector"];
        drawLine3D [ASLToAGL _position, ASLToAGL _position vectorAdd vectorNormalized _vector, [0,0,1,1]];
    } forEach VelocityVectors;
    #endif

    fnc_getGroupVehicles = {
        params ["_group"];
        private _groupVehicles = units _group apply { vehicle _x } select {_x isKindOf "AllVehicles"};
        _groupVehicles arrayIntersect _groupVehicles
    };

    // Always draw icon for cursor object;
    // TODO: Consider cursorTarget
    private _cursorObject = cursorObject;
    private _vehiclesWithIcons = if (_cursorObject getVariable ["MDL_IsVisible", false]) then {
        [[_cursorObject, true]]
    } else { [] };
    curatorMouseOver params ["_type", "_entity", "_index"];
    if (_type isEqualTo "OBJECT") then {
        _vehiclesWithIcons pushBackUnique [_entity, true];
    };
    if (_type isEqualTo "GROUP") then {
        {
            _vehiclesWithIcons pushBackUnique [_x, true];
        } forEach ([_entity] call fnc_getGroupVehicles);
    };
    
    curatorSelected params ["_objects", "_groups"];
    {
        _vehiclesWithIcons pushBackUnique [_x, true];
    } forEach _objects;
    {
        {
            _vehiclesWithIcons pushBackUnique [_x, true];
        } forEach ([_x] call fnc_getGroupVehicles);
    } forEach _groups;

    switch (IconMode) do {
        // Friendly and enemy
        case 0: {
            {
                _vehiclesWithIcons pushBackUnique [_x, false];
            // } forEach (vehicles select {
            //     side effectiveCommander _x isNotEqualTo SideUNKNOWN && side effectiveCommander _x isNotEqualTo EAST
            //     || {(side effectiveCommander _x isEqualTo EAST && {player knowsAbout _x > 1})}});
            } forEach (vehicles select {
                side effectiveCommander _x isNotEqualTo SideUNKNOWN && side effectiveCommander _x isNotEqualTo EAST
                || {(side effectiveCommander _x isEqualTo EAST && {_x getVariable ["MDL_IsVisible", false]})}});
        };
        // Enemy only
        case 1: {
            {
                _vehiclesWithIcons pushBackUnique [_x, false];
            } forEach (vehicles select {side effectiveCommander _x isNotEqualTo SideUNKNOWN && {side effectiveCommander _x isEqualTo EAST}});
        };
        default {};
    };

    // Draws icons. Might draw an icon twice for one object if it's targeted/highlighted.
    {
        _x call fnc_drawIcon;
    } forEach _vehiclesWithIcons;
}];

fnc_drawIcon = {
    params ["_target", ["_includeText", false]];

    if (!alive _target || {_target getVariable ["MDL_currentHp", 0] isEqualTo 0}) exitWith {};
    
    private _worldPos = _target modelToWorldVisual [0, 0, 1.5];
    private _iconDescription = if (_includeText) then {
        private _vehicleInfo = VehicleTypes getOrDefault [toUpper typeOf _target, []];
        private _vehicleDisplayNameShort = if (_vehicleInfo isEqualTo []) then {
            private _hashMap = createHashMapFromArray [["displayNameShort", getText (configOf _target >> "displayNameShort")]];
            VehicleTypes set [toUpper typeOf _target, _hashMap];
        } else {
            _vehicleInfo getOrDefault ["displayNameShort", getText (configOf _target >> "displayNameShort"), true]
        };
        format ["%1 - %2", _vehicleDisplayNameShort, [_target, " "] call fnc_currentHpString]
    } else { "" };

    private _icon = [_target] call afft_friendly_tracker_fnc_getVehicleMarkerType;
    private _iconPath = format ["\A3\ui_f\data\map\markers\nato\%1.paa", _icon];
    private _iconWidth = (0.01 * safeZoneW) / getNumber (configFile >> "CfgInGameUI" >> "Cursor" >> "activeWidth");
    private _iconHeight = _iconWidth;
    private _sideColor = if (side effectiveCommander _target isEqualTo WEST) then { WestIconColor } else { EastIconColor };
    // #ifdef DEV_DEBUG
    // private _icon3DParams = [_iconPath, [_sideColor, [1,1,1,1]], _worldPos, _iconWidth, _iconHeight, 0, _iconDescription, 0, 0.02, "EtelkaMonospacePro"];
    // diag_log format ["WARGAY DEBUG ICON3D [%1]: Params: %2", diag_tickTime, str _icon3DParams];
    // #endif
    drawIcon3D [_iconPath, [_sideColor, [1,1,1,1]], _worldPos, _iconWidth, _iconHeight, 0, _iconDescription, 0, 0.02, "EtelkaMonospacePro"];
};

// addMissionEventHandler ["Draw3D", {
//     private _veh = cursorObject;

//     private _selectionNames = selectionNames _veh;

//     private _selectionNamesAndPos = _selectionNames apply {
//         [_x, _veh selectionPosition _x]
//     } select { _x select 1 isNotEqualTo [0, 0, 0]};

//     {
//         _x params ["_selectionName", "_selectionRelPos"];

//         private _worldPos = _veh modelToWorld _selectionRelPos;
//         drawIcon3D ["#(argb,8,8,3)color(1,1,1,1)", [1,1,1,1], _worldPos, 0.25, 0.25, 0, _selectionName, 0, 0.03];

//     } forEach _selectionNamesAndPos;
// }];

["CSLA_T72", [11, 6, 3, 2]];
["CSLA_T72M", [12, 7, 3, 2]];
["CSLA_T72M1", [14, 7, 3, 2]];
["CSLA_BVP1", [3, 1, 1, 1]];
["CSLA_BPzV", [3, 1, 1, 1]];
["CSLA_DTP90", [3, 1, 1, 1]];
["CSLA_MU90", [3, 1, 1, 1]];
["CSLA_OZV90", [3, 1, 1, 1]];
["CSLA_OT62", [2, 1, 1, 1]];
["CSLA_OT64C", [1, 1, 1, 1]];
["CSLA_OT64C_VB", [1, 1, 1, 1]];
["CSLA_OT65A", [1, 1, 1, 1]];
["AFMC_M1IP", [17, 7, 3, 3]];
["AFMC_M1A1", [17, 7, 4, 3]];
["AFMC_LAV25", [1, 1, 1, 1]];
["AFMC_M113_AMB", [1, 1, 1, 1]];
["AFMC_M113_DTP", [1, 1, 1, 1]];
["AFMC_M113", [1, 1, 1, 1]];
["AFMC_M163", [1, 1, 1, 1]];
["AFMC_M270", [1, 0, 0, 0]];

#define BASE_AP_SPEED 1300
#define VELOCITY_STEP 150

fnc_handleDamage = {
    params ["_unit", "_hitDir", "_hitPositionAGL", "_velocity", "_ammo"];
    _ammo params ["_hitValue", "_indirectHitValue", "_indirectHitRange", "_explosiveDamage", "_ammoClassName"];

    private _unitType = VehicleTypes getOrDefault [toUpper typeOf _unit, []];
    private _unitArmor = if (_unitType isEqualTo []) then { NO_ARMOR } else {
        _unitType getOrDefault ["armor", NO_ARMOR]
    };

    private _armor = switch (_hitDir) do {
        case "FRONT": { _unitArmor select 0 };
        case "SIDE": { _unitArmor select 1 };
        case "REAR": { _unitArmor select 2 };
        case "TOP": { _unitArmor select 3 };
        default { 0 };
    };

    private _ammoInfo = AmmoTypes getOrDefault [toUpper _ammoClassName, []];
    if (_ammoInfo isEqualTo []) then {
        // Try to recover for small arms as I was lazy and didn't want to copy all the ammo classes
        private _isSmallArms = getNumber (configFile >> "CfgAmmo" >> _ammoClassName >> "caliber") < 1;
        if (_isSmallArms) then {
            private _hashMap = AmmoTypes get "SMALL_ARMS";
            AmmoTypes set [toUpper _ammoClassName, _hashMap];
        };
    };
    if (_ammoInfo isEqualTo []) exitWith {};

    private _ammoDamage = _ammoInfo getOrDefault ["damage", 0];
    if (_ammoDamage isEqualTo 0) exitWith {};

    private _isUnknownAmmo = false;
    private _ammoType = _ammoInfo getOrDefault ["type", "NONE"];
    private _damage = switch (_ammoType) do {
        case "AP": { [_armor, _ammoDamage, _velocity] call fnc_keDamage };
        case "HEAT": { [_armor, _ammoDamage] call fnc_heatDamage };
        case "HE" : {
            private _distanceToTarget = if (_hitPositionAGL isEqualTo []) then { 0 } else { getPosATL _unit distance _hitPositionAGL };
            [_armor, _ammoDamage, _distanceToTarget] call fnc_heDamage
        };
        default { _isUnknownAmmo = true; 0 };
    };

    if (_isUnknownAmmo) exitWith {
        #ifdef DEV_DEBUG
        private _infoMsg = format ["Unknown ammunition '%1' used, ignoring calculations",_ammoClassName];
        systemChat _infoMsg;
        diag_log _infoMsg;
        #endif
    };

    #ifdef DEV_DEBUG
    private _infoMsg = format ["Potential damage: %1 %2, Hit armor: %3 %4, Actual damage: %5", _ammoDamage, _ammoType, _hitDir, _armor, _damage];
    systemChat _infoMsg;
    diag_log _infoMsg;
    #endif

    if (_damage isEqualTo 0) exitWith {};

    private _currentHp = _unit getVariable ["MDL_currentHp", 10];
    private _newHp = _currentHp - _damage;

    if (_newHp <= 0) exitWith {
        _unit setVariable ["MDL_currentHp", 0, true];
        {_x setDamage 1} forEach crew _unit;
        _unit setDamage 1;

        private _ehId = _unit getVariable ["MDL_HitPartEHID", -1];
        _unit removeEventHandler ["HitPart", _ehId];
    };

    #ifdef DEV_DEBUG
    systemChat format ["Remaining HP: %1/10", _newHp];
    #endif

    _unit setVariable ["MDL_currentHp", _newHp, true];
    // Limit to 0.8 to avoid explosions when hull or fuel are almost destroyed
    _unit setDamage ((_newHp/MAX_HP) min 0.8);
    ["MDL_showCurrentHp", [_unit], crew _unit] call CBA_fnc_targetEvent;
};

["MDL_showCurrentHp", {
    params ["_vehicle"];
    if (vehicle player isNotEqualTo _vehicle) exitWith {};

    private _string = [_vehicle, "_"] call fnc_currentHpString;
    titleText ["\n\n\n\n\n" + _string, "PLAIN", 0.3, true];
}] call CBA_fnc_addEventHandler;

fnc_currentHpString = {
    params ["_unit", ["_nonDamagedMark", "_"]];
    private _currentHp = _unit getVariable ["MDL_currentHp", 0];
    private _missingHp = 10 - _currentHp;

    private _string = "";
    for "_a" from 1 to round _currentHp do {
        _string = _string + "[" + _nonDamagedMark + "]";
    };
    for "_a" from 1 to round _missingHp do {
        _string = _string + "[X]";
    };
    
    _string
};

fnc_heatDamage = {
    params ["_armor", "_ammoBaseDamage"];
    
    if (_armor isEqualTo 0) exitWith { _ammoBaseDamage * 2 };
    private _standardDamage = ((_ammoBaseDamage - _armor)/2) + 1;
    
    // 1 dmg for each 1 AP above 10 difference from armor value (e.g., 13 AP vs 2 AV = 1 dmg)
    private _extraDamage = 0 max (_ammoBaseDamage - _armor - 10);
    
    // HEAT always does at least 1 dmg
    1 max (_standardDamage + _extraDamage)
};

// Wargame Red Dragon KE formula reverse engineered
// Not using distance as velocity seems to fit better
fnc_keDamage = {
    params ["_armor", "_ammoBaseDamage", "_velocity"];
    private _damageFromVelocity = _ammoBaseDamage - ((BASE_AP_SPEED - vectorMagnitude _velocity) / VELOCITY_STEP);

    if (_armor isEqualTo 0) exitWith { 2 * (_ammoBaseDamage max _damageFromVelocity) };
    if (_armor isEqualTo 1) exitWith { (_ammoBaseDamage max _damageFromVelocity) };
    if (_damageFromVelocity < 0) exitWith { 0 };

    // Half for 2 armor, decreasing .5 for every additional armor point
    _damageFromVelocity - (_damageFromVelocity/2) - (_armor - 2) * 0.5
};

// TODO: Consider distance from projectile
fnc_heDamage = {
    params ["_armor", "_ammoBaseDamage", "_distanceToTarget"];

    #ifdef DEV_DEBUG
    diag_log format ["WARGAY DEBUG HE DAMAGE [%1]: %2 AV, %3 HE, %4 m to target", diag_tickTime, _armor, _ammoBaseDamage, _distanceToTarget];
    #endif

    fnc_damagePerHe = {
        params ["_armor"];

        if (_armor < 2) exitWith {1};
        if (_armor isEqualTo 2) exitWith {0.4};
        if (_armor isEqualTo 3) exitWith {0.3};
        if (_armor isEqualTo 4) exitWith {0.2};
        if (_armor isEqualTo 5) exitWith {0.15};
        if (_armor < 8) exitWith {0.1};
        if (_armor < 14) exitWith {0.05};
        0.01
    };

    private _damage = _ammoBaseDamage * ([_armor] call fnc_damagePerHe);
    private _maxDistanceToTarget = _damage^2 + 1;
    private _calculatedDamage = _damage * ((_maxDistanceToTarget - _distanceToTarget)/_maxDistanceToTarget);
    0 max _calculatedDamage
};
