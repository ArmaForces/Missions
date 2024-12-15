#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Checks if given target is known to at least one unit.
 *
 * Arguments:
 * 0: Object to check if anyone knows about it <OBJECT>
 *
 * Return Value:
 * True if at least one unit knows about the target <BOOL>
 *
 * Public: No
 */

params ["_target", ["_side", WEST]];

private _anyoneKnowsAbout = groups _side findIf {leader _x targetKnowledge _target select 0} != -1;

_anyoneKnowsAbout
