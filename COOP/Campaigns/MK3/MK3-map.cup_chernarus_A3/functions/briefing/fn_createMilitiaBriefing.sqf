#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Creates militia briefing.
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
#define BMLLSTRING(var) LELSTRING(Briefing_Militia,var)

params [["_unit", player]];

private _listSeparator = "<br/>- ";
private _generalRulesList = [
    BMLLSTRING(Rules_1),
    BMLLSTRING(Rules_2),
    BMLLSTRING(Rules_3),
    BMLLSTRING(Rules_4),
    BMLLSTRING(Rules_5),
    BMLLSTRING(Rules_6)
] joinString _listSeparator;
private _generalRulesText = format ["%1%2%3", BMLLSTRING(Rules), _listSeparator, _generalRulesList];

_unit createDiaryRecord [DIARY_NAME, [BMLLSTRING(Rules_Title), _generalRulesText]];
_unit createDiaryRecord [DIARY_NAME, [BLLSTRING(RoE_Title), BLLSTRING(RoE)]];
