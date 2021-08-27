#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Makes unit join group with given callsign when joined server.
 * If such group doesn't exists then create it.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Name of group to join <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player ,"Alpha"] call afp_scripts_fnc_joinGroup
 *
 * Public: No
 */

params ["_unit", "_groupName"];

if (!local _unit) exitWith {};

private _group = missionNamespace getVariable [_groupName, grpNull];

if (isNull _group) then {
	_group = createGroup side _unit;
	missionNamespace setVariable [_groupName, _group];
};

[_unit] joinSilent _group;