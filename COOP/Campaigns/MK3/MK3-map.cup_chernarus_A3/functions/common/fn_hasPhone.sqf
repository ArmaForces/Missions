#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Checks if unit has phone.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Unit has phone <BOOL>
 *
 * Public: No
 */

params ["_unit"];

"ACE_Cellphone" in items _unit
