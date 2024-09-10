#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Forces unit to holster weapon
 *
 * Arguments:
 * 0: Unit <UNIT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit"];

if (!local _unit) exitWith {};

_unit action ['SwitchWeapon', _unit, _unit, 100];

nil