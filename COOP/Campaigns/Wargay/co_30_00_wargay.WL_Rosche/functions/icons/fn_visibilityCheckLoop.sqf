#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Loop checking all enemy units one by one.
 * Switches off icons for units that no friendly unit knows about anymore.
 *
 * Arguments:
 * 0: Targeted object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params [["_targetsToCheck", []]];

if (_targetsToCheck isEqualTo []) then {
	_targetsToCheck = vehicles select {side effectiveCommander _x isEqualTo EAST};
};
if (_targetsToCheck isEqualTo []) exitWith {
	[FUNC(visibilityCheckLoop), [], 5] call CBA_fnc_waitAndExecute;
};

private _target = _targetsToCheck deleteAt (count _targetsToCheck - 1);

#ifdef DEV_DEBUG
diag_log format ["WARGAY DEBUG VISIBILITY CHECK [%1]: Checking Target %2", diag_tickTime, _target];
#endif

private _shouldBeVisible = [_target] call FUNC(shouldStillBeVisible);
private _isVisible = _target getVariable ["MDL_IsVisible", false];
if (_isVisible && {!_shouldBeVisible}) then {
    #ifdef DEV_DEBUG
    diag_log format ["WARGAY DEBUG VISIBILITY CHECK [%1]: Making Target %2 not visible", diag_tickTime, _target];
    #endif
	_target setVariable ["MDL_IsVisible", false, false];
};

[FUNC(visibilityCheckLoop), [_targetsToCheck], 1] call CBA_fnc_waitAndExecute;
