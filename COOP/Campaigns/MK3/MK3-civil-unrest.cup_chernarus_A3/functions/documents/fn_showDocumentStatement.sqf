#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Shows document to target player (self or other).
 *
 * Arguments:
 * 0: Action target (could be other player) <UNIT>
 * 1: Player calling action <UNIT>
 * 2: Document details <ARRAY>
 *   0: Document name <STRING>
 *   1: Document content <STRING>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_target", "_player", "_documentData"];
_documentData params ["_documentName", "_documentContent"];

private _documentText = format ["%1<br/><br/>%2", _documentName, _documentContent];
private _lines = _documentText splitString "<>" select {_x find "br/" == -1};
private _size = 1.5 + 1 * count _lines;

if (_target isNotEqualTo _player) then {
    ["ace_common_displayTextStructured", [format ["Pokazujesz:<br/>%1", _documentText], _size, _player], [_player]] call CBA_fnc_targetEvent;
};

["ace_common_displayTextStructured", [_documentText, _size, _target], [_target]] call CBA_fnc_targetEvent;
