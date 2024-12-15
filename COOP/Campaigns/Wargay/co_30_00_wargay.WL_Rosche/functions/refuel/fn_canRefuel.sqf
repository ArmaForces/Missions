#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Checks if caller can repair target.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * True if unit is an engineer <BOOL>
 *
 * Public: No
 */

params ["_caller", "_target"];

alive _target && {
	_caller call FUNC(isEngineer) && {
	vehicle _caller isEqualTo _caller && {
	_caller distance _target < 5 && {
	fuel _target < 1 && {
	((_target getVariable ["MDL_lastCombatActive", -GVAR(repairMinNoCombatTime)]) + GVAR(repairMinNoCombatTime)) < CBA_missionTime
}}}}}