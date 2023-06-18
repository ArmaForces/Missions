#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Creates CIVILIAN briefing.
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
#define BCLLSTRING(var) LELSTRING(Briefing_Civilian,var)

params [["_unit", player]];

private _listSeparator = "<br/>- ";
private _generalRulesList = [
    BCLLSTRING(Rules_1),
    BCLLSTRING(Rules_2),
    BCLLSTRING(Rules_3),
    BCLLSTRING(Rules_4),
    BCLLSTRING(Rules_5)
] joinString _listSeparator;
private _generalRulesText = format ["%1%2%3", BCLLSTRING(Rules), _listSeparator, _generalRulesList];

_unit createDiaryRecord [DIARY_NAME, [BCLLSTRING(Rules_Title), _generalRulesText]];
_unit createDiaryRecord [DIARY_NAME, [BLLSTRING(RoE_Title), BCLLSTRING(RoE)]];
