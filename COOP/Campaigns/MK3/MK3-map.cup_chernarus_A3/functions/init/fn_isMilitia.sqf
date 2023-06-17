#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Checks if unit is militia.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Is a militia unit <BOOL>
 *
 * Public: No
 */

params ["_unit"];

private _isMilitia = _unit getVariable [QGVAR(isMilitia), objNull];

if (_isMilitia isEqualTo objNull) then {
    _isMilitia = ["Police", typeOf _unit] call BIS_fnc_inString;
    _unit setVariable [QGVAR(isMilitia), _isMilitia];
};

// Return
_isMilitia
