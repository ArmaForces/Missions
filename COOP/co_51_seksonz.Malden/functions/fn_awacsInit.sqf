#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Handles AWACS system initialization
 *
 * Example:
 * call afp_scripts_fnc_awacsInit
 *
 * Public: No
 */

#define GROUPS ["Zeus", "HQ", "November", "Hotel"]

if (hasInterface) then {
    [QGVAR(awacsObjectDetected), {
        params ["_object"];
        if (!(groupId group player in GROUPS)) exitWith {};
        INFO("Object detected!");

        // Get vehicle data from namespace
        private _vehicleData = GVAR(AWACSData) getVariable [str _object, objNull];
        if (isNull _vehicleData) then {
            _vehicleData = call CBA_fnc_createNamespace;
            GVAR(AWACSData) setVariable [str _object, _vehicleData];
            _vehicleData setVariable ["typeName", getText (configFile >> "CfgVehicles" >> typeOf _object >> "displayName")]
        };

        private _vehiclePosiion = getPosATL _object;
        private _vehicleName = _vehicleData getVariable "typeName";
        // Place marker on object's position
        private _vehicleMarker = _vehicleData getVariable ["markerName", ""];
        if (_vehicleMarker isEqualTo "") then {
            _vehicleMarker = createMarkerLocal [str _object, _vehiclePosition];
            _vehicleMarker setMarkerTypeLocal ([_object] call afft_friendly_tracker_fnc_getVehicleMarkerType);
        } else {
            _vehicleMarker setMarkerAlphaLocal 1;
            _vehicleMarker setMarkerPosLocal _vehiclePosition;
        };

        // Prepare marker message
        INFO("Creating marker");
        private _text = format ["%5: %1 | Alt: %2 | Spd: %3 | Hdg: %4",
            _vehicleName,
            floor (_vehiclePosition select 2),
            speed _object,
            getDir _object,
            [daytime] call BIS_fnc_timeToString];
        _vehicleMarker setMarkerTextLocal _text;

        // Send sideChat message
        private _playerPosition = position player;
        private _relDir = floor([_playerPosition, _vehiclePosition] call BIS_fnc_relativeDirTo);
        private _distance = floor((_playerPosition distance _vehiclePosition)/100)/10;
        private _sideChatMsg = format [LSTRING(AWACS_DetectedMessage), _vehicleName, _relDir, _distance];
        INFO("Sending message");
        GVAR(AWACS) sideChat _sideChatMsg;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(awacsObjectDisappeared), {
        params ["_object"];
        if (!(groupId group player in GROUPS)) exitWith {};
        INFO("Object lost!");

        // Get vehicle data from namespace or leave if not initialized
        private _vehicleData = GVAR(AWACSData) getVariable [str _object, objNull];
        if (isNull _vehicleData) exitWith {};

        private _vehicleMarker = _vehicleData getVariable "markerName";

        // If object crashed/died, remove marker (won't happen if object wasn't visible in last scan as event won't trigger)
        if (!alive _object) exitWith {deleteMarkerLocal _vehicleMarker};

        // Start marker decay
        [_vehicleMarker, 0.1] call FUNC(markerDecayLoop);
    }] call CBA_fnc_addEventHandler;
};

if (!(groupId group player in GROUPS)) exitWith {};

// Initialize data namespace
GVAR(AWACSData) = call CBA_fnc_createNamespace;

[] call FUNC(awacsLoop);

INFO("Loop initialized");
