#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Transfers documents from one UID to another.
 * Main use is for changing placeholders for real UIDs.
 *
 * Arguments:
 * 0: UID of an old owner of the documents (or a placeholder) <STRING>
 * 1: UID of a new owner of the documents <STRING>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_oldUid", "_newUid"];

if (!isServer) exitWith { [QGVAR(assignDocumentsToPlayer), _this] call CBA_fnc_serverEvent; };

private _documents = GVAR(allDocuments) getOrDefault [_oldUid, objNull];

if (_documents isEqualType objNull && {isNull _documents}) exitWith { false };

private _documents = GVAR(allDocuments) deleteAt _oldUid;

GVAR(allDocuments) set [_newUid, _documents];

publicVariable QGVAR(allDocuments);

true
