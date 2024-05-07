#include "script_component.hpp"

// Disable CUP street lights based on lighting levels (bad performance script)
CUP_stopLampCheck = true;

[{alive player}, {
    // Dodanie akcji do zmiany odległości widzenia oraz nazw drużyn
    call FUNC(playerActions);
}, [], -1] call CBA_fnc_waitUntilAndExecute;

// Register a simple keypress to an action
#include "\a3\ui_f\hpp\defineDIKCodes.inc"

// Handle "Info" button
[
    "MDL Wargay",
    "MDL_WG_UnitInfo",
    ["Unit Info", "Opens info popup of targeted unit"],
    FUNC(keyUnitInfo),
    {},
    [DIK_TAB, [false, false, false]]
] call CBA_fnc_addKeybind;

["MDL_showCurrentHp", {
    if (vehicle player isEqualTo player) exitWith {};
    call FUNC(updateHitpointsDisplay);
}] call CBA_fnc_addEventHandler;

["MDL_rearmVehicle", FUNC(rearmVehicle)] call CBA_fnc_addEventHandler;
