#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Initializes infantry units to work with custom damage model.
 * Prevents taking damage when in vehicle
 *
 * Arguments:
 * Nonede
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_entity"];

_entity addEventHandler ["HandleDamage", FUNC(handleDamageMan)];
