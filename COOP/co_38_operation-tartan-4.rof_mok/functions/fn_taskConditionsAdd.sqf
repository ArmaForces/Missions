#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Adds condition and event to array.
 *
 * Arguments:
 * 0: Condition [CODE]
 * 1: Event name [STRING]
 *
 * Return Value:
 * Index of inserted element [NUMBER]
 *
 * Public: No
 */

params ["_condition", "_eventName", ["_conditionArguments", []]];

systemChat format ["%1 - %2 : %3", _conditionArguments, _condition, _eventName];

GVAR(conditionsWithEvents) pushBackUnique _this;
