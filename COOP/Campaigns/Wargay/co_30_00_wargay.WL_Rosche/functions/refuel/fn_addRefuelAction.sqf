#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Creates refuel action for given entity.
 *
 * Arguments:
 * 0: Unit to add refuel action to <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_entity"];

[
    _entity,
    localize "str_state_refuel",
    "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\refuel_ca.paa",
    "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\refuel_ca.paa",
    QUOTE([ARR_2(_this,_target)] call FUNC(canRefuel)), // Condition show
    QUOTE([ARR_2(_this,_target)] call FUNC(canRefuel)), // Condition progress
    FUNC(startRefuel), // Code start
    FUNC(progressRefuel), // Code progress
    FUNC(completeRefuel), // Code completed
    FUNC(interruptedRefuel), // Code interrupted,
    [], // Arguments
    1, // Duration (will be changed by codeStart)
    298, // Priority
    false // Remove completed
] call BIS_fnc_holdActionAdd;
