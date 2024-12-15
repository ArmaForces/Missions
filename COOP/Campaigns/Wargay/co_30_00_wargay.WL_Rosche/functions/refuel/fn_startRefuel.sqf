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

private _currentFuel = fuel _target;
private _actualDuration = (1 - _currentFuel) * REFUEL_SECONDS_FULL;
// TODO: Shorten duration based on unit skill
// TODO: Check acutal fuel capacity

// Please forgive me for magically changing variable from unknown outer scope
_duration = _actualDuration;

// Determine at which steps we want to repair
#define MAX_FRAME 24
private _stepsToFullRefuel = ceil ((1 - _currentFuel)/REFUEL_AMOUNT);
private _refuelEvery = MAX_FRAME / _stepsToFullRefuel;
private _lastRefuel = MAX_FRAME;
private _stepsWithRefuel = [];

systemChat format ["Duration: %1, Refuel every: %2", _duration, _refuelEvery];
while {(_stepsToFullRefuel - 1) > count _stepsWithRefuel} do {
    _lastRefuel = _lastRefuel - _refuelEvery;
    _stepsWithRefuel pushBack (_lastRefuel);
};

_target setVariable ["MDL_refuelAtSteps", _stepsWithRefuel];
