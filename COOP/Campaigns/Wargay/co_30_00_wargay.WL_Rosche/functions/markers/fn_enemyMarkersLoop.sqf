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

if (!GVAR(enemyMarkersEnabled)) exitWith {
    [FUNC(enemyMarkersLoop), [], GVAR(enemyMarkersRefreshRate)] call CBA_fnc_waitAndExecute;
};

private _vehiclesWithMarkers = vehicles select {_x getVariable ["MDL_IsVisible", false]
                && {side effectiveCommander _x isEqualTo EAST}};

private _vehiclesToRemoveMarkers = vehicles select {(_x getVariable ["MDL_marker", ""] isNotEqualTo "")
                && {!(_x getVariable ["MDL_IsVisible", false])}};

{
    private _markerName = _x getVariable ["MDL_marker", ""];
    if (_markerName isEqualTo "") then {
        [_x] call FUNC(createVehicleMarker);
    } else {
        _markerName setMarkerPosLocal (getPosASL _x);
    };
} forEach _vehiclesWithMarkers;

{
    [_x] call FUNC(removeVehicleMarker);
} forEach _vehiclesToRemoveMarkers;

[FUNC(enemyMarkersLoop), [], GVAR(enemyMarkersRefreshRate)] call CBA_fnc_waitAndExecute;