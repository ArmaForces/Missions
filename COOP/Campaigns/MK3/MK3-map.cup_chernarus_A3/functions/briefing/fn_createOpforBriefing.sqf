#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Creates OPFOR briefing.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#define DIARY_NAME "Diary"
#define BLLSTRING(var) LELSTRING(Briefing,var)
#define BOLLSTRING(var) LELSTRING(Briefing_Opfor,var)

params [["_unit", player]];

private _listSeparator = "<br/>- ";
private _generalRulesList = [
    BOLLSTRING(Rules_1),
    BOLLSTRING(Rules_2),
    BOLLSTRING(Rules_3),
    BOLLSTRING(Rules_4),
    BOLLSTRING(Rules_5)
] joinString _listSeparator;
private _generalRulesText = format ["%1%2%3", BOLLSTRING(Rules), _listSeparator, _generalRulesList];

_unit createDiaryRecord [DIARY_NAME, [BOLLSTRING(Rules_Title), _generalRulesText]];
_unit createDiaryRecord [DIARY_NAME, [BLLSTRING(RoE_Title), BLLSTRING(RoE)]];
