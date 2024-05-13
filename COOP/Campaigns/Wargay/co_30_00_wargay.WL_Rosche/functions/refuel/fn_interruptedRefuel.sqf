#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Handles refuel process interruption.
 *
 * Arguments:
 * 0: Unit being refueled (not anymore) <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_target"];

private _currentFuel = fuel _target * 100;

private _lastCombatActive = _target getVariable ["MDL_lastCombatActive", -GVAR(repairMinNoCombatTime)];
if (_lastCombatActive + GVAR(repairMinNoCombatTime) > CBA_missionTime) exitWith {
	systemChat LLSTRING(VehicleInCombat);
};

systemChat format [LLSTRING(RefuelInterrupted), _currentFuel];
