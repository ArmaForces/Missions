#include "script_component.hpp"
/*
 * Author: Madin
 * Konsola zulu do zmiany nazw grup
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
createDialog QGVAR(dlg_groupRename);
[{!isNull (findDisplay 9991)},{
    call FUNC(groupRenameList);
}, [], -1] call CBA_fnc_waitUntilAndExecute;
