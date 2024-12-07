if (!hasInterface) exitWith {};
maxviewdistance = 15000;

fnc_setviewgui = {
	disableSerialization;
	createDialog "view_distance_settings";
	waitUntil {!isNull (findDisplay 10);};
	ctrlSetText [311, str viewdistance];
};
fnc_setdistance = {
	_dist = (_this select 0);
	_dist2 = _dist * 0.7;
	if (_dist > 500) then {
		if (_dist < maxviewdistance) then {
			setViewDistance _dist;
			if (_dist2 < 500) then {
				setobjectviewdistance 500;
			} else {
				setobjectviewdistance _dist2;
			};
		} else {setViewDistance maxviewdistance; setobjectviewdistance maxviewdistance * 0.7;};
	}
	else
	{
		setViewDistance 500;
		setobjectviewdistance 500;
	};
	ctrlSetText [311, str viewdistance];
};

[[
	"<t color='#c8c8ff'>Ustaw odległość widzenia</t>",
	{call fnc_setviewgui},
	nil,
	-10,
	false,
	true
]] call CBA_fnc_addPlayerAction;
