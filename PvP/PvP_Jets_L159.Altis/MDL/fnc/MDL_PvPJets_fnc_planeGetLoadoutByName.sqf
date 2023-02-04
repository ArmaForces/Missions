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

if (typeOf _plane == L159_BLUFOR) then {
	_Loadout = L159_BLUFOR_LOADOUT;
};
if (typeOf _plane == L159_REDFOR) then {
	_Loadout = L159_REDFOR_LOADOUT;
};

_Loadout;