{
	if !(_x call BIS_fnc_taskCompleted) then {
		[_x, "CANCELED"] call BIS_fnc_taskSetState;
	};
} forEach (zeus call BIS_fnc_tasksUnit);