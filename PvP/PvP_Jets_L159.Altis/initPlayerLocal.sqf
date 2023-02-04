waitUntil {vehicle player == player};
playerloadout = getUnitLoadout player;
player setVariable ["ACE_GForceCoef", 0.5];

player addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];

	if (speed _vehicle > 1 && {damage _vehicle < 1}) exitWith {
		[{_this setDamage 1;}, _vehicle, 5] call CBA_fnc_waitAndExecute;
	};
}];
