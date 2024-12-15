#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Checks if TAB is pressed and shows targeted unit info.
 *
 * Arguments:
 * 0: Main display <DISPLAY>
 * 1: Key pressed <NUMBER>
 * 2: Is SHIFT pressed <BOOL>
 * 3: Is CTRL pressed <BOOL>
 * 4: Is ALT pressed <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];

private _cursorTarget = cursorTarget;
if (_cursorTarget isEqualTo objNull) exitWith {};

[_cursorTarget] call FUNC(showUnitInfo);
