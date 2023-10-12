#include "script_component.hpp"

GVAR(respawnAvailableTimeInMinutes) = 100;

if (!isNil QUOTE(RESPAWN_HELPER_VR)) then {
    createMarker ["respawn", position RESPAWN_HELPER_VR];
};

["RespawnAfterTaskCompleted", {
    // Check if respawn is still enabled
    if (CBA_missionTime > GVAR(respawnAvailableTimeInMinutes) * 60) exitWith {};

    ["afm_respawn_force"] call CBA_fnc_serverEvent;
}] call CBA_fnc_addEventHandler;

["AirportIntelFound", {
    "transport_town" setMarkerPos (getMarkerPos "transport_town_empty");
    "transport_island" setMarkerPos (getMarkerPos "transport_island_empty");
}] call CBA_fnc_addEventHandler;

["AmmoRetrieved", {
    deleteMarker "transport_town";
    deleteMarker "transport_town_empty";
}] call CBA_fnc_addEventHandler;

["CommsCenterSecured", {
    deleteMarker "marker_3";
}] call CBA_fnc_addEventHandler;

["IslandShutdownPower", {
    GVAR(blackout) = true;
    publicVariable QGVAR(blackout);
    [true] call FUNC(blackout);
}] call CBA_fnc_addEventHandler;
