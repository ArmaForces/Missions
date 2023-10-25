#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Checks if unit is cop.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Is a cop unit <BOOL>
 *
 * Public: No
 */

params ["_unit"];

[_unit] call FUNC(isMilitia)
