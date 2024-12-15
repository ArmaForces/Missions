#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Handles refuel progress
 *
 * Arguments:
 * 0: Unit being refueled <OBJECT>
 * 1: Unit commencing refueling <OBJECT>
 * 4: Current progress frame <NUMBER>
 * 5: Max progress frame <NUMBER> (should be 24)
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_target", "_caller", "_actionId", "_arguments", "_frame", "_maxFrame"];

private _stepsWithRefuel = _target getVariable ["MDL_refuelAtSteps", []];
if (_stepsWithRefuel isEqualTo []) exitWith {};

private _nextRefuelStep = _stepsWithRefuel select (count _stepsWithRefuel - 1);
                
if (_frame > _nextRefuelStep) then {
    // For display purposes only
    private _newFuel = fuel _target + REFUEL_AMOUNT;
    private _newFuelPercent = (_newFuel*100) min 100;
    systemChat format [LLSTRING(RefuelProgress), _newFuelPercent];
                    
    // Actual refueling
    ["MDL_refuelVehicle", [_target, _newFuel]] call CBA_fnc_globalEvent;

    _stepsWithRefuel deleteAt (count _stepsWithRefuel - 1);
};
