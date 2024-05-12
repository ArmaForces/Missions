#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Adds experience for kill to crew of shooting vehicle
 *
 * Arguments:
 * 0: Unit shooting <OBJECT>
 * 1: Killed unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_shooter", "_unit"];

private _vehicleInfo = VehicleTypes getOrDefault [toUpper typeOf _unit, objNull];
private _xpAmount = if (_vehicleInfo isEqualTo objNull) then { 5 } else { _vehicleInfo get "pointCost" };

{
	private _playerStats = [getPlayerUID _x] call FUNC(getPlayerStats);

	// TODO: Consider keeping list of killed units
	private _killedUnits = _x getVariable ["MDL_killedUnits", []];
	_killedUnits pushBack typeOf _unit;
	_x setVariable ["MDL_killedUnits", _killedUnits, true];

	private _currentXp = _playerStats getOrDefault ["Current XP", 0];
	private _newXp = _currentXp + _xpAmount;
	_playerStats set ["Current XP", _newXp];

	private _currentTotalXp = _playerStats getOrDefault ["Total XP", 0];
	private _newTotalXp = _currentTotalXp + _xpAmount;
	_playerStats set ["Total XP", _newTotalXp];

	private _currentKills = _playerStats getOrDefault ["Kills", 0];
	private _newKills = _currentKills + _xpAmount;
	_playerStats set ["Kills", _currentKills + _xpAmount];

	_x setVariable ["MDL_playerStats", _playerStats, true];

	["MDL_xpReceived", [_xpAmount, _newXp, _newTotalXp], _x] call CBA_fnc_targetEvent;
} forEach crew vehicle _shooter;
