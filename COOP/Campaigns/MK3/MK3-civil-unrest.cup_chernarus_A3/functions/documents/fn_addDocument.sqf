#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Add document to unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Document details <ARRAY>
 *  0: Document name <STRING>
 *  1: Document content <STRING>
 *
 * Return Value:
 * List of documents in format: <ARRAY>
 *  0: Document name <STRING>
 *  1: Document content <STRING>
 *
 * Public: No
 */

params ["_unit", "_documentDetails"];

if (!isServer) exitWith {
    [QGVAR(addDocument), _this] call CBA_fnc_serverEvent;
};

_documentDetails params ["_documentName", "_documentContent"];

private _uid = getPlayerUID _unit;

private _documents = GVAR(allDocuments) getOrDefault [_uid, objNull];

if (isNull _documents) then {
    // Add empty array by ref so we always modify array already present in hash map
    _documents = [];
    GVAR(allDocuments) set [_uid, _documents];
};

private _existingDocumentWithTheSameNameIndex = _documents findIf {_x select 0 isEqualTo _documentName};

if (_existingDocumentWithTheSameNameIndex != -1) exitWith {
    systemChat format ["Failed adding document %1 for UID %2.", _documentName, _uid];
    false
};

_documents pushBack _documentDetails;

// Possibly not necessary as pushBack modifies original array
// GVAR(allDocuments) set [_uid, _documents];

publicVariable QGVAR(allDocuments);

true
