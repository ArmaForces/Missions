#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Heals damage of unit
 *
 * Arguments:
 * 0: Unit to heal <OBJECT>
 * 1: Heal amount <NUMBER> (Default: full heal)
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", ["_healAmount", MAX_HP]];

if (_healAmount isEqualTo MAX_HP) exitWith {
    private _maxHp = _unit getVariable ["MDL_maxHp", MAX_HP];
    _unit setVariable ["MDL_currentHp", _maxHp, true];
    _unit setDamage 0;
	// Heal crew
	{_x setDamage 0} forEach crew _unit;
};

private _maxHp = _unit getVariable ["MDL_maxHp", MAX_HP];
private _currentHp = _unit getVariable ["MDL_currentHp", MAX_HP];
private _newHp = (_currentHp + 0.5) min 10;
_unit setVariable ["MDL_currentHp", _newHp, true];
_unit setDamage ((_newHp/_maxHp) min 0.8);

["MDL_showCurrentHp", [_unit], crew _unit] call CBA_fnc_targetEvent;
