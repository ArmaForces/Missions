
#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Loads all stats from previous missions.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Stats of all players <HASHMAP>
 *
 * Public: No
 */

params ["_uid"];

private _wargayProgress = profileNamespace getVariable ["MDL_WG_Progress", []];

if (_wargayProgress isEqualTo []) then {
	_wargayProgress = createHashMap;
	profileNamespace setVariable ["MDL_WG_Progress", _wargayProgress];
};

_wargayProgress getOrDefaultCall ["Players", {createHashMap}, true]
