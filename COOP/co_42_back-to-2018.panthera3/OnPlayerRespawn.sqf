player setUnitLoadout playerloadout;
waitUntil {alive player};
player addAction ["<t color='#c8c8ff'>Ustaw odległość widzenia</t>", {call fnc_setviewgui},nil, -10, false, true, "", "", 50];
if (rank player == "COLONEL") then {
player addAction ["<t color='#c8c8ff'>Zmień nazwy drużyn</t>", {call fnc_groups},nil, -10, false, true, "", "", 50];
};
player addItem "ACE_EarPlugs";

["Terminate"] call BIS_fnc_EGSpectator;