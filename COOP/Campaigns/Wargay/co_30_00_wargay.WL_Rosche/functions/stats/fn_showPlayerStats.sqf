
#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Shows all player stats from whole campaign.
 * Runs clientside only.
 *
 * Arguments:
 * 0: Player unit <OBJECT>
 *
 * Public: No
 */

params [["_unit", player]];

if (!hasInterface) exitWith {};

private _playerData = [getPlayerUID _unit] call FUNC(getPlayerStats);

private _currentXp = _playerData getOrDefault ["Current XP", 0];
private _totalXp = _playerData getOrDefault ["Total XP", 0];
private _deaths = _playerData getOrDefault ["Deaths", 0];
private _kills = _playerData getOrDefault ["Kills", 0];
private _losses = _playerData getOrDefault ["Losses", 0];
private _playedMissions = _playerData getOrDefault ["Missions", 0];

private _messageParts = [
	format ["Player: %1", name _unit],
	lineBreak,
	lineBreak,
	format ["XP: %1", _currentXp],
	lineBreak,
	format ["XP Total: %2", _totalXp],
	lineBreak,
	lineBreak,
	format ["Played missions: %1", _playedMissions],
	format ["Deaths: %1", _deaths],
	format ["Kills: %1", _kills],
	format ["Losses: %1", _losses],
	format ["K/L ratio: %1", _kills/_losses]
];

private _text = composeText _messageParts;
hint _text;
