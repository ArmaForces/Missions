#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Creates RESISTANCE briefing.
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
#define BRLLSTRING(var) LELSTRING(Briefing_Resistance,var)

params [["_unit", player]];

private _listSeparator = "<br/>- ";
private _generalRulesList = [
    BRLLSTRING(Rules_1),
    BRLLSTRING(Rules_2),
    BRLLSTRING(Rules_3),
    BRLLSTRING(Rules_4),
    BRLLSTRING(Rules_5)
] joinString _listSeparator;
private _generalRulesText = format ["%1%2%3", BRLLSTRING(Rules), _listSeparator, _generalRulesList];

_unit createDiaryRecord [DIARY_NAME, [BRLLSTRING(Rules_Title), _generalRulesText]];
_unit createDiaryRecord [DIARY_NAME, [BLLSTRING(RoE_Title), BRLLSTRING(RoE)]];
