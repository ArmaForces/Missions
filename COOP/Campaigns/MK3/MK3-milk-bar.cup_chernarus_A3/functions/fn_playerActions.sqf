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

player addAction [format ["<t color='#c8c8ff'>%1</t>", localize "STR_ArmaForces_Preset_Dialog_ViewDistance_Action"], {call FUNC(viewDistanceGUI)}, nil, -10, false, true, "", "", 50];
if (rank player == "COLONEL") then {
	player addAction [format ["<t color='#c8c8ff'>%1</t>", localize "$STR_ArmaForces_Preset_Dialog_GroupRename_Action"], {call FUNC(groupRenameGUI)}, nil, -10, false, true, "", "", 50];
};

minviewdistance = 250;
maxviewdistance = 10000;
