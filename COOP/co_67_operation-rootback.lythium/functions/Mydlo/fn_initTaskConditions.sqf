#define IN_AREA(MARKER, RADIUS, UNITS_ARRAY) (UNITS_ARRAY inAreaArray [getMarkerPos MARKER, RADIUS, RADIUS]) isEqualTo UNITS_ARRAY
IDAP_Guys = [idap_man_1, idap_man_2, idap_man_3];


// Oficerowie i szpieg
[{!alive officer_tak}, {
	["t_officer_tak","FAILED"] call BIS_fnc_taskSetState;
}, [], -1] call CBA_fnc_waitUntilAndExecute;
[{!alive officer_gue}, {
	["t_officer_gue","CANCELED"] call BIS_fnc_taskSetState;
}, [], -1] call CBA_fnc_waitUntilAndExecute;
[{!alive spy}, {
	["t_spy","FAILED"] call BIS_fnc_taskSetState;
}, [], -1] call CBA_fnc_waitUntilAndExecute;

// IDAPowcy umarli
[{!alive idap_man_1}, {
	IDAP_Guys = IDAP_Guys - [idap_man_1];
}, [], -1] call CBA_fnc_waitUntilAndExecute;
[{!alive idap_man_2}, {
	IDAP_Guys = IDAP_Guys - [idap_man_2];
}, [], -1] call CBA_fnc_waitUntilAndExecute;
[{!alive idap_man_3}, {
	IDAP_Guys = IDAP_Guys - [idap_man_3];
}, [], -1] call CBA_fnc_waitUntilAndExecute;
[{(count IDAP_Guys == 0)}, {
	if (isNil 'idap_rescued') exitWith {
		["t_idap","FAILED"] call BIS_fnc_taskSetState;
	};
}, [], -1] call CBA_fnc_waitUntilAndExecute;

// IDAPowcy uratowani
[{IN_AREA('sys_base', 15, IDAP_Guys)}, {
	if (count IDAP_Guys == 0) exitWith {};
	["t_idap","SUCCEEDED"] call BIS_fnc_taskSetState;
	idap_rescued = true;
}, [], -1] call CBA_fnc_waitUntilAndExecute;