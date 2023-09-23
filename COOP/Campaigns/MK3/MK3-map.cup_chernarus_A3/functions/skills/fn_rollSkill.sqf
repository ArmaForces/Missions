#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Rolls skill and sends the result to Zeus.
 *
 * Arguments:
 * 0: Target (same as 1 as it's self action) IGNORED <UNIT>
 * 1: Player calling action <UNIT>
 * 2: Skill details <ARRAY>
 *   0: Localizable skill name <STRING>
 *   1: Skill bonus score <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_target", "_player", "_skill"];
_skill params ["_skillName", "_skillBonusScore"];

private _rollResult = ceil random 20 + _skillBonusScore;

[QGVAR(showZeusRollMessage), [_player, _skillName, _skillBonusScore, _rollResult]] call CBA_fnc_globalEvent;

private _confirmationMessage = format[LLSTRING(Skills_RollConfirmation), localize _skillName, _skillBonusScore];

_player commandChat _confirmationMessage;
