#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Adds experience for kill to crew of shooting vehicle
 *
 * Arguments:
 * 0: Unit shooting <OBJECT>
 * 1: Killed unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_shooter", "_unit"];

private _xpAmount = 1;

{
	private _killedUnits = _x getVariable ["MDL_killedUnits", []];
	_killedUnits pushBack typeOf _unit;
	_x setVariable ["MDL_killedUnits", _killedUnits, true];

	private _currentXp = _x getVariable ["MDL_xp", 0];
	private _newXp = _currentXp + _xpAmount;
	_x setVariable ["MDL_xp", _newXp, true];
	["MDL_xpReceived", [_xpAmount, _newXp], _x] call CBA_fnc_targetEvent;
} forEach crew vehicle _shooter;
