#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Initializes all tasks serverside events
 *
 * Example:
 * call afp_scripts_fnc_tasksServerEvents
 *
 * Public: No
 */

if (!isServer) exitWith {};

// OPFOR died
[{
    allPlayers select {
        side _x isEqualTo EAST
        && {alive _x}
    } isEqualTo []
    && {!GVAR(gameEnded)}
}, {
    [QGVAR(endGame), [OPFOR_DIED]] call CBA_fnc_localEvent;
}] call CBA_fnc_waitUntilAndExecute;


[QGVAR(endGame), {
    params ["_endType"];
    switch (_endType) do {
        case OPFOR_DIED: {
            
        };
        default {};
    };
}] call CBA_fnc_addEventHandler;