/*
	AF_fnc_crashTeleportPlayer

	Description:
		Wczytanie loadoutu i teleport na pozycję sprzed opuszczenia gry

	Parameter(s):
		[ARRAY]: _loadout - loadout sprzed opuszczenia serwera
		[ARRAY]: _pos - pozycja sprzed opuszczenia serwera

	Returns:
		NOTHING
*/

params ["_loadout", "_pos"];

// Jeśli trzeba to przywracamy rzeczy sprzed opuszczenia gry
if (AF_teleportWithItems) then {
	player setUnitLoadout _loadout;
};

// Odliczanie do teleportacji
[10, "<t color='#ff0000' size='3'>Teleport za %1</t><br/>"] call AF_fnc_crashTeleportCountdown;

// Położenie gracza na czas teleportacji i włączenie nieśmiertelności
[{
	player playAction 'PlayerProne';
	titleText ["<t size='3'><br/><br/><br/><br/>I CYK</t><br/>", "PLAIN", 0.2, true, true];
	player allowDamage false;
	player setPosATL _this;
	// Tymczasowa nieśmiertelność
	[5, "Nieśmiertelność przez %1"] call AF_fnc_crashTeleportCountdown;
	[{
		systemChat format ["Koniec nieśmiertelności!"];
		player allowDamage true;
	}, [], 5] call CBA_fnc_waitAndExecute;
}, _pos, 10] call CBA_fnc_waitAndExecute;