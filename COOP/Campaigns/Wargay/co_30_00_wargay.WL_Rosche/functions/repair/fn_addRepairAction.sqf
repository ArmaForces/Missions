#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Creates repair action for given entity.
 *
 * Arguments:
 * 0: Unit to add repair action to <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_entity"];

[
    _entity,
    localize "str_state_repair",
    "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa",
    "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa",
    QUOTE([ARR_2(_this,_target)] call FUNC(canRepair)), // Condition show
    "vehicle _this isEqualTo _this && {_this distance _target < 5}", // Condition progress
    FUNC(startRepair), // Code start
    FUNC(progressRepair), // Code progress
    FUNC(completeRepair), // Code completed
    FUNC(interruptedRepair), // Code interrupted,
    [], // Arguments
    1, // Duration (will be changed by codeStart)
    300, // Priority
    false // Remove completed
] call BIS_fnc_holdActionAdd;
