#include "script_component.hpp"

if (!isNil QUOTE(RESPAWN_HELPER_VR)) then {
    createMarker ["respawn", position RESPAWN_HELPER_VR];
};

["MissionStart", {
    setTimeMultiplier 1;
    ["USAF_RQ4A"] call FUNC(initializeUAV);
}] call CBA_fnc_addEventHandler;

setTimeMultiplier 0.1;
