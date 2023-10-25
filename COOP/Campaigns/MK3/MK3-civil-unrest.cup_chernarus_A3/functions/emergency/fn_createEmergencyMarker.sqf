#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Creates local marker which decays after few minutes.
 *
 * Arguments:
 * 0: Target (same as 1 as it's self action) IGNORED <UNIT>
 * 1: Player calling action <UNIT>
 * 2: Emergency call parameters <ARRAY>
 *   0: Emergency type name localizable string <STRING> (e.g., accident, robbery)
 *   1: Does emergency call include ambulance unit <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_position", "_markerText"];

private _markerName = format ["emergencyMarker:%1", daytime];

private _emergencyMarker = createMarkerLocal [_markerName, _position];
_emergencyMarker setMarkerTypeLocal "hd_warning";
_emergencyMarker setMarkerColorLocal "ColorOrange";
_emergencyMarker setMarkerTextLocal _markerText;
_emergencyMarker setMarkerSizeLocal [0.5, 0.5];

// Decay marker so it's not confusing if there's too many.
[_emergencyMarker, 2] call FUNC(markerDecay);

_emergencyMarker
