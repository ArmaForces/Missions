AF_fnc_setStandardLoadout = {
	private _countUnits = 0;
	{
		if (_x isKindOf "man") then
		{
			private _uniform = uniform _x;
			private _vest = vest _x;
			private _backpack = backpack _x;
			removeUniform _x;
			removeVest _x;
			removeBackpack _x;
			_x forceAddUniform _uniform;
			_x addVest _vest;
			_x addBackpack _backpack;
			[_x] call AF_fnc_loadoutItems;
			_countUnits = _countUnits + 1;
		};
	}forEach (get3DENSelected "object");
	if (_countUnits > 0) then
	{
		_text = format ["zmieniono loadout dla %1 jednostek",_countUnits];
		[_text, 0] call BIS_fnc_3DENNotification;
	}else
	{
		["NIE WYBRANO JEDNOSTEK!", 1] call BIS_fnc_3DENNotification;
	};
};