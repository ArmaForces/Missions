/*
 * Author: 3Mydlo3
 * Function spawns desired vehicle on spawning position near given spawner.
 *
 * Arguments:
 * 0: Vehicle classname <STRING>
 * 1: Spawner <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["B_Plane_CAS_01_dynamicLoadout_F", player] call AL_fnc_vehicleSpawn;
 *
 * Public: No
 */

if (!isServer) exitWith {
	_this remoteExecCall ["AL_fnc_vehicleSpawn", 2];
};

params ["_vehicleClassname", "_spawner"];

private _spawnPoint = _spawner getVariable ["AL_spawnPoint", [_spawner] call AL_fnc_getSpawnPoint];

// Clear spawn point area.
private _clear = nearestObjects [_spawnPoint, ["AllVehicles"], 25];
{
	deleteVehicle _x;
} forEach _clear;

if (AL_CBA_Loaded) exitWith {
	[{
		params ["_vehicleClassname", "_spawnPoint"];
		// Spawn vehicle and set direction
		private _veh = _vehicleClassname createVehicle (getpos _spawnPoint);
		_veh setDir (getDir _spawnPoint);
		_veh setVariable ["owner", player, true];
		_veh setVariable ["ownerID", clientOwner, true];
		// Clear vehicle cargo
		clearItemCargoGlobal _veh;
		[_veh] remoteExecCall ["AL_fnc_vehicleActions", remoteExecutedOwner];
	}, [_vehicleClassname, _spawnPoint]] call CBA_fnc_execNextFrame;
};

// Spawn vehicle and set direction
private _veh = _vehicleClassname createVehicle (getpos _spawnPoint);
_veh setDir (getDir _spawnPoint);
_veh setVariable ["owner", player, true];
_veh setVariable ["ownerID", clientOwner, true];
// Clear vehicle cargo
clearItemCargoGlobal _veh;
[_veh] remoteExecCall ["AL_fnc_vehicleActions", remoteExecutedOwner];