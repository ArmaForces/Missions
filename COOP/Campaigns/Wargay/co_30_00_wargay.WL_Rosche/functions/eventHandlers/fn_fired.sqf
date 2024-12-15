#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * 
 *
 * Arguments:
 * "Fired" EH params
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

// if (!local _unit) exitWith {};
_projectile setVariable ["MDL_initialVelocity", velocity _projectile];

// We don't care about AIs
if !(isPlayer _unit) exitWith {};

_unit setVariable ["MDL_lastCombatActive", CBA_missionTime];
