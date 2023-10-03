AF_fnc_loadoutItems = 
{
	private _unit = _this select 0;
	_he = ["rhs_VOG25","rhs_mag_M441_HE"];
	_smoke = ["rhs_mag_m713_Red","rhs_GRD40_Red"];
	_handSmoke = "rhs_mag_an_m8hc";
	_handRedSmoke = "rhs_mag_m18_red";
	_handHeGrenade = "rhs_mag_m67";
	
	if (side _unit != WEST) then
	{
		_handSmoke = "rhssaf_mag_brd_m83_white";
		_handRedSmoke = "rhssaf_mag_brd_m83_red";
		_handHeGrenade = "rhs_mag_rgo";
	};
	
	[_unit] call AF_fnc_loadoutUniformSet;
	[_unit] call AF_fnc_LoadoutMedicSet;
	if (isFormationLeader _unit)then
	{
		_unit addItemToVest "Laserbatteries";
		_unit addWeapon "Laserdesignator";
		_unit addItemToVest _handSmoke;
		_unit addItemToVest _handRedSmoke;
		if ((count units group _unit) > 2) then
		{
			_unit addItemToVest "ACRE_PRC152";
		}else
		{
			_unit addItemToBackpack "ACRE_PRC117F";
			_unit addItemToVest "rhs_mag_m18_green";
		};
	}else
	{
		_unit addWeapon "Binocular";
	};
	_primary = true;
	if (primaryWeapon _unit == "") then {_primary = false};
	_mag = "";
	_launcher1 = -1;
	_launcher2 = -1;
	_grenades = [];
	if (_primary) then
	{
		_cls = configFile >> "CfgWeapons" >> primaryWeapon _unit;
		{
			if (_x != "this") then
			{
				_grenades append (getArray(_cls >> _x >> "magazines"));
			};
		} forEach getArray(_cls >> "muzzles");
		_mag = (primaryWeaponMagazine _unit) select 0;
		{
			_grenade1 = _x;
			_launcher1 = _grenades findIf {_x == _grenade1};
			if (_launcher1 != -1) exitWith {};
		}forEach _he;
		{
			_grenade2 = _x;
			_launcher2 = _grenades findIf {_x == _grenade2};
			if (_launcher2 != -1) exitWith {};
		}forEach _smoke;
		for "_i" from 1 to 3 do {_unit addItemToVest _mag};
	};
	_secondaryMags = "";
	if ((handgunWeapon _unit) != "") then
	{
		_secondaryMags = (handgunMagazine _unit) select 0;
		_unit addItemToVest _secondaryMags;
	};
	if (_primary) then
	{
		_unit addItemToVest _handSmoke;
		_unit addItemToVest _handHeGrenade;
		if (_launcher1 != -1)then
		{
			_unit addItemToVest (_grenades select _launcher1);
		};
		_unit addItemToVest _mag;
		if (_launcher1 != -1)then
		{
			for "_i" from 1 to 5 do {_unit addItemToVest (_grenades select _launcher1)};
		};
		if (_launcher2 != -1)then
		{
			_unit addItemToVest (_grenades select _launcher2);
		};
		_unit addItemToVest _mag;
		_unit addItemToVest _handHeGrenade;
		_unit addItemToVest _secondaryMags;
		for "_i" from 1 to 2 do {_unit addItemToVest _mag};
		_unit addItemToVest _handSmoke;
		_unit addItemToVest _secondaryMags;
		for "_i" from 1 to 2 do {_unit addItemToVest _mag};
		if ((getNumber(configFile >> "CfgMagazines" >> (primaryWeaponMagazine _unit) select 0 >> "count")) >= 50) then
		{
			for "_i" from 1 to 10 do {_unit addItemToBackpack _mag};
		};
	};
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemWatch";
	_unit linkItem "ItemRadio";
	_unit linkItem "ItemGPS";
};