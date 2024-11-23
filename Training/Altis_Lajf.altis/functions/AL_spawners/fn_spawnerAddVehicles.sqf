/*
 * Author: 3Mydlo3
 * Adds vehicles that should be unlocked to vehicle spawn actions list.
 *
 * Arguments:
 * 0: object which has spawn action assigned <OBJECT>
 * 1: spawnable vehicles <ARRAY>
 *  0: vehicle name <STRING>
 *  1: vehicle classname <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, ["B_Plane_CAS_01_dynamicLoadout_F", "I_Plane_Fighter_03_dynamicLoadout_F"]] call AL_fnc_spawnerAddVehicles;
 *
 * Public: No
 */

params ["_spawner", "_vehicles"];

{
	private _vehicleName = _x select 0;
	private _vehicleClassname = _x select 1;
	// Add action to _spawner that spawns _vehicle_classname.
	_spawner addAction [_vehicleName, {
		private _spawner = _this select 0;
		private _vehicleClassname = _this select 3;
		[_vehicleClassname, _spawner] remoteExecCall ["AL_fnc_vehicleSpawn", 2];
	}, _vehicleClassname, 6, true, true, "", "true", 2];
} forEach _vehicles;