/* 
 Handles plane initialization for EAST SIDE
 
 Params:
 0: <OBJECT> - plane to initialize
*/

params ["_plane"];

private _radioPreset = RADIO_REDFOR_PRESET;
private _loadout = L159_REDFOR_LOADOUT;

_plane addEventHandler ["Killed", {
	params ["_plane"];

	{
		_x setDamage 1;
	} forEach crew _plane;

	[EAST, -10] call BIS_fnc_respawnTickets;
}];

[_plane, _loadout] call MDL_PvPJets_fnc_planeChangeLoadout;
if (ACRE_Loaded && {_radioPreset isNotEqualTo ""}) then {
	[_plane, _radioPreset] call acre_api_fnc_setVehicleRacksPreset;
};

_plane setVehicleReportOwnPosition true;
_plane setVehicleReportRemoteTargets true;
_plane setVehicleReceiveRemoteTargets true;

true
