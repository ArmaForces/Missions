AF_fnc_loadoutSelector = {
	_grpName = AF_3den_LoadoutCategory select (_this select 0);
	waitUntil {!isNull (findDisplay 9970);};
	lbClear 1501;
	private _ctrl1 = (findDisplay 9970) displayCtrl 1500;
	private _ctrl2 = (findDisplay 9970) displayCtrl 1501;
	AF_3den_index = [];
	{
		if (_grpName == (_x select 0)) then
		{
		_ctrl2 lnbAddRow [_x select 1,_x select 2];
		AF_3den_index pushBack _forEachIndex;
		};
	} forEach AF_sideSelected;
};