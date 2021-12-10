#include "script_component.hpp"

if (!isNil QUOTE(RESPAWN_HELPER_VR)) then {
    createMarker ["respawn", position RESPAWN_HELPER_VR];
};

["ShotsFired", {
    WEST setFriend [INDEPENDENT, 0];
    INDEPENDENT setFriend [WEST, 0];

    ["PlayersDetected", true] call CBA_fnc_globalEvent;
}] call CBA_fnc_addEventHandler;

["PlayersDetected", {
    params [["_shotsFired", false]];
    playersDetected = true;
    publicVariable "playersDetected";

    if (_shotsFired) exitWith {};
    [{
        WEST setFriend [INDEPENDENT, 0];
        INDEPENDENT setFriend [WEST, 0];
    }, [], random 3] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

// Disable AF Friendly Tracker
["CBA_settingsInitialized", {
    [QAFFTGVAR(enabled), false, 0, "server"] call CBA_settings_fnc_set;
}] call CBA_fnc_addEventHandler;
