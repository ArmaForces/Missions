#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Initializes clientside settings.
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
    QGVAR(damageAlarmEnabled),
    "CHECKBOX",
    [LSTRING(DamageAlarmEnabled), LSTRING(DamageAlarmEnabled_Description)],
    [LSTRING(Settings_DisplayNameClient)],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(unitIconSizeDependsOnDistance),
    "CHECKBOX",
    [LSTRING(UnitIconSizeDependsOnDistance), LSTRING(UnitIconSizeDependsOnDistance_Description)],
    [LSTRING(Settings_DisplayNameClient), LSTRING(UnitIconsSize)],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(unitIconSizeMultiplier),
    "SLIDER",
    [LSTRING(UnitIconSizeMultiplier), LSTRING(UnitIconSizeMultiplier_Description)],
    [LSTRING(Settings_DisplayNameClient), LSTRING(UnitIconsSize)],
    [0, 10, 1, 0],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(unitIconTextSizeMultiplier),
    "SLIDER",
    [LSTRING(UnitIconTextSizeMultiplier), LSTRING(UnitIconTextSizeMultiplier_Description)],
    [LSTRING(Settings_DisplayNameClient), LSTRING(UnitIconsSize)],
    [0, 10, 1, 0],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(showDamageFeedback),
    "CHECKBOX",
    [LSTRING(ShowDamageFeedback), LSTRING(ShowDamageFeedback_Description)],
    [LSTRING(Settings_DisplayNameClient)],
    true,
    false
] call CBA_fnc_addSetting;
