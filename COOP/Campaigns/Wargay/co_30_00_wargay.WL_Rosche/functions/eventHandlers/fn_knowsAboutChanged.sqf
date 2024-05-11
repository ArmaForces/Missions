#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Checks if new unit is spotted and propagates info so that the icon can be drawn for target.
 *
 * Arguments:
 * 0: Group changing knowledge <GROUP>
 * 1: Target that the knowledge concerns <OBJECT>
 * 2: New KnowsAbout value <NUMBER>
 * 3: Old KnowsAbout value <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_group", "_targetUnit", "_newKnowsAbout", "_oldKnowsAbout"];

if (side _targetUnit isNotEqualTo EAST) exitWith {};
if (isObjectHidden leader _group) exitWith {};

if (GVAR(onlyReconCanSpot) && {!([_group] call FUNC(isReconVehicle))}) exitWith {};

#ifdef DEV_DEBUG
diag_log format ["WARGAY DEBUG KNOWS ABOUT CHANGED [%1]: Group: %2, Target: %3, KnowsAbout: %4 -> %5", diag_tickTime, _group, _targetUnit, _oldKnowsAbout, _newKnowsAbout];
#endif

private _isRevealed = _targetUnit getVariable ["MDL_IsVisible", false];

if (_newKnowsAbout > 0.75 && {!_isRevealed}) then {

	_targetUnit setVariable ["MDL_IsVisible", true, true];
    #ifdef DEV_DEBUG
    diag_log format ["WARGAY DEBUG KNOWS ABOUT CHANGED [%1]: Revealing Target: %3 detected by Group: %2", diag_tickTime, _group, _targetUnit, _oldKnowsAbout, _newKnowsAbout];
    #endif
    _group reveal _targetUnit;
};
