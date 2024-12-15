#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Returns all vehicles in possesion of given group.
 *
 * Arguments:
 * 0: Group <GROUP>
 *
 * Return Value:
 * List of unique vehicles <ARRAY<OBJECT>>
 *
 * Public: No
 */

params ["_group"];

private _groupVehicles = units _group apply { vehicle _x } select {_x isKindOf "AllVehicles"};
_groupVehicles arrayIntersect _groupVehicles