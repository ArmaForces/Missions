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

_Loadout = [];

if (typeOf _plane == "rhs_l159_cdf_b_CDF") then {
	_plane addEventHandler ["Killed", {
		[WEST, -10] call BIS_fnc_respawnTickets;
	}];
	_Loadout = L159_BLUFOR;
};
if (typeOf _plane == "I_Plane_Fighter_03_dynamicLoadout_F") then {
	_plane addEventHandler ["Killed", {
		[EAST, -10] call BIS_fnc_respawnTickets;
	}];
	_Loadout = L159_OPFOR;
};

[_plane,_Loadout] remoteExec ["MDL_PvPJets_fnc_planeChangeLoadout",0];

_plane setVehicleReportOwnPosition true;
_plane setVehicleReportRemoteTargets true;
_plane setVehicleReceiveRemoteTargets true;