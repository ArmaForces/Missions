#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 *
 *
 * Arguments:
 * Child action nodes <ARRAY>
 *   0: Action name <STRING>
 *   1: Visible name <STRING>
 *   2: Action on select <FUNC>
 *   3: Child actions to show <FUNC> (Optional)
 *
 * Return Value:
 * Created actions <ARRAY>
 *
 * Public: No
 */

params ["_childNodes"];

private _actions = [];

{
    _x params ["_actionName", "_visibleName", "_callActionFunc", ["_actionParams", []], ["_childActions", {}]];

    private _action = [_actionName, _visibleName, "", _callActionFunc, {true}, _childActions, _actionParams] call ACEFUNC(interact_menu,createAction);

    _actions pushBack [_action, [], _target];
} forEach _childNodes;

_actions
