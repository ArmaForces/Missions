/*
 * Author: 3Mydlo3
 * Function returns 
 *
 * Arguments:
 * 0: Spawner <OBJECT>
 *
 * Return Value:
 * 0: spawn point object <OBJECT>
 *
 * Example:
 * [player] call AL_fnc_getSpawnPoint;
 *
 * Public: No
 */

params ["_spawner"];

private _spawnPointType = switch (typeOf _spawner) do {
	case heli_spawn_point: {heli_spawn_location};
	case plane_spawn_point: {plane_spawn_location};
	case vehicle_spawn_point: {vehicle_spawn_location};
	default {vehicle_spawn_location};
};

((nearestObjects [_spawner, [_spawnPointType], 50]) select {typeOf _x == _spawnPointType}) select 0;