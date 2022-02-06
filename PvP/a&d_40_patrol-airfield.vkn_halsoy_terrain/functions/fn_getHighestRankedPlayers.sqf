#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function returns list of highest ranked alive players.
 *
 * Arguments:
 * 0: Side to check <SIDE>
 *
 * Return Value:
 * 0: List of players <ARRAY>
 *
 * Example:
 * call afp_scripts_fnc_getHighestRankedPlayers
 *
 * Public: No
 */

params [["_side", sideUnknown]];

private _highestRankID = 7;
private _playersList = allPlayers select {alive _x};
if (!(_side isEqualTo sideUnknown)) then {
    _playersList select {side _x isEqualTo _side};
};

// If there are no players alive on given side just exit with empty list
if (_playersList isEqualTo []) exitWith {[]};

private _highestRankedPlayers = [];

while {_highestRankedPlayers isEqualTo [] && {_highestRankID > 0}} do {
    _highestRankID = _highestRankID - 1;
    _highestRankedPlayers = _playersList select {rankId _x isEqualTo _highestRankID};
};

// Return
_highestRankedPlayers