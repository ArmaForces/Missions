#include "script_component.hpp"
/*
 * Author: Madin
 * Dodanie akcji do zmiany odległości widzenia oraz nazw drużyn
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

player addAction ["<t color='#c8c8ff'>Ustaw odległość widzenia</t>", {call FUNC(viewDistanceGUI)}, nil, -10, false, true, "", "", 50];
if (rank player == "COLONEL") then {
	player addAction ["<t color='#c8c8ff'>Zmień nazwy drużyn</t>", {call FUNC(groupRenameGUI)}, nil, -10, false, true, "", "", 50];
};
