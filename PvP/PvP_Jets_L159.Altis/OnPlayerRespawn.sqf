player setUnitLoadout playerloadout;
waitUntil {alive player};
player addAction ["<t color='#c8c8ff'>Ustaw odległość widzenia</t>", {call fnc_setviewgui},nil, -10, false, true, "", "", 50];
player setVariable ["ACE_GForceCoef", 0.5];