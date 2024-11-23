/*
 * Author: 3Mydlo3
 * Function deletes given vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * None
 *
 * Public: No
 */

params ["_vehicle"];

if (isNil "_vehicle") exitWith {};

private _className = typeOf _vehicle;
private _displayName = getText (configFile >>  "CfgVehicles" >>	_className >> "displayName");
private _ownerID = _vehicle getVariable ["ownerID", 2];

private _reason = if (!alive _vehicle) then {
	"zniszczenia"
} else {
	"opuszczenia"
};
diag_log format ["Removing %1 at %2", _vehicle, serverTime];
deleteVehicle _vehicle;

private _msg = format ["Usunięto %1 z powodu %2.", _displayName, _reason];
[_msg] remoteExec ["systemChat", _owner];