#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Gets unit's skills.
 *
 * Arguments:
 * Unit or UID <OBJECT or STRING>
 *
 * Return Value:
 * List of skills in format: <ARRAY>
 *  0: Skill name <STRING>
 *  1: Skill bonus score <NUMBER>
 *
 * Public: No
 */

params ["_unit"];

private _uid = if (_unit isEqualType "") then {
    _unit
} else {
    getPlayerUID _unit
};

private _skills = [
    [LSTRING(Skills_Deception), 1],
    [LSTRING(Skills_History), -1],
    [LSTRING(Skills_Insight), 1],
    [LSTRING(Skills_Intimidation), 2],
    [LSTRING(Skills_Investigation), 0],
    [LSTRING(Skills_Persuasion), 0]
];

// TODO: Randomize
_skills

// GVAR(allDocuments) getOrDefault [_uid, []]
