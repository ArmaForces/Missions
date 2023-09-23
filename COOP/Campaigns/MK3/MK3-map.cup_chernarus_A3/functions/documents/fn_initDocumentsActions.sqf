#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Initializes self action for documents.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

private _insertSkillsChildren = {
    params ["_target", "_player", "_params"];

    private _skills = [player] call FUNC(getSkills);

    // Prepare skills for actions creation
    private _skillsForActions = _skills apply {
        _x params ["_skillName", "_skillBonusScore"];

        [_skillName, format ["%1 (%2)", localize _skillName, _skillBonusScore], FUNC(rollSkill), _x]
    };

    [_skillsForActions] call FUNC(createChildActions);
};

private _skillsAction = [QGVAR(skills), LLSTRING(Skills), "", {}, {true}, _insertSkillsChildren, [], "", 4, [false, false, false, false, false], {}] call ace_interact_menu_fnc_createAction;

[
    typeOf (player),
    1,
    ["ACE_SelfActions"],
    _skillsAction,
    false
] call ACEFUNC(interact_menu,addActionToClass);
