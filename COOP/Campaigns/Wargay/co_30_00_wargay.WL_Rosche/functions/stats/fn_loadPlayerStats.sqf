
#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Loads player's stats from previous mission.
 * If ran on client, requests stats to be saved into player's unit namespace.
 *
 * Arguments:
 * 0: Player unit <OBJECT>
 *
 * Return Value:
 * True if loaded successfully <BOOL>
 *
 * Public: No
 */

params [["_unit", player]];

if (!isServer) exitWith {
	["MDL_loadPlayerStats", [player]] call CBA_fnc_serverEvent;
};

private _uid = getPlayerUID _unit;

if (_uid isEqualTo "") exitWith { false };

private _playerData = [_uid] call FUNC(getPlayerStats);

private _index = GVAR(loadedPlayers) pushBackUnique _uid;
if (_index isEqualTo -1) then {
	private _playedMissions = _playerData getOrDefault ["Missions", 0, true];
	_playerData set ["Missions", _playedMissions + 1];
};

_unit setVariable ["MDL_playerStats", _playerData, true];

// BUG: probably doesn't work
["MDL_showStats", [_playerData], _unit] call CBA_fnc_targetEvent;

true
