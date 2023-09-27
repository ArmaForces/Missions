#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Checks if unit is from resistance.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Is a resistance unit <BOOL>
 *
 * Public: No
 */

params ["_unit"];

side _unit isEqualTo RESISTANCE || {_unit getVariable [QGVAR(isResistance), false]}
