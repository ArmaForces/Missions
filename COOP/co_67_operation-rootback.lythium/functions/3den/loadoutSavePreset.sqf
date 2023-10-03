AF_fnc_3denSavePreset = 
{
	_AF_selectedUnits = AF_selectedUnits;
	_side = side (_AF_selectedUnits select 0);
	params ["_groupName","_loadoutName"];
	_units = [];
	{
		if (side _x == _side) then
		{
			_typeof = typeOf _x;
			_find = _units findIf {(_x select 2) == _typeof};
			if (_find == -1) then
			{
				_units pushBack [1, _x, _typeof];
			}else
			{
				_element = _units select _find;
				_count = _element select 0;
				_element set [0,_count + 1];
			};
		};
	}forEach playableUnits;
	_units sort false;
	_saveUnits = [];
	{
		if (count _AF_selectedUnits <= 0) exitWith {};
		_type = _x select 2;
		{
			_typeSave = typeOf _x;
			if (_typeSave == _type) exitWith
			{
				_saveUnits pushBack [_x, _typeSave];
				_AF_selectedUnits deleteAt _forEachIndex;
			};
		}forEach _AF_selectedUnits;
	}forEach _units;
	_gear = [];
	{
		_unit = _x select 0;
		_uniform = uniform _unit;
		_vest = vest _unit;
		_back = backpack _unit;
		_head = headgear _unit;
		_weap = primaryWeapon _unit;
		_witem = primaryWeaponItems _unit;
		_wmag = primaryWeaponMagazine _unit;
		_hgun = handgunWeapon _unit;
		_hitem = handgunItems _unit;
		_hmag = handgunMagazine _unit;
		//_second = secondaryWeapon _unit;
		//_sitem = secondaryWeaponItems _unit;
		//_smag = secondaryWeaponMagazine _unit;
		_gear pushback [_x select 1,_uniform,_vest,_back,_head,_weap,_witem,_wmag,_hgun,_hitem,_hmag];
	}forEach _saveUnits;
	_loadout = [str _groupName,str _loadoutName,profileName,_gear];
	copyToClipboard str _loadout;
	["Zapisano loadouty do schowka", 0] call BIS_fnc_3DENNotification;
};