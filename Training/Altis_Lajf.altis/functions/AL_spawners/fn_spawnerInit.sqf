/*
 * Author: 3Mydlo3
 * Function initializes given spawner with apropriate vehicles.
 *
 * Arguments:
 * 0: Spawner object <OBJECT>
 * 1: Vehicle type to spawn from spawner <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call AL_fnc_spawnerInit
 *
 * Public: No
 */

params ["_spawner", ["_vehicleType", "default"]];

_spawner setVariable ["AL_spawnPoint", [_spawner] call AL_fnc_getSpawnPoint];

private _vehicles = switch (typeOf _spawner) do {
	case heli_spawn_point: {AL_Air};
	case plane_spawn_point: {AL_Air};
	case vehicle_spawn_point: {AL_Vehicles};
	default {[]};
};

if (_vehicles isEqualTo []) exitWith {};

[_spawner, _vehicles] remoteExecCall ["AL_fnc_spawnerAddVehicles", 0, true];