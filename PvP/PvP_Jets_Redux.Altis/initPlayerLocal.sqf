waitUntil {alive player};

player addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];

	if (speed _vehicle > 1 && {damage _vehicle < 1}) exitWith {
		[{_this setDamage 1;}, _vehicle, 5] call CBA_fnc_waitAndExecute;
	};
}];

player setVariable ["ACE_GForceCoef", 0.5];
MDL_PVP_loadout = getUnitLoadout player;

player addEventHandler ["Respawn", {
	params ["_unit", "_corpse"];
	deleteVehicle _corpse;
	player setUnitLoadout MDL_PVP_loadout;

	player setVariable ["ACE_GForceCoef", 0.5];

	[] spawn MDL_PVP_fnc_addACRERadios;
}];
