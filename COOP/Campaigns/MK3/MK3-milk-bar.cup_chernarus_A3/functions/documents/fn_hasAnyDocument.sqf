#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Checks if unit has any document like ID or driver license.
 *
 * Arguments:
 * Unit <OBJECT>
 *
 * Return Value:
 * True if has any document <BOOL>
 *
 * Public: No
 */

params ["_unit"];

[_unit] call FUNC(getDocuments) isNotEqualTo []
