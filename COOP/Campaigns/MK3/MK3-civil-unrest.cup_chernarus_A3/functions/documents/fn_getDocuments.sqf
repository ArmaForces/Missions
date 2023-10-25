#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Gets unit's documents.
 *
 * Arguments:
 * Unit or UID <OBJECT or STRING>
 *
 * Return Value:
 * List of documents in format: <ARRAY>
 *  0: Document name <STRING>
 *  1: Document content <STRING>
 *
 * Public: No
 */

params ["_unit"];

private _uid = if (_unit isEqualType "") then {
    _unit
} else {
    getPlayerUID _unit
};

GVAR(allDocuments) getOrDefault [_uid, []]
