#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3, veteran29
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
    [LSTRING(Settings_DisplayName), LSTRING(UnitIcons)],
    [[0, 1], ["All", "Enemy only"]],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enemyMarkersEnabled),
    "CHECKBOX",
    ["Enable map markers enemies", "If enabled, map markers will be show for spotted enemy units (icons might look different on map vs in-game)."],
    [LSTRING(Settings_DisplayName), LSTRING(UnitIcons)],
    true,
    true
] call CBA_fnc_addSetting;

[
    QGVAR(enemyMarkersRefreshRate),
    "TIME",
    ["Refresh rate for enemy markers", "Controls how often map markers for enemies should refresh."],
    [LSTRING(Settings_DisplayName), LSTRING(UnitIcons)],
    [0, 60, 5],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(onlyReconCanSpot),
    "CHECKBOX",
    ["Only recon can spot", "If enabled, only recon units can spot enemies to be visible for other units"],
    [LSTRING(Settings_DisplayName)],
    false,
    true
] call CBA_fnc_addSetting;

[
    QGVAR(repairMinNoCombatTime),
    "TIME",
    ["Minimum no combat time", "Vehicle must be out of combat for long enough to be able to be repaired"],
    [LSTRING(Settings_DisplayName), localize "str_state_repair"],
    [0, 900, 60],
    true
] call CBA_fnc_addSetting;

GVAR(iconWidth) = getNumber (configFile >> "CfgInGameUI" >> "Cursor" >> "activeWidth");
GVAR(westIconColor) = getArray (missionConfigFile >> "CfgWargay" >> "westMarkerColor");
GVAR(eastIconColor) = getArray (missionConfigFile >> "CfgWargay" >> "eastMarkerColor");
GVAR(filledHpColor) = getArray (missionConfigFile >> "CfgWargay" >> "filledHpColor");
GVAR(missingHpColor) = getArray (missionConfigFile >> "CfgWargay" >> "missingHpColor");
GVAR(fuelConsumptionMultiplier) = 4;
