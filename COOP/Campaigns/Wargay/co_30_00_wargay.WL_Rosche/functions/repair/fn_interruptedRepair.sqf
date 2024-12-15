#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Handles repair process interruption.
 *
 * Arguments:
 * 0: Unit being repaired (not anymore) <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_target"];

private _maxHp = _target getVariable ["MDL_maxHp", MAX_HP];
private _currentHp = _target getVariable ["MDL_currentHp", MAX_HP];

private _lastCombatActive = _target getVariable ["MDL_lastCombatActive", -1];
if (_lastCombatActive + GVAR(repairMinNoCombatTime) > CBA_missionTime) exitWith {
	systemChat LLSTRING(VehicleInCombat);
};

systemChat format [LLSTRING(RepairInterrupted), _currentHp, _maxHp];
