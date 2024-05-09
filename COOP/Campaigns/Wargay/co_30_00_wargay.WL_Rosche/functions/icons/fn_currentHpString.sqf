#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3, veteran29
 * Returns the unit HP in [ ] string representation.
 * Allows specifying optional character for non-damaged squares in case whitespace characters are removed and result doesn't look satisfying.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Optional character for non-damaged squares <STRING>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit"];

private _currentHp = _unit getVariable ["MDL_currentHp", 0];
private _maxHp = _unit getVariable ["MDL_maxHp", MAX_HP];
private _missingHp = _maxHp - _currentHp;

private _string = [];
_string resize [_currentHp, "[ ]"];
_string resize [_maxHp, "[X]"];

_string joinString "" // return
