/*
	AF_fnc_playerActions

	Description:
		Dodanie akcji do zmiany odległości widzenia oraz nazw drużyn

	Parameter(s):
		NOTHING

	Returns:
		NOTHING
*/

player addAction ["<t color='#c8c8ff'>Ustaw odległość widzenia</t>", {call AF_fnc_viewDistanceGUI}, nil, -10, false, true, "", "", 50];
if (rank player == "COLONEL") then {
	player addAction ["<t color='#c8c8ff'>Zmień nazwy drużyn</t>", {call AF_fnc_groupRenameGUI}, nil, -10, false, true, "", "", 50];
};