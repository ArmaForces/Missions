#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Checks if given unit is an emergency service.
 *
 * Arguments:
 * 0: Unit to check <UNIT>
 *
 * Return Value:
 * True if unit is an emergency service <BOOL>
 *
 * Public: No
 */

params ["_unit"];

_unit call FUNC(isCop) || {_unit call FUNC(isMedicalService)}
