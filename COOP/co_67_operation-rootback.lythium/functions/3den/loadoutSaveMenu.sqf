AF_fnc_loadoutSaveMenu = {
	if (isNull (findDisplay 9960))then
	{
		AF_selectedUnits = [];
		{
			if (_x isKindOf "man") then
			{
				AF_selectedUnits pushBack _x;
			};
		}forEach (get3DENSelected "object");
		if (count AF_selectedUnits == 0) exitWith {"ZAZNACZ NAJPIERW WSZYSTKIE JEDNOSTKI STRONY!"};
		disableSerialization;
		createDialog "AF_dlg_3den_loadoutSave";
	};
};