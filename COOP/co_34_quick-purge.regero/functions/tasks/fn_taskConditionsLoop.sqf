#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Loops through conditions for tasks one per second and raises apropriate server event if condition is true.
 *
 * Arguments:
 * 0: Conditions with events [ARRAY]
 *   N: [ARRAY]
 *     0: Condition [CODE]
 *     1: Event name [STRING]
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#define CONDITIONS_CHECK_INTERVAL 1
#define NO_CONDITIONS_RECHECK_INTERVAL 15

params [["_conditionsWithEvents", []]];

if (_conditionsWithEvents isEqualTo []) then {
    //systemChat "Reloading conditions";
    _conditionsWithEvents = +GVAR(conditionsWithEvents);
};

if (_conditionsWithEvents isEqualTo []) exitWith {
    //systemChat "No conditions to check";
    [FUNC(taskConditionsLoop), [], NO_CONDITIONS_RECHECK_INTERVAL] call CBA_fnc_waitAndExecute;

    nil
};

//systemChat format ["Conditions with events: %1", _conditionsWithEvents];
private _item = _conditionsWithEvents deleteAt 0;

_item params ["_condition", "_eventName", ["_conditionArguments", []]];
//systemChat format ["Condition: %1", _condition];

if (_conditionArguments call _condition) then {
    //systemChat format ["Condition true, raising %1 event.", _eventName];
    [_eventName] call CBA_fnc_serverEvent;
    GVAR(conditionsWithEvents) = GVAR(conditionsWithEvents) - [_item];
};

[FUNC(taskConditionsLoop), [_conditionsWithEvents], CONDITIONS_CHECK_INTERVAL] call CBA_fnc_waitAndExecute;

nil