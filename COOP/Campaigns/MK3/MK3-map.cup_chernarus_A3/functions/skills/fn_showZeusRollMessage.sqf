#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Show roll message to Zeus.
 *
 * Arguments:
 * 0: Unit rolling <UNIT>
 * 1: Localizable name of the skill <STRING>
 * 2: Skill bonus score for display <NUMBER>
 * 3: Roll result <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_skillName", "_skillBonusScore", "_rollResult"];

// TODO: Change to ACE function after release
// if (call ACEFUNC(common,hasZeusAccess)) exitWith {
if (!isNull getAssignedCuratorLogic player) exitWith {
    private _rollMessage = format [LLSTRING(Skills_RolledMessage), localize _skillName, _skillBonusScore, _rollResult];
    _unit commandChat _rollMessage;
};
