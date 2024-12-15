#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Handles rearm process interruption.
 *
 * Arguments:
 * 0: Unit being rearmed (not anymore) <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_target"];

private _lastCombatActive = _target getVariable ["MDL_lastCombatActive", -GVAR(repairMinNoCombatTime)];
if (_lastCombatActive + GVAR(repairMinNoCombatTime) > CBA_missionTime) exitWith {
	systemChat LLSTRING(VehicleInCombat);
};

systemChat LLSTRING(RearmInterrupted);
