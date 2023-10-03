AF_fnc_loadoutSet = {
	_selector = AF_3den_index  select (_this select 0);
	_loadout = (AF_sideSelected select _selector) select 3;
	{
		private _unit = _x;
		private _typeOf = typeOf _x;
		{
			if (_typeOf == _x select 0) exitWith
			{
				_x params ["_typeOf","_uniform","_vest","_back","_head","_weap","_witem","_wmag","_hgun","_hitem","_hmag"];
				removeAllWeapons _unit;
				removeAllItems _unit;
				removeAllAssignedItems _unit;
				removeUniform _unit;
				removeVest _unit;
				removeBackpack _unit;
				removeHeadgear _unit;
				removeGoggles _unit;
				removeUniform _unit;
				_unit forceAddUniform _uniform;
				_unit addVest _vest;
				_unit addBackpack _back;
				_unit addHeadgear _head;
				_unit addWeapon _weap;
				{_unit removePrimaryWeaponItem _x}forEach (primaryWeaponItems _unit);
				{_unit addPrimaryWeaponItem _x}forEach _witem;
				{_unit addPrimaryWeaponItem _x}forEach _wmag;
				_unit addWeapon _hgun;
				{_unit removeHandgunItem _x}forEach (handgunItems _unit);
				{_unit addHandgunItem _x}forEach _hitem;
				{_unit addHandgunItem _x}forEach _hmag;
				[_unit] call AF_fnc_loadoutItems;
			};
		}forEach _loadout;
	}forEach AF_selectedUnits;
	save3DENInventory AF_selectedUnits;
};