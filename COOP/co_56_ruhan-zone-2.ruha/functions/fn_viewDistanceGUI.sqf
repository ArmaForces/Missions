#include "script_component.hpp"
/*
 * Author: Madin
 * Konsola do zmiany odległości widzenia
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

disableSerialization;
createDialog QGVAR(dlg_viewDistance);
[{!isNull (findDisplay 10)},{
    ctrlSetText [311, str viewdistance];
}, [], -1] call CBA_fnc_waitUntilAndExecute;
