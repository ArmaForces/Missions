#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Calls emergency services.
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

params ["_target", "_player", "_emergencyParams"];
_emergencyParams params ["_type", ["_includeAmbulance", false]];

private _timeString = daytime call BIS_fnc_timeToString;
private _position = position _player;
private _nearestLocationWithName = [_position] call FUNC(getNearestLocationWithAvailableName);
private _nearestLocationName = [_nearestLocationWithName] call FUNC(getLocationName);

// Show different messages if ambulance is not included in an emergency call
[QGVAR(showEmergencyServicesNotification), [_player, _timeString, _position, _nearestLocationName, _type, _includeAmbulance]] call CBA_fnc_globalEvent;

if (_includeAmbulance) then {
    _player commandChat format [LLSTRING(Emergency_MilitiaAndAmbulanceCalled), localize _type];
} else {
    _player commandChat format [LLSTRING(Emergency_MilitiaCalled), localize _type];
};
