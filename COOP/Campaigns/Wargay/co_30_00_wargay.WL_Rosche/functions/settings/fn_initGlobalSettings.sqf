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

[
    QGVAR(repairMinNoCombatTime),
    "TIME",
    ["Minimum no combat time", "Vehicle must be out of combat for long enough to be able to be repaired"],
    [LSTRING(DisplayName), localize "str_state_repair"],
    [0, 900, 60],
    true
] call CBA_fnc_addSetting;

GVAR(westIconColor) = getArray (missionConfigFile >> "CfgWargay" >> "westMarkerColor");
GVAR(eastIconColor) = getArray (missionConfigFile >> "CfgWargay" >> "eastMarkerColor");
GVAR(filledHpColor) = getArray (missionConfigFile >> "CfgWargay" >> "filledHpColor");
GVAR(missingHpColor) = getArray (missionConfigFile >> "CfgWargay" >> "missingHpColor");
GVAR(fuelConsumptionMultiplier) = 5;
