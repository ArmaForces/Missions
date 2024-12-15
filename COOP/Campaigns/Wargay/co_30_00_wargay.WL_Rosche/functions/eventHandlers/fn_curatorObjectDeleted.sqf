#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Removes marker of an entity that has been deleted by curator.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_curator", "_entity"];
[_entity] call FUNC(removeVehicleMarker);
