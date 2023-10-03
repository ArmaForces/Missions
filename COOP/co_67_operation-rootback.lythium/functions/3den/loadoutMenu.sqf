AF_fnc_loadoutMenu = 
{
	if (isNull (findDisplay 9970))then
	{
		disableSerialization;
		AF_selectedUnits = [];
		{
			if (_x isKindOf "man") then
			{
				AF_selectedUnits pushBack _x;
			};
		}forEach (get3DENSelected "object");
		if (count AF_selectedUnits == 0) exitWith {"ZAZNACZ NAJPIERW WSZYSTKIE JEDNOSTKI STRONY!"};
		createDialog "AF_dlg_3den_loadout";
		[] spawn {
			_side = side (AF_selectedUnits select 0);
			waitUntil {!isNull (findDisplay 9970);};
			lbClear 1500;
			lbClear 1501;
			private _ctrl1 = (findDisplay 9970) displayCtrl 1500;
			private _ctrl2 = (findDisplay 9970) displayCtrl 1501;
			switch (_side) do {
				case EAST: {AF_sideSelected = AF_loadout_redfor};
				case RESISTANCE: {AF_sideSelected = AF_loadout_indfor};
				default {AF_sideSelected = AF_loadout_blufor};
			};
			AF_3den_LoadoutCategory = [];
			{
				AF_3den_LoadoutCategory pushBackUnique (_x select 0);
			} forEach AF_sideSelected;
			{
				_ctrl1 lbAdd _x;
			} forEach AF_3den_LoadoutCategory;
		};
	};
};