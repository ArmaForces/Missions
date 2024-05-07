#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Handles repair start.
 *
 * Arguments:
 * 0: Unit being repaired <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_target"];

private _currentHp = _target getVariable ["MDL_currentHp", 0];
private _maxHp = _target getVariable ["MDL_maxHp", MAX_HP];
private _actualDuration = (_maxHp - _currentHp) * HEAL_SECONDS_PER_POINT;
// TODO: Shorten duration based on unit skill

// Please forgive me for magically changing variable from unknown outer scope
_duration = _actualDuration;

// Determine at which steps we want to repair
#define MAX_FRAME 24
private _stepsToHeal = ceil ((_maxHp - _currentHp)/HEAL_AMOUNT);
private _healEvery = MAX_FRAME / _stepsToHeal;
private _lastHeal = MAX_FRAME;
private _stepsWithRepair = [];
while {(_stepsToHeal - 1) > count _stepsWithRepair} do {
    _lastHeal = _lastHeal - _healEvery;
    _stepsWithRepair pushBack (_lastHeal);
};

_target setVariable ["MDL_repairAtSteps", _stepsWithRepair];
