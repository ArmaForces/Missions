#include "script_component.hpp"

minviewdistance = 500;
maxviewdistance = 10000;

/* Custom test things */

HitpointHits = [];
PositionHits = [];

{
    _x addEventHandler ["HandleDamage", {
        params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit", "_context"];

        if (_context isEqualTo 0 || {_context > 2}) exitWith { damage _unit };

        diag_log format ["WARGAY DEBUG HANDLE DAMAGE [%1]: %2", diag_tickTime, str _this];

        private _selectionHitpointName = getText (configfile >> "CfgVehicles" >> typeOf _unit >> "Hitpoints" >> _hitPoint >> "name");
        private _modelHitpointPosition = _unit selectionPosition _selectionHitpointName;
        diag_log format ["WARGAY DEBUG HANDLE DAMAGE [%1]: Model hitpoint name '%2' and position %3", diag_tickTime, _selectionHitpointName, str _modelHitpointPosition];

        if (_modelHitpointPosition isEqualTo [0, 0, 0]) exitWith { damage _unit };

        HitpointHits pushBackUnique (_unit modelToWorld _modelHitpointPosition);

        0
    }];

    private _ehId = _x addEventHandler ["HitPart", {
        (_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect", "_instigator"];

        // if (_selection isEqualTo []) exitWith {};
        if (!alive _target) exitWith {};

        private _isHandledForTarget = _projectile getVariable [str _target, false];

        if (_isHandledForTarget) exitWith {};

        diag_log format ["WARGAY DEBUG HIT PART [%1]: Selection: %2 Vector: %3, Velocity: %4", diag_tickTime, str _selection, str _vector, str _velocity];

        private _targetDir = getDir _target;
        private _xyHitDir = _vector#0 atan2 _vector#1;
        private _topHitDir = _vector#2 atan2 sqrt (_vector#0^2 + _vector#1^2);

        private _relativeDir = _targetDir - _xyHitDir;

        // BUG: REAR is often reported in FRONT
        private _hitDir = if (_topHitDir > 70) then {
            "TOP"
        } else {
            if (_relativeDir > -50 && {_relativeDir < 50}) exitWith { "FRONT" };
            if (_relativeDir < -120 || {_relativeDir > 120}) exitWith { "REAR" };
            "SIDE"
        };

        // private _msg = format ["Hit %1, Velocity: %5 km/h RelativeDir: %6, TargetDir: %2, SurfaceDir: [%3, %4]", _hitDir, _targetDir, _xyHitDir, _topHitDir, vectorMagnitude _velocity, _relativeDir];
        // diag_log _msg;
        // systemChat _msg;

        PositionHits pushBack (_position);

        _projectile setVariable [str _target, true];

        [_target, _hitDir, _velocity, _ammo] call fnc_handleDamage;
    }];

    _x setVariable ["MDL_HitPartEHID", _ehId];
} forEach vehicles;

addMissionEventHandler ["Draw3D", {
    {
        drawIcon3D ["#(argb,8,8,3)color(1,0,0,1)", [1,1,1,1], _x, 0.25, 0.25, 0, "Hit", 0, 0.03];
    } forEach HitpointHits;
    {
        drawIcon3D ["#(argb,8,8,3)color(0,0,1,1)", [1,1,1,1], ASLToAGL _x, 0.25, 0.25, 0, "Hit", 0, 0.03];
    } forEach PositionHits;
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

TankArmor = createHashMap;
Leopard1A1Armor = createHashMap;
Leopard1A1Armor set ["FRONT", 6];
Leopard1A1Armor set ["SIDE", 2];
Leopard1A1Armor set ["REAR", 2];
Leopard1A1Armor set ["TOP", 1];

T55AArmor = createHashMap;
T55AArmor set ["FRONT", 7];
T55AArmor set ["SIDE", 3];
T55AArmor set ["REAR", 2];
T55AArmor set ["TOP", 1];

TankArmor set ["gm_gc_army_t55a", T55AArmor];
TankArmor set ["gm_ge_army_Leopard1a1", Leopard1A1Armor];

["gm_gc_army_pt76b", [2, 1, 1, 1]];
["gm_gc_army_t55", [7, 3, 2, 1]];
["gm_gc_army_t55a", [7, 3, 2, 1]];
["gm_gc_army_t55ak", [7, 3, 2, 1]];
["gm_gc_army_t55am2", [10, 5, 2, 2]];
["gm_gc_army_t55am2b", [10, 5, 2, 2]];
["gm_gc_army_zsu234v1", [1, 1, 1, 1]];
["gm_gc_army_2s1", [1, 1, 1, 1]];
["gm_gc_army_2p16", [1, 1, 1, 1]];
["gm_gc_army_bmp1sp2", [3, 1, 1, 1]];
["gm_gc_army_brdm2", [1, 1, 1, 1]];
["gm_gc_army_brdm2rkh", [1, 1, 1, 1]];
["gm_gc_army_brdm2um", [1, 1, 1, 1]];
["gm_gc_army_btr60pa", [1, 1, 1, 1]];
["gm_gc_army_btr60pa_dshkm", [1, 1, 1, 1]];
["gm_gc_army_btr60pb", [1, 1, 1, 1]];
["gm_gc_army_btr60pu12", [1, 1, 1, 1]];
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
["gm_ge_army_Leopard1a1", [6, 2, 2, 1]];
["gm_ge_army_Leopard1a1a2", [6, 2, 2, 1]];
["gm_ge_army_Leopard1a3", [8, 3, 2, 2]];
["gm_ge_army_Leopard1a3a1", [8, 3, 2, 2]];
["gm_ge_army_Leopard1a5", [10, 3, 2, 2]];
["gm_ge_army_gepard1a1", [3, 2, 2, 1]];
["gm_ge_army_m109g", [2, 1, 1, 1]];
["gm_ge_army_marder1a1plus", [4, 2, 1, 1]];
["gm_ge_army_marder1a1", [4, 2, 1, 1]];
["gm_ge_army_marder1a2", [4, 2, 1, 1]];
["gm_ge_army_luchsa1", [2, 1, 1, 1]];
["gm_ge_army_luchsa2", [2, 2, 1, 1]];
["gm_ge_army_m113a1g_apc", [1, 1, 1, 1]];
["gm_ge_army_m113a1g_apc_milan", [1, 1, 1, 1]];
["gm_ge_army_m113a1g_command", [1, 1, 1, 1]];
["gm_ge_army_m113a1g_medic", [1, 1, 1, 1]];
["gm_ge_army_fuchsa0_command", [1, 1, 1, 1]];
["gm_ge_army_fuchsa0_engineer", [1, 1, 1, 1]];
["gm_ge_army_fuchsa0_reconnaissance", [1, 1, 1, 1]];
["gm_ge_army_bibera0", [1, 1, 1, 1]];
["gm_ge_army_bpz2a0", [6, 2, 2, 1]];
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
    params ["_unit", "_hitDir", "_velocity", "_ammo"];
    _ammo params ["_hitValue", "_indirectHitValue", "_indirectHitRange", "_explosiveDamage", "_ammoClassName"];

    private _unitArmor = getArray (missionConfigFile >> "CfgWargay" >> "Vehicles" >> typeof _unit >> "armor");

    private _armor = switch (_hitDir) do {
        case "FRONT": { _unitArmor select 0 };
        case "SIDE": { _unitArmor select 1 };
        case "REAR": { _unitArmor select 2 };
        case "TOP": { _unitArmor select 3 };
        default { 0 };
    };

    private _ammoType = getText (missionConfigFile >> "CfgWargay" >> "Ammo" >> _ammoClassName >> "type");
    private _ammoDamage = getNumber (missionConfigFile >> "CfgWargay" >> "Ammo" >> _ammoClassName >> "damage");
    if (_ammoDamage isEqualTo 0) exitWith {};

    private _isUnknownAmmo = false;
    private _damage = switch (_ammoType) do {
        case "AP": { [_armor, _ammoDamage, _velocity] call fnc_keDamage };
        case "HEAT": { [_armor, _ammoDamage] call fnc_heatDamage };
        case "HE" : { [_armor, _ammoDamage] call fnc_heDamage };
        default { _isUnknownAmmo = true; 0 };
    };

    if (_isUnknownAmmo) exitWith {
        private _infoMsg = format ["Unknown ammunition '%1' used, ignoring calculations",_ammoClassName];
        systemChat _infoMsg;
        diag_log _infoMsg;
    };

    private _infoMsg = format ["Potential damage: %1 %2, Hit armor: %3 %4, Actual damage: %5", _ammoDamage, _ammoType, _hitDir, _armor, _damage];
    systemChat _infoMsg;
    diag_log _infoMsg;

    if (_damage isEqualTo 0) exitWith {
        systemChat format ["No damage applied for ammo '%1'", _ammoClassName];
    };

    private _currentHp = _unit getVariable ["MDL_currentHp", 10];
    private _newHp = _currentHp - _damage;

    if (_newHp <= 0) then {
        _unit setDamage 1;

        private _ehId = _unit getVariable ["MDL_HitPartEHID", -1];
        _unit removeEventHandler ["HitPart", _ehId];
    };

    systemChat format ["Remaining HP: %1/10", _newHp];

    _unit setVariable ["MDL_currentHp", _newHp];
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
    private _damageNoArmor = _ammoBaseDamage - ((BASE_AP_SPEED - vectorMagnitude _velocity) / VELOCITY_STEP);
    private _damagePart1 = (_damageNoArmor * (2 - _armor)) max 0; // Twice for 0 armor, standard for 1 armor, 0 for 2 armor
    private _damagePart2 = _damageNoArmor - (_damageNoArmor/2) - (_armor - 2) * 0.5; // Half for 2 armor, decreasing .5 for every additional armor point
    
    _damagePart1 max _damagePart2
};

fnc_heDamage = {
    params ["_armor", "_ammoBaseDamage"];

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

    _ammoBaseDamage * ([_armor] call fnc_damagePerHe);
};
