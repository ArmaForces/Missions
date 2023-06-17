#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Gets unit's documents.
 *
 * Arguments:
 * Unit <OBJECT>
 *
 * Return Value:
 * List of documents in format: <ARRAY>
 *  0: Document name <STRING>
 *  1: Document content <STRING>
 *
 * Public: No
 */

params ["_unit"];

private _uid = getPlayerUID _unit;

GVAR(allDocuments) getOrDefault [_uid, []]
