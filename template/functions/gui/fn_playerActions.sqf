#include "..\script_component.hpp"
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

[[format ["<t color='#c8c8ff'>%1</t>", LELSTRING(GUI,Dialog_ViewDistance_Action)], {call FUNC(viewDistanceGUI)}, nil, -10, false, true, "", "", 50]] call CBA_fnc_addPlayerAction;

if (rank player == "COLONEL") then {
    [[format ["<t color='#c8c8ff'>%1</t>", LELSTRING(GUI,Dialog_GroupRename_Action)], {call FUNC(groupRenameGUI)}, nil, -10, false, true, "", "", 50]] call CBA_fnc_addPlayerAction;
};
