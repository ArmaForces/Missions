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
["MDL Wargay", "MDL_WG_UnitInfo", ["Unit Info", "Opens info popup of targeted unit"], {
    _this call FUNC(keyUnitInfo)
}, {}, [DIK_TAB, [false, false, false]]] call CBA_fnc_addKeybind;
