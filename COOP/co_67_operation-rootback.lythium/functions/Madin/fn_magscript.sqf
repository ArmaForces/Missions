_unit = _this select 0;
_wantedMags = ["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red","rhs_200rnd_556x45_M_SAW","rhs_30Rnd_545x39_AK_plum_green","rhs_30Rnd_762x39mm_tracer","rhs_100Rnd_762x54mmR_green","30Rnd_556x45_Stanag_Tracer_Yellow","rhsusf_10Rnd_762x51_m62_Mag","rhsusf_20Rnd_762x51_m62_Mag","rhsusf_5Rnd_762x51_m62_Mag","rhsusf_100Rnd_762x51_m62_tracer"];
if ((count (primaryWeaponMagazine _unit)) != 0) then
{
	_currentMag = (primaryWeaponMagazine _unit) select 0;
	if (!(_currentMag in _wantedMags)) then
	{
		_weapMags = getArray(configFile >> "CfgWeapons" >> currentWeapon _unit >> "Magazines");
		_allowedMag = _weapMags arrayIntersect _wantedMags;
		if (count _allowedMag > 0) then
		{
			_magsCount = ({_x == _currentMag} count (magazines _unit));
			_unit removeMagazines _currentMag;
			_unit removePrimaryWeaponItem _currentMag;
			_unit addPrimaryWeaponItem (_allowedMag select 0);
			_unit addMagazines [_allowedMag select 0, _magsCount + 3];
		};
	};
};