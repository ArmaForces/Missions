/*
	AF_fnc_crashTeleportServerHandler

	Description:
		Zapisywanie pozycji oraz loadoutu po crashu Army.
		Wykorzystywane przy teleporcie po powrocie na serwer.

	Parameter(s):
		NOTHING

	Returns:
		NOTHING
*/

if (!isServer) exitWith {false};

// Inicjalizacja tablicy zawierającej tablice [jednostka, pozostałe tickety] dla każdego gracza, który opuścił serwer (np. przez crash)
disconnectArr = [];
addMissionEventHandler ["HandleDisconnect", {
	params ["_unit", "_id", "_uid", "_name"];
	// Sprawdzamy czy gracz już kiedyś opuścił serwer i usuwamy zapisany loadout i pozycję.
	disconnectArr deleteAt (disconnectArr findIf {_uid == (_x#0)});

	// Jeśli gracz był już przez pewien czas w grze to zapisujemy jego loadout i pozycję
	if (_unit getVariable ["AF_crashTeleport_Ready", false]) then {
		private _loadout = getUnitLoadout _unit;
		private _pos = getposATL _unit;
		disconnectArr pushBack [_uid, _loadout, vehicle _unit, _pos];
	};
}];