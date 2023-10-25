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

private _insertDocumentChildren = {
    params ["_target", "_player", "_params"];

    private _documents = [player] call FUNC(getDocuments);

    private _documentsForActions = _documents apply {
        _x params ["_documentName", "_documentContent"];
        [_documentName, _documentName, FUNC(showDocumentStatement), _x]
    };

    [_documentsForActions] call FUNC(createChildActions);
};

private _condition = {[player] call FUNC(hasAnyDocument)};
private _action = [QGVAR(documents), LLSTRING(ShowDocuments), "", {}, _condition, _insertDocumentChildren, [], "", 4, [false, false, false, false, false], {}] call ace_interact_menu_fnc_createAction;

// External action
[
    "CAManBase",
    0,
    ["ACE_MainActions"],
    _action,
    true
] call ACEFUNC(interact_menu,addActionToClass);

// Self action
[
    typeOf (player),
    1,
    ["ACE_SelfActions", "ACE_Equipment"],
    _action,
    false
] call ACEFUNC(interact_menu,addActionToClass);
