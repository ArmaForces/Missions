/* 
Handles respawning plane

Params:
0: <OBJECT> - plane respawned

Return value:
None

Example:
[""]

Locality:
Runs local. Effect local.
*/

params ["_plane"];

private _loadout = [];
private _radioPreset = "";

if (typeOf _plane == L159_BLUFOR) then {
	_plane addEventHandler ["Killed", {
		[WEST, -10] call BIS_fnc_respawnTickets;
	}];
	
	_radioPreset = RADIO_BLUFOR_PRESET;
	_loadout = L159_BLUFOR_LOADOUT;
};
if (typeOf _plane == L159_REDFOR) then {
	_plane addEventHandler ["Killed", {
		[EAST, -10] call BIS_fnc_respawnTickets;
	}];

	_radioPreset = RADIO_REDFOR_PRESET;
	_loadout = L159_REDFOR_LOADOUT;
};

[_plane, _loadout] remoteExec ["MDL_PvPJets_fnc_planeChangeLoadout", 0];

_plane setVehicleReportOwnPosition true;
_plane setVehicleReportRemoteTargets true;
_plane setVehicleReceiveRemoteTargets true;

if (ACRE_Loaded && {_radioPreset isNotEqualTo ""}) then {
	[_plane, _radioPreset] call acre_api_fnc_setVehicleRacksPreset;
};
