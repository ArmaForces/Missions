#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Zmienia nazwę lokacji najbliżej wskazanego markera.
 *
 * Arguments:
 * 0: Location marker (e.g. editor placed) [STRING]
 * 1: New name of given location [STRING]
 *
 * Return Value:
 * Success or failure [BOOL]
 *
 * Public: No
 */

params [["_locationMarker", ""], ["_newLocationName", objNull]];

if (_locationMarker isEqualTo "") exitWith { false };
if (_newLocationName isEqualTo objNull || {!(_newLocationName isEqualType "")}) exitWith { false };

private _markerPosition = getMarkerPos _locationMarker;

if (_markerPosition isEqualTo [0, 0, 0]) exitWith { false };

if (!hasInterface) exitWith {
	[_locationMarker, _newLocationName] remoteExecCall [QFUNC(renameLocation), 2];
	true
};

private _renameFnc = {
	params ["_position", "_newLocatioName"];
	systemChat format ["%1", _this];
	private _mapLocation = nearestLocation [_position, ""];
	private _oldLocationName = text _mapLocation;
	private _editableLocation = createLocation [_mapLocation];

	_editableLocation setText _newLocatioName;

	true
};

[_markerPosition, _newLocationName] call _renameFnc
