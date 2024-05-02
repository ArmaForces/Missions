#include "script_component.hpp"

minviewdistance = 500;
maxviewdistance = 10000;

#define DEV_DEBUG
#define KEY_TAB 15 // 0x0F
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

// Handle "Info" button
findDisplay 46 displayAddEventHandler ["KeyDown", {
    params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];

    if (_key isNotEqualTo KEY_TAB) exitWith {};

    private _cursorTarget = cursorTarget;
    if (_cursorTarget isEqualTo objNull) exitWith {};

    [_cursorTarget] call FUNC(showUnitInfo);
}];

// TODO: Consider adding initial projectile position/velocity in Fired EH and base damage on that

{
    _x addEventHandler ["KnowsAboutChanged", {
        params ["_group", "_targetUnit", "_newKnowsAbout", "_oldKnowsAbout"];

        if (side _targetUnit isNotEqualTo EAST) exitWith {};

        if (OnlyReconCanSpot && {!([_group] call FUNC(isReconVehicle))}) exitWith {};

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
        _hashMap set ["className", toUpper configName _x];
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

        private _hitDir = [_target, _vector, _velocity, _position] call FUNC(getHitDir);

        #ifdef DEV_DEBUG
        PositionHits pushBack (_position);
        SurfaceVectors pushBack ([_position, _vector]);
        VelocityVectors pushBack ([_position, _velocity]);
        #endif

        _projectile setVariable [str _target, true];

        private _hitPosition = if (_isDirect) then { [] } else { ASLToAGL _position };

        [_target, _hitDir, _hitPosition, _velocity, _ammo] call FUNC(handleDamage);
    }];

    _x setVariable ["MDL_HitPartEHID", _ehId];
    private _vehicleHitpoints = [_x, "hitpoints"] call FUNC(getVehicleInfo);
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
        } forEach ([_entity] call FUNC(getGroupVehicles));
    };
    
    curatorSelected params ["_objects", "_groups"];
    {
        _vehiclesWithIcons pushBackUnique [_x, true];
    } forEach _objects;
    {
        {
            _vehiclesWithIcons pushBackUnique [_x, true];
        } forEach ([_x] call FUNC(getGroupVehicles));
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
    // TODO: Don't draw icons off-screen
    {
        _x call FUNC(drawIcon);
    } forEach _vehiclesWithIcons;
}];

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

["MDL_showCurrentHp", {
    params ["_vehicle"];
    if (vehicle player isNotEqualTo _vehicle) exitWith {};

    private _string = [_vehicle, "_"] call FUNC(currentHpString);
    titleText ["\n\n\n\n\n" + _string, "PLAIN", 0.3, true];
}] call CBA_fnc_addEventHandler;
