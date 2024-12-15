#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Checks if given unit is an engineer.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * True if unit is an engineer <BOOL>
 *
 * Public: No
 */

params ["_unit"];

_unit getUnitTrait "Engineer" isEqualTo 1 || {[_unit] call ACE_repair_fnc_isEngineer}
