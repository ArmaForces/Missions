/*
	AF_fnc_playerEHs

	Description:
		Dodaje różne EventHandlery dla graczy

	Parameter(s):
		NOTHING

	Returns:
		NOTHING
*/

// Respawn
if (isDedicated) exitwith {false};
player addEventHandler ["Killed", {
	[{
		_tickets = [playerSide] call BIS_fnc_respawnTickets;
		if (_tickets > 0) then
		{
			_a = serverTime / AF_respawnTime;
			_b = ceil _a;
			_c = AF_respawnTime + (_b - _a) * AF_respawnTime;
			setPlayerRespawnTime _c;
		};
	},[]] call CBA_fnc_execNextFrame;
}];

// Ukryta serbska opcja
player addEventHandler ["GetOutMan", {
	if (!AF_hiddenSerbianOption) exitWith {};
	[{
		[player, true, 2, true] call ace_medical_fnc_setUnconscious;
	}, nil, 0.3] call CBA_fnc_waitAndExecute;
}];
