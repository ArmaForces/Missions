#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Check whether ACE_G_M14 is in the area
 *
 * Arguments:
 * Area <TRIGGER>
 *
 * Return Value:
 * True if any incendiary grenade is burning in the area <BOOL>
 *
 * Public: No
 */

params ["_area"];

private _triggerArea = triggerArea _area;
private _longerSide = (_triggerArea select 0) max (_triggerArea select 1);

private _objects = _area nearObjects ["ACE_G_M14", _longerSide];

// systemChat format ["Objects nearby: %1", _area nearObjects _longerSide];
// systemChat format ["Found grenade objects: %1", _objects];

_objects
    select {velocity _x isEqualTo [0, 0, 0]}
    findIf {_x inArea _area} != -1
