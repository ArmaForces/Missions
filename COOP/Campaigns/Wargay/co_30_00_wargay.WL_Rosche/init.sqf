#include "script_component.hpp"

minviewdistance = 500;
maxviewdistance = 10000;

// TODO: Consider adding initial projectile position/velocity in Fired EH and base damage on that

// TODO: Add KnowsAboutChanged EH to WEST groups as needed as this thing most likely won't work
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

["AllVehicles", "HandleDamage", {
    // Nested call to allow using "exitWith" without leaving Event Handler
    _this call FUNC(handleDamage)
},
true,
["Man"],
true] call CBA_fnc_addClassEventHandler;

["AllVehicles", "Init", {
    params ["_entity"];

    #ifdef DEV_DEBUG
    diag_log format ["WARGAY DEBUG Init [%1]: Entity: %2, Type: %3", diag_tickTime, _entity, typeOf _entity];
    #endif

    private _vehicleHitpoints = [_entity, "hitpoints"] call FUNC(getVehicleInfo);
    if (_vehicleHitpoints isEqualTo objNull) then {
        private _defaultHitpoints = 10;
        _vehicleHitpoints = _defaultHitpoints;
        diag_log format ["WARGAY WARNING Hitpoints not defined for %1. Setting default hitpoints %2", typeof _entity, _defaultHitpoints];
    } else {
        diag_log format ["WARGAY DEBUG Hitpoints %1", str _vehicleHitpoints];
    };
    
    _entity setVariable ["MDL_currentHp", _vehicleHitpoints];
    _entity setVariable ["MDL_maxHp", _vehicleHitpoints];

    _entity addEventHandler ["HitPart", FUNC(hitPart)];

    // Increase fuel consumption;
    _entity setFuelConsumptionCoef 10;

    _entity allowCrewInImmobile true;

    if (hasInterface) then {
        // TODO: Consider allowing repair only near supply vehicles
        // TODO: Disallow repair when active (damage received, shooting)
        // TODO: Consider repair/rearm/refuel for all eligible vehicles in some radius (e.g., via some deployable)
        [_entity] call FUNC(addRepairAction);
        
        addMissionEventHandler ["Draw3D", FUNC(draw3D)];
    };
},
true, // Allow inheritance
["Man"], // Excluded classes
true /* Apply retroactive */] call CBA_fnc_addClassEventHandler;

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
    if (vehicle player isEqualTo player) exitWith {};
    call FUNC(updateHitpointsDisplay);
}] call CBA_fnc_addEventHandler;
