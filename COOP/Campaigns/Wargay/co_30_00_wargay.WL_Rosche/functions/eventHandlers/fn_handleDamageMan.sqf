#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Overrides damage handler to ignore default engine damage handling.
 *
 * Arguments:
 * "HandleDamage" EH params
 *
 * Return Value:
 * Damage taken by the unit if overriden <NUMBER/NOTHING>
 *
 * Public: No
 */

params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit", "_context"];

if (vehicle _unit isEqualTo _unit) exitWith {};

damage _unit
