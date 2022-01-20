#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Returns highest ranked players among alive players of given side.
 *
 * Arguments:
 * 0: Side [SIDE]
 *
 * Return Value:
 * 0: List of alive players with highest rank [ARRAY]
 *   n: Player with highest rank [OBJECT]
 *
 * Public: No
 */

params ["_side"];

private _alivePlayersWithRanks = allPlayers
    select {side _x isEqualTo _side && {alive _x}}
    apply {[_x, rankId _x]};

if (_alivePlayersWithRanks isEqualTo []) exitWith {[]};

private _maxRank = selectMax (_alivePlayersWithRanks apply {_x select 1});

_alivePlayersWithRanks
    select {_x select 1 isEqualTo _maxRank}
    apply {_x select 0}
