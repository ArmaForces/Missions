/* 
 Handles plane initialization for WEST SIDE
 
 Params:
 0: <OBJECT> - plane to initialize
*/

params ["_plane"];

private _radioPreset = RADIO_BLUFOR_PRESET;
private _loadout = L159_BLUFOR_LOADOUT;

private _planeInitialized = _plane getVariable ["MDL_PvPJets_initialized", false];
if (_planeInitialized) exitWith { false };

_plane addEventHandler ["Killed", {
	[WEST, -10] call BIS_fnc_respawnTickets;
}];

[_plane, _loadout] remoteExec ["MDL_PvPJets_fnc_planeChangeLoadout", 0];
[_plane, _radioPreset] call acre_api_fnc_setVehicleRacksPreset;

_plane setVehicleReportOwnPosition true;
_plane setVehicleReportRemoteTargets true;
_plane setVehicleReceiveRemoteTargets true;

_plane setVariable ["MDL_PvPJets_initialized", true, true];

true
