#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Initializes all tasks serverside events
 *
 * Example:
 * call afp_scripts_fnc_tasksServerEvents
 *
 * Public: No
 */

if (!hasInterface) exitWith {};

// Event handlers for RTB actions
["RTBTime", {
	["RTBOrdered"] call CBA_fnc_localEvent;
}] call CBA_fnc_addEventHandler;

["RTBOrdered", {
	GVAR(RTBEndAction) = [satPhone, LLSTRING(FinishRTB), "", "",
		"_this distance _target < 3",
		QUOTE(_caller in (call FUNC(getHighestRankedPlayers))),
		{}, {}, {
			["RTBSuccessful", _this select 0] call CBA_fnc_globalEvent;
		}, {
			titleText ["Użyć tego mogą tylko żywe osoby najwyższe stopniem.", "PLAIN DOWN", 0.1];
		}, [], 3, 0, true, false] call BIS_fnc_holdActionAdd;
}] call CBA_fnc_addEventHandler;

["RTBSuccessful", {
	[_this, GVAR(RTBEndAction)] call BIS_fnc_holdActionRemove;
}] call CBA_fnc_addEventHandler;

if (!("RTB" in ([player] call BIS_fnc_tasksUnit))) then {
	// Add and removal of RTB task force action
	GVAR(RTBStartAction) = [
		satPhone, LLSTRING(StartRTB), "", "",
		"_this distance _target < 3",
		QUOTE(_caller in (call FUNC(getHighestRankedPlayers))),
		{}, {}, {
			["RTBOrdered", _this select 0] call CBA_fnc_globalEvent;
		}, {
			titleText ["Użyć tego mogą tylko żywe osoby najwyższe stopniem.", "PLAIN DOWN", 0.1];
		}, [], 3, 0, true, false] call BIS_fnc_holdActionAdd;

	["RTBOrdered", {
		[_this, GVAR(RTBStartAction)] call BIS_fnc_holdActionRemove;
	}] call CBA_fnc_addEventHandler;
} else {
	// Add and removal of RTB end action
	["RTBOrdered"] call CBA_fnc_localEvent;
};
