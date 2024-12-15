
#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Retrieves player stats.
 *
 * Arguments:
 * 0: Player UID <STRING>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_uid"];

if (_uid isEqualTo "") exitWith {};

if (isServer) then {
	GVAR(allPlayersStats) getOrDefaultCall [_uid, {createHashMap}, true]
} else {
	private _playerData = player get ["MDL_playerStats", []];
	if (_playerData isEqualTo []) then { _playerData = createHashMap };
	_playerData
}
