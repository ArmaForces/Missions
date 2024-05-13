#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * 
 *
 * Arguments:
 * 
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_vehicle"];

private _markerName = _vehicle getVariable ["MDL_marker", ""];
if (_markerName isEqualTo "") exitWith {};

deleteMarkerLocal _markerName;
_vehicle setVariable ["MDL_marker", nil];
