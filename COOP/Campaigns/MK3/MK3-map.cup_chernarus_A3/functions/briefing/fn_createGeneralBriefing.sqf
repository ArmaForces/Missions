#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Creates general briefing.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#define DIARY_NAME "mkrDiary"
#define BLLSTRING(var) LELSTRING(Briefing,var)
#define BMLLSTRING(var) LELSTRING(Briefing_Militia,var)

params [["_unit", player]];

_unit createDiarySubject [DIARY_NAME, LLSTRING(DisplayName)];
_unit createDiaryRecord [DIARY_NAME, [BLLSTRING(OtherChanges_Title), BLLSTRING(OtherChanges)]];
_unit createDiaryRecord [DIARY_NAME, [BLLSTRING(MedicalSystem), BLLSTRING(MedicalStuff)]];

private _listSeparator = "<br/>- ";
private _generalRulesList = [
    BLLSTRING(GeneralRules_1),
    BLLSTRING(GeneralRules_2),
    BLLSTRING(GeneralRules_3),
    BLLSTRING(GeneralRules_4),
    BLLSTRING(GeneralRules_5),
    BLLSTRING(GeneralRules_6),
    BLLSTRING(GeneralRules_7)
] joinString _listSeparator;
private _generalRulesText = format ["%1%2%3", BLLSTRING(GeneralRules), _listSeparator, _generalRulesList];

_unit createDiaryRecord [DIARY_NAME, [BLLSTRING(GeneralRules_Title), _generalRulesText]];

_unit createDiaryRecord [DIARY_NAME, [LLSTRING(DisplayName), BLLSTRING(Rationale)]];
