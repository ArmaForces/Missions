#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Applies damage to unit
 *
 * Arguments:
 * 0: Unit to damage <OBJECT>
 * 1: Damage amount <NUMBER>
 * 2: Unit shooting <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_damage", "_shooter"];

private _currentHp = _unit getVariable ["MDL_currentHp", 10];
private _newHp = _currentHp - _damage;

// Check if this is a kill
if (_newHp <= 0) exitWith {
    // Add experience for players first
    if (isPlayer _shooter && {[side _shooter, side _unit] call BIS_fnc_sideIsEnemy}) then {
        [_shooter, _unit] call FUNC(addExperienceForKill);
    };

    _unit setVariable ["MDL_currentHp", 0, true];
    ["MDL_showCurrentHp", [_unit], crew _unit] call CBA_fnc_targetEvent;
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

if (isPlayer _unit) then {
    // Need to publicize it as this function runs on server
    _unit setVariable ["MDL_lastCombatActive", CBA_missionTime, true];
};
