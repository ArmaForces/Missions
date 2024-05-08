#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Initializes spawner for given vehicle.
 *
 * Arguments:
 * 0: Vehicle with spawn action <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_spawner"];

private _vehicleClass = typeOf _spawner;
private _vehicleName = [_spawner] call FUNC(getVehicleDisplayName);

_spawner addAction [
    _vehicleName,
    {
        params ["_target", "_caller", "", "_arguments"];

        ["MDL_deployVehicle", [_arguments select 0, _caller, _target]] call CBA_fnc_serverEvent;        
    },
    [_vehicleClass]
];
