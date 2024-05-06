#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Applies damage to unit
 *
 * Arguments:
 * 0: Unit to damage <OBJECT>
 * 1: Damage amount <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_damage"];

private _currentHp = _unit getVariable ["MDL_currentHp", 10];
private _newHp = _currentHp - _damage;

if (_newHp <= 0) exitWith {
    _unit setVariable ["MDL_currentHp", 0, true];
    {_x setDamage 1} forEach crew _unit;
    _unit setDamage 1;
};

#ifdef DEV_DEBUG
systemChat format ["Remaining HP: %1/10", _newHp];
#endif

private _maxHp = _unit getVariable ["MDL_maxHp", MAX_HP];
_unit setVariable ["MDL_currentHp", _newHp, true];
// Limit to 0.8 to avoid explosions when hull or fuel are almost destroyed
_unit setDamage (((1 - _newHp)/_maxHp) min 0.8);
["MDL_showCurrentHp", [_unit], crew _unit] call CBA_fnc_targetEvent;
