#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Handles repair progress
 *
 * Arguments:
 * 0: Unit being repaired <OBJECT>
 * 1: Unit commencing repairs <OBJECT>
 * 4: Current progress frame <NUMBER>
 * 5: Max progress frame <NUMBER> (should be 24)
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_target", "_caller", "_actionId", "_arguments", "_frame", "_maxFrame"];

private _stepsWithRepair = _target getVariable ["MDL_repairAtSteps", []];
if (_stepsWithRepair isEqualTo []) exitWith {};

private _nextRepairStep = _stepsWithRepair select (count _stepsWithRepair - 1);
                
if (_frame > _nextRepairStep) then {
    // For display purposes only
    private _maxHp = _target getVariable ["MDL_maxHp", MAX_HP];
    private _currentHp = _target getVariable ["MDL_currentHp", MAX_HP];
    private _newHp = (_currentHp + HEAL_AMOUNT) min 10;
    systemChat format [LLSTRING(RepairProgress), _newHp, _maxHp];
                    
    // Actual healing
    ["MDL_healDamage", [_target, HEAL_AMOUNT]] call CBA_fnc_serverEvent;

    _stepsWithRepair deleteAt (count _stepsWithRepair - 1);
};
