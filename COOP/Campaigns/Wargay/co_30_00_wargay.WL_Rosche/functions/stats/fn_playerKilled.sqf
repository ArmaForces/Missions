
#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Handles player death. Updates his stats.
 *
 * Arguments:
 * 0: Player UID <STRING>
 * 1: Player unit <OBJECT>
 * 2: Veehicle player was in when dying <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_playerUid", ["_playerUnit", objNull], ["_vehicle", objNull]];

if (!isServer) exitWith {};

private _playerStats = [_playerUid] call FUNC(getPlayerStats);

_playerStats set ["Current XP", 0];
private _currentDeaths = _playerStats getOrDefault ["Deaths", 0];
_playerStats set ["Deaths", _currentDeaths + 1];
 
// If outside vehicle or vehicle still lives, do not count as a loss

if (isNull _vehicle || {alive _vehicle}) exitWith {
	_playerUnit setVariable ["MDL_playerStats", _playerStats, true];
};

private _vehicleInfo = VehicleTypes getOrDefault [toUpper typeOf _vehicle, objNull];
private _pointCost = if (_vehicleInfo isEqualTo objNull) then { 5 } else { _vehicleInfo get "pointCost" };

private _currentLosses = _playerStats getOrDefault ["Losses", 0];
_playerStats set ["Losses", _currentLosses + _pointCost];

_playerUnit setVariable ["MDL_playerStats", _playerStats, true];

nil
