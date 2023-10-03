#define GET_TASK_MARKER(TASK)  								(TASK select 3)
#define GET_TASK_MARKER_POS(TASK)							if (GET_TASK_MARKER(TASK)!="") then { getMarkerPos GET_TASK_MARKER(TASK) }
#define GET_TASK_DESCRIPTION(TASK) 							[TASK select 2, TASK select 1, TASK select 3]
#define CREATE_MAIN_TASK(TARGET, TASK, STATUS, ICON)		[TARGET, TASK select 0, GET_TASK_DESCRIPTION(TASK), GET_TASK_MARKER_POS(TASK), STATUS, 10, false, ICON] call BIS_fnc_taskCreate;
#define CREATE_TASK(TARGET, MAIN_TASK, TASK, STATUS, ICON)	[TARGET, [TASK select 0, MAIN_TASK select 0], GET_TASK_DESCRIPTION(TASK), GET_TASK_MARKER_POS(TASK), STATUS, 10, false, ICON] call BIS_fnc_taskCreate;

if (!isServer) exitwith {};

// Assign tasks to independent/west and zeus
_Blufor = [west, units group zeus];

#include "tasks.sqf"

/*
	BLUFOR TASKS
*/

CREATE_MAIN_TASK(_Blufor, _t_main, "CREATED", "search")

CREATE_TASK(_Blufor, _t_main, _t_nuke, "CREATED", "danger")
CREATE_TASK(_Blufor, _t_main, _t_spy, "CREATED", "listen")
CREATE_TASK(_Blufor, _t_main, _t_idap, "CREATED", "heal")
CREATE_TASK(_Blufor, _t_main, _t_officer_gue, "CREATED", "rifle")
CREATE_TASK(_Blufor, _t_main, _t_officer_tak, "CREATED", "target")