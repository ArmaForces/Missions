#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Selects randomly among connected players ones who join opposing side.
 * If game was played before, excludes players already been in opfor.
 *
 * Arguments:
 * 0: Number of players which should join opposing side <NUMBER>
 * 1: Side to join <SIDE>
 *
 * Returns:
 * Units which joined opposing side <ARRAY>
 *
 * Example:
 * [4, EAST] call afsg_patrol_fnc_randomizeTeams
 *
 * Public: No
 */

 params ["_desiredNumber", ["_side", EAST]];

private _opforUnits = [];
private _excludedUIDs = profileNamespace getVariable [QGVAR(beenOpfor), []];
TRACE_1("Excluded UIDs: %1", str _excludedUIDs);
private _allPlayers = GVAR(playersConnected) apply {_x select 1};
TRACE_2("AllPlayers: %1 | %2", str allPlayers, str _allPlayers);
private _allPlayersUIDs = _allPlayers apply {getPlayerUID _x};
TRACE_1("AllPlayersUIDs: %1", _allPlayersUIDs);
private _eligiblePlayersUIDs = _allPlayersUIDs - _excludedUIDs;
TRACE_1("EligiblePlayersUIDs: %1", _eligiblePlayersUIDs);
private _eligiblePlayers = _allPlayers apply {
    if (getPlayerUID _x in _eligiblePlayersUIDs) then {
        _x
    } else {
        nil
    }
};
_eligiblePlayers = _eligiblePlayers arrayIntersect _eligiblePlayers;
TRACE_1("EligiblePlayers: %1", _eligiblePlayers);

// Clear cache if not enough players
if (count _eligiblePlayers < _desiredNumber) then {
    _excludedUIDs = [];
    _eligiblePlayers = _allPlayers;
};

private _selectedPlayers = [];

[QGVAR(showSystemMessage), ["Selecting players"]] call CBA_fnc_localEvent;
while {count _selectedPlayers < _desiredNumber && {!(_eligiblePlayers isEqualTo [])}} do {
    private _unit = [_eligiblePlayers] call FUNC(deleteAtRandom);
    TRACE_2("Selected: %1 | %2", _unit, name _unit);
    _selectedPlayers pushBack _unit;
    [QGVAR(playerInitialize), [EAST], _unit] call CBA_fnc_targetEvent;
};

[QGVAR(showSystemMessage), [format ["Selected players: %1", str _selectedPlayers]]] call CBA_fnc_localEvent;
_excludedUIDs append (_selectedPlayers apply {getPlayerUID _x});
profileNamespace setVariable [QGVAR(beenOpfor), _excludedUIDs];
saveProfileNamespace;

_selectedPlayers