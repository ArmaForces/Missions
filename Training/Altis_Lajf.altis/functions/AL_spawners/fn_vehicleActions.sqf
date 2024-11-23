/*
 * Author: 3Mydlo3
 * Function adds custom actions to vehicle
 *
 * Arguments:
 * 0: Vehicle to add actions to <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle player] call AL_fnc_vehicleActions
 *
 * Public: No
 */

params ["_vehicle"];

private _vehicleActions = [];
if (_vehicle isKindOf "Helicopter") then {
	private _action = _vehicle addAction ["<t color='#FF0000'>Crash test ENG</t>", {
		(_this select 0) setHitPointDamage ["hitEngine", 1.0];
	}, {}, 0, true, true, "", "true", 15];
	_vehicleActions pushback _action;
	private _action = _vehicle addAction ["<t color='#FF0000'>Crash test ATRQ</t>", {
		(_this select 0) setHitPointDamage ["hitVRotor", 1.0];
	}, {}, 0, true, true, "", "true", 15];
	_vehicleActions pushback _action;
};
private _action = _vehicle addAction ["<t color='#FF0000'>Crash test EXTREME</t>", {
	(_this select 0) setdamage 0.9;
}, {}, 0, true, true, "", "true", 15];
_vehicleActions pushback _action;
private _action = _vehicle addAction ["<t color='#00CC00'>Napraw pojazd</t>", {
	(_this select 0) setdamage 0;
	(_this select 0) setfuel 1;
}, {}, 0, true, true, "", "true", 15];

_vehicle addAction ["Usuń akcje z pojazdu", {
	{
		(_this select 0) removeAction _x;
	} forEach (_this select 3);
	(_this select 0) removeAction (_this select 2);
}, _vehicleActions, 1, true, true, "", "true", 15];