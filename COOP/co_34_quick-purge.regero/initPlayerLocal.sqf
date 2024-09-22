#include "script_component.hpp"

// Disable CUP street lights based on lighting levels (bad performance script)
CUP_stopLampCheck = true;

[{alive player}, {
    // Add action to change view distance and group names
    call FUNC(playerActions);
}, [], -1] call CBA_fnc_waitUntilAndExecute;
