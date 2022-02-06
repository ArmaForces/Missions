#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function changes unit's side.
 *
 * Arguments:
 * 0: Unit to change it's side <OBJECT>
 * 1: Desired side <SIDE>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, EAST] call afsg_patrol_fnc_changeSide
 *
 * Public: No
 */

params ["_unit", "_newSide"];

private _emptyGroup = createGroup [_newSide, true];
[_unit] join _emptyGroup;