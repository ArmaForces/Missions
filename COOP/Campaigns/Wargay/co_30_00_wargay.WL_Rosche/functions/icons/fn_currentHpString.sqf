#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
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

params ["_unit", ["_nonDamagedMark", "_"]];

private _currentHp = _unit getVariable ["MDL_currentHp", 0];
private _maxHp = _unit getVariable ["MDL_maxHp", MAX_HP];
private _missingHp = _maxHp - _currentHp;

// BUG: Doesn't work properly when 0 HP
private _string = "";
for "_a" from 1 to round _currentHp do {
	_string = _string + "[" + _nonDamagedMark + "]";
};
for "_a" from 1 to round _missingHp do {
	_string = _string + "[X]";
};
    
_string
