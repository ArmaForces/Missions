#include "script_component.hpp"

[{alive player}, {
    // Add action to change view distance and group names
    call FUNC(playerActions);
}, [], -1] call CBA_fnc_waitUntilAndExecute;
