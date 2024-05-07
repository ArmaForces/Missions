#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Initializes global scenario settings.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

[
    QGVAR(unitIconMode),
    "LIST",
    ["Unit icon mode", ""],
    [LSTRING(DisplayName), LSTRING(UnitIcons)],
    [[0, 1], ["All", "Enemy only"]],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(onlyReconCanSpot),
    "CHECKBOX",
    ["Only recon can spot", "If enabled, only recon units can spot enemies to be visible for other units"],
    [LSTRING(DisplayName)],
    false,
    true
] call CBA_fnc_addSetting;
