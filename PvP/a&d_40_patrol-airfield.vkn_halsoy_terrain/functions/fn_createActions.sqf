#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function creates actions for role assignment.
 *
 * Arguments:
 * 0: Teleporter <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_flag] call afsg_patrol_fnc_createActions
 *
 * Public: No
 */

params ["_flag"];


private _roleActionsIDs = [];
{
    private _roleName = _x select 0;

    private _roleActionID = _flag addAction [_roleName, {
        [QGVAR(assignRole), [_this select 1, _this select 3 select 0]] call CBA_fnc_serverEvent;
    }, [_roleName]];

    _roleActionsIDs pushBack _roleActionID;
} forEach GVAR(availableRoles);

_flag setVariable [QGVAR(roleActionsIDs), _roleActionsIDs];