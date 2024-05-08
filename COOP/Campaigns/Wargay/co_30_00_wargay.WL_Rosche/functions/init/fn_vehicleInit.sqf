#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Initializes vehicles to work with custom damage model.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

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

_entity addEventHandler ["HandleDamage", {
    _this call FUNC(handleDamage);
}];
_entity addEventHandler ["HitPart", FUNC(hitPart)];
_entity addEventHandler ["Fired", FUNC(fired)];

// Increase fuel consumption;
_entity setFuelConsumptionCoef GVAR(fuelConsumptionMultiplier);

_entity allowCrewInImmobile true;

if (hasInterface) then {
    // TODO: Consider allowing repair only near supply vehicles
    // TODO: Consider repair/rearm/refuel for all eligible vehicles in some radius (e.g., via some deployable)
    [_entity] call FUNC(addRepairAction);
    [_entity] call FUNC(addRearmAction);

    if (_entity getVariable ["MDL_isSpawner", false]) then {
        [_entity] call FUNC(vehicleSpawnerInit);
    };
};
