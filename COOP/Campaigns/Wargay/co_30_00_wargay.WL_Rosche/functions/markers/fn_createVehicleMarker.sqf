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

_markerName = format ["MDL_EnemyVehicle_%1", str _vehicle];
createMarkerLocal [_markerName, getPosATL _vehicle];
_vehicle setVariable ["MDL_marker", _markerName];

_markerName setMarkerColorLocal "ColorEAST";
_markerName setMarkerSizeLocal [0.7, 0.7];

private _markerType = _vehicle getVariable ["MDL_markerType", ""];
if (_markerType isEqualTo "") then {
    _markerType = [_vehicle, "markerType"] call FUNC(getVehicleInfo);
    _vehicle setVariable ["MDL_markerType", _markerType];
};
_markerName setMarkerTypeLocal _markerType;

_markerName
