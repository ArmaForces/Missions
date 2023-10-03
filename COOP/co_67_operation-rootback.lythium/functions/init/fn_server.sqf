// Event Handler do zabijania nieprzytomnych AI
["ace_unconscious", AF_fnc_killuncons] call CBA_fnc_addEventHandler;

// Inicjalizacja tablicy zawierającej tablice [jednostka, pozostałe tickety] dla każdego gracza
AF_respawn_array = [];

// Inicjalizacja funkcji dla wszystkich AI
{
	[_x] call AF_fnc_AI_Init;
} forEach allUnits;