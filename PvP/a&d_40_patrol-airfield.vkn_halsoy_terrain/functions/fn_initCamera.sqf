#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function initializes AR-2 Darter as a static camera.
 *
 * Arguments:
 * 0: Darter
 *
 * Return Value:
 * None
 *
 * Example:
 * [this] call afsg_patrol_fnc_initCamera;
 *
 * Public: No
 */

params ["_drone", ["_cameraName", ""]];

if (!isServer) exitWith {};

private _cone = createVehicle ["RoadCone_F", position _drone, [], 0, "CAN_COLLIDE"];
_cone setDir getDir _drone;
_cone hideObjectGlobal true;
_cone enableSimulationGlobal false;
_drone attachTo [_cone];

// Set name
if (_cameraName isEqualTo "") then {
	private _nearestMarkers = allMapMarkers apply {[_drone distance getMarkerPos _x, _x]};
	_nearestMarkers sort true;
	private _nearestMarker = _nearestMarkers select 0 select 1;
	_cameraName = markerText _nearestMarker;
};

_drone setGroupIdGlobal [_cameraName];
