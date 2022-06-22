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

if (!isServer) exitWith {};

["RTBSuccessful", {
	// Check if enough civilians were rescued
	"Success" call BIS_fnc_endMissionServer;
	// And if graves were found.
}] call CBA_fnc_addEventHandler;

[{CBA_missionTime >= 0.2}, {
	call FUNC(airThreatsLoop);
}, [], 3600] call CBA_fnc_waitUntilAndExecute;

["OfficerStart", {
	[{!alive cro_general}, {
		[{
			["OfficerDied"] call CBA_fnc_serverEvent;
		}, [], random 30] call CBA_fnc_waitAndExecute;
	}] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_addEventHandler;
