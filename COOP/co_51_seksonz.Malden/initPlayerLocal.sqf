#include "script_component.hpp"

// Disable CUP street lights based on lighting levels (bad performance script)
CUP_stopLampCheck = true;

[{alive player}, {
    // Dodanie akcji do zmiany odległości widzenia oraz nazw drużyn
    call AF_fnc_playerActions;
    player addItem "ACE_EarPlugs";
}, [], -1] call CBA_fnc_waitUntilAndExecute;

// if (headgear player isEqualTo "sfp_m37w_helmet_un") then {
//     [player] call FUNC(callComply);
// };

// Actions to remove obstacles from road
// Faster for logistic guys
private _actionDuration = if ((player getVariable ["ACE_IsEngineer", 0]) >= 2) then {10} else {60};
{
    [_x, LLSTRING(Remove_Garbage), "", "",
    "_this distance _target < 3",
    "_this distance _target < 3",
    {}, {}, {
    	deleteVehicle (_this select 0);
    }, {}, [], _actionDuration, 0, true, false] call BIS_fnc_holdActionAdd;
} forEach roadblock_items;


// ural_rearm addAction [
//     LLSTRING(Rearm), 
//     {
//         params ["_target", "_caller", "_actionId", "_arguments"];
//         [_target] call AF_fnc_casRearmOpen;
//     },
//     [],
//     10, 
//     true, 
//     true, 
//     "",
//     "true",
//     2,
//     false,
//     "",
//     ""
// ];