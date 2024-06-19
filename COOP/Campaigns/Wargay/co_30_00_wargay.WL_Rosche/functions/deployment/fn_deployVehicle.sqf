#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Serverside handling of new vehicle deployment.
 *
 * Arguments:
 * 0: Vehicle class to create <STRING>
 * 1: Person deploying vehicle <OBJECT>
 * 2: Vehicle used for spawning <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_vehicleClassName", "_caller", "_spawner"];

private _remainingSpawns = GVAR(spawnableVehicles) getOrDefault [_vehicleClassName, 0];

if (_remainingSpawns < 1) exitWith {
	["MDL_vehicleDeploymentNoLongerPossible", [_vehicleClassName], _caller] call CBA_fnc_targetEvent;
};

private _vehicle = createVehicle [_vehicleClassName, getMarkerPos "sys_marker_spawner_1", ["sys_marker_spawner_1", "sys_marker_spawner_2", "sys_marker_spawner_3"]];
_vehicle setVariable ["MDL_deployedVehicle", true, true];

{
	_x addCuratorEditableObjects [[_vehicle], true];
} forEach allCurators;

if (_vehicle isEqualTo objNull) exitWith {
    ["MDL_createVehicleFailed", [], _caller] call CBA_fnc_targetEvent;
};

["MDL_vehicleDeployment", [_vehicleClassName, _caller, _vehicle]] call CBA_fnc_globalEvent;

private _newRemainingSpawns = _remainingSpawns - 1;
GVAR(spawnableVehicles) set [_vehicleClassName, _newRemainingSpawns];
if (_newRemainingSpawns isEqualTo 0) then {
	["MDL_vehicleDeploymentNoLongerPossible", [_vehicleClassName]] call CBA_fnc_globalEvent;
	deleteVehicle _spawner;
};
