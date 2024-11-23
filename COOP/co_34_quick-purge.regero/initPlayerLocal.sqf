#include "script_component.hpp"

// Disable CUP street lights based on lighting levels (bad performance script)
CUP_stopLampCheck = true;

[{alive player}, {
    // Add action to change view distance and group names
    call FUNC(playerActions);
}, [], -1] call CBA_fnc_waitUntilAndExecute;

["MissionStart", {
    [FUNC(initInfoText), [], 5] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;
