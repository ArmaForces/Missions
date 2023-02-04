/* 
Changes plane loadout.

Params:
0: <OBJECT> - plane which will have it's loadout changed
1: <ARRAY> - pylon loadout

Return value:
None

Example:
[this, [""]] call MDL_PvPJets_fnc_planeChangeLoadout;

Locality:
Runs local. Effect local.
*/

params ["_plane","_Loadout"];

_pylons = GetPylonMagazines _plane;
_i = 1;
{
	_plane setPylonLoadOut [_i, (_Loadout select (_i - 1))];
	_i = _i + 1;
} forEach _pylons;