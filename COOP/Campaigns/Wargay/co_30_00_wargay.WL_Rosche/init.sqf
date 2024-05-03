#include "script_component.hpp"

minviewdistance = 500;
maxviewdistance = 10000;

#define DEV_DEBUG
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
findDisplay 46 displayAddEventHandler ["KeyDown", FUNC(keyDown)];

// TODO: Consider adding initial projectile position/velocity in Fired EH and base damage on that

{
    _x addEventHandler ["KnowsAboutChanged", FUNC(knowsAboutChanged)];

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
        // Nested call to allow using "exitWith" without leaving Event Handler
        _this call FUNC(handleDamage);
    }];

    private _ehId = _x addEventHandler ["HitPart", FUNC(hitPart)];

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

addMissionEventHandler ["Draw3D", FUNC(draw3D)];

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
