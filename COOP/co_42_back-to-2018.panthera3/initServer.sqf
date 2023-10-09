#include "script_component.hpp"

if (!isNil QUOTE(RESPAWN_HELPER_VR)) then {
    createMarker ["respawn", position RESPAWN_HELPER_VR];
};

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
