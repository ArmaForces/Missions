if (!hasInterface) exitWith {};

player addEventHandler ["FiredMan", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
	_AllowedWeapons = ["FIR_CMLauncher", "CMFlareLauncher", "rhsusf_weap_CMFlareLauncher"];
	if (_weapon in _AllowedWeapons) exitwith {};
	if ((player inArea t1) or (vehicle player inArea t1) or (player inArea t2) or (vehicle player inArea t2)) then {
		player setdamage 1;
		vehicle player setdamage [1, false];
		titleText ["NIE STRZELAJ W BAZIE I NIE PRZESZKADZAJ INNYM!\n\n\n\nUPORCZYWE NĘKANIE SKUTKUJE WYRZUCENIEM Z SERWERA LUB BANEM!", "PLAIN"];
	};
}];