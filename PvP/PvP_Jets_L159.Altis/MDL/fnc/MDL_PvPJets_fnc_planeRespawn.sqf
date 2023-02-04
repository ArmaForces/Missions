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

if (typeOf _plane isEqualTo L159_BLUFOR) then {
	[_plane] call MDL_PvPJets_fnc_planeWestInit;
};
if (typeOf _plane isEqualTo L159_REDFOR) then {
	[_plane] call MDL_PvPJets_fnc_planeEastInit;
};
