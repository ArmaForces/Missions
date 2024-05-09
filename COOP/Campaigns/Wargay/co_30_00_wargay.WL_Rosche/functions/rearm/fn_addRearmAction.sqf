#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Creates rearm action for given entity.
 *
 * Arguments:
 * 0: Unit to add rearm action to <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_entity"];

// TODO For never: Rearming one by one/mag by mag
[
    _entity,
    localize "str_state_rearm",
    "\A3\ui_f\data\igui\cfg\simpleTasks\types\rearm_ca.paa",
    "\A3\ui_f\data\igui\cfg\simpleTasks\types\rearm_ca.paa",
    QUOTE([ARR_2(_this,_target)] call FUNC(canRearm)), // Condition show
    QUOTE([ARR_2(_this,_target)] call FUNC(canRearm)), // Condition progress
    {}, // Code start
    {}, // Code progress
    FUNC(completeRearm), // Code completed
    FUNC(interruptedRearm), // Code interrupted,
    [], // Arguments
    20, // Duration (will be changed by codeStart)
    299, // Priority
    false // Remove completed
] call BIS_fnc_holdActionAdd;
