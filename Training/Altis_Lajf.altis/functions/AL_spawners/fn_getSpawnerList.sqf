/*
 * Author: 3Mydlo3
 * Function returns spawner list by given vehicle type
 *
 * Arguments:
 * 0: Vehicle type <STRING> ('Air', 'Armored', 'Car', 'Ship')
 *
 * Return Value:
 * 0: spawner list <ARRAY>
 *  0: vehicle name <STRING>
 *  1: vehicle classname <STRING>
 *
 * Example:
 * ["Air"] call AL_fnc_getSpawnerList
 *
 * Public: No
 */

params [["_vehicleType", "All"]];

private _spawnerList = [];
{
	{
		_spawnerList pushBack _x;
	} forEach _x;
} forEach [
	[["<t color='#0000FF'>BLUFOR</t>","Land_GarbageHeap_04_F"]],
	[_vehicleType, WEST] call AL_fnc_getVehiclesFromConfig,
	[["<t color='#FF0000'>OPFOR</t>","Land_GarbageHeap_04_F"]],
	[_vehicleType, EAST] call AL_fnc_getVehiclesFromConfig,
	[["<t color='#00FF00'>INDFOR</t>","Land_GarbageHeap_04_F"]],
	[_vehicleType, INDEPENDENT] call AL_fnc_getVehiclesFromConfig,
	[["<t color='#FF00FF'>CIVILIAN</t>","Land_GarbageHeap_04_F"]],
	[_vehicleType, CIVILIAN] call AL_fnc_getVehiclesFromConfig
];

_spawnerList