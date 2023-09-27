#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Shows reported emergency message to emergency service and Zeus.
 *
 * Arguments:
 * 0: Unit reporting emergency <UNIT>
 * 1: Formatted time of emergency report <STRING>
 * 2: Position of emergency <POSITION>
 * 3: Name of nearest location used for report <STRING>
 * 4: Localizable name of emergency type <STRING> (e.g., accident, robbery)
 * 5: Does emergency require medical help <BOOL> (Optional, false by default)
 *
 * Return Value:
 * None
 *
 * Public: No
 */

if (!(player call FUNC(hasPhone))) exitWith {};

if (player call FUNC(isEmergencyService) || {!isNull getAssignedCuratorLogic player}) then {
    params ["_unit", "_time", "_position", "_nearestLocationName", "_emergencyTypeName", ["_needsAmbulance", false]];

    private _localizedEmergencyTypeName = localize _emergencyTypeName;

    private _emergencyMessage = format [LLSTRING(EmergencyMessage), _localizedEmergencyTypeName, _nearestLocationName, _time];
    if (_needsAmbulance) then {
        _emergencyMessage = format ["%1 %2", _emergencyMessage, LLSTRING(Emergency_AmbulanceNeeded)];
    };

    _unit customChat [GVAR(emergencyNetId), _emergencyMessage];

    private _markerText = format [LLSTRING(EmergencyMarker), name _unit, _localizedEmergencyTypeName, _time];
    [_position, _markerText] call FUNC(createEmergencyMarker);
};
