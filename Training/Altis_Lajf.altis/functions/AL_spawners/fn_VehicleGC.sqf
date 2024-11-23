/*
 * Author: 3Mydlo3
 * Function checks all vehicles if vehicle was destroyed or abandoned and deletes it.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * None
 *
 * Public: No
 */

params [["_vehiclesList", vehicles, [[]]]];

if (_vehiclesList isEqualTo []) then {
	_vehiclesList = vehicles;
};

private _vehicle = _vehiclesList deleteAt 0;

if (isNil "_vehicle") exitWith {};

private _owner = _vehicle getVariable ["owner", objNull];

if (_owner isEqualTo objNull) exitWith {
	_vehicle call AL_fnc_deleteVehicle;
};

if (!(alive _vehicle)) exitWith {
	[{_this call AL_fnc_deleteVehicle}, [_vehicle], random [15, 20, 30]] call CBA_fnc_waitAndExecute;
};

private _lastUsed = _vehicle getVariable ["lastUsed", serverTime];
if ((serverTime - _lastUsed) > 90) exitWith {
	_vehicle call AL_fnc_deleteVehicle;
};

if ((_owner in crew _vehicle) || {_owner distance _vehicle < 100}) then {
	_vehicle setVariable ["lastUsed", serverTime];
};

[AL_fnc_vehicleGC, [_vehiclesList], 1] call CBA_fnc_waitAndExecute;