/* 
Returns loadout for a given string.

Params:
0: <STRING> - 

Return value:
<ARRAY> - loadout for each pylon

Example:
[""]

Locality:
Runs local. Effect local.
*/

params ["_plane","_name"];

_Loadout = [];

if (typeOf _plane == "rhs_l159_cdf_b_CDF") then {
	_Loadout = L159_BLUFOR;
};
if (typeOf _plane == "I_Plane_Fighter_03_dynamicLoadout_F") then {
	_Loadout = L159_OPFOR;
};

_Loadout;