#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Initializes self action for phone
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

private _insertPhoneChildren = {
    params ["_target", "_player", "_params"];

    // Create child actions for 112 call with different report types
    private _emergencyChildActions = {
        params ["_target", "_player", "_params"];

        private _types = [
            ["emergency:accident", LLSTRING(Emergency_Accident), FUNC(callEmergency), [LSTRING(Emergency_Accident), true]],
            ["emergency:violence", LLSTRING(Emergency_Violence), FUNC(callEmergency), [LSTRING(Emergency_Violence), true]],
            ["emergency:tip", LLSTRING(Emergency_Tip), FUNC(callEmergency), [LSTRING(Emergency_Tip)]],
            ["emergency:other", LLSTRING(Emergency_Other), FUNC(callEmergency), [LSTRING(Emergency_Other)]]
        ];

        [_types] call FUNC(createChildActions);
    };

    private _contacts = [
        ["number:112", "112", {}, [], _emergencyChildActions]
    ];

    [_contacts] call FUNC(createChildActions);
};



private _phoneAction = [QGVAR(phone), localize "$STR_ace_explosives_cellphone_displayName", "", {}, {player call FUNC(hasPhone)}, _insertPhoneChildren, [], "", 4, [false, false, false, false, false], {}] call ace_interact_menu_fnc_createAction;

[
    typeOf (player),
    1,
    ["ACE_SelfActions", "ACE_Equipment"],
    _phoneAction,
    false
] call ACEFUNC(interact_menu,addActionToClass);
