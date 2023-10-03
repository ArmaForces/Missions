/*
	AF_fnc_cacheStop

	Description:
		Funkcja wyłacza skrypt cache

	Parameter(s):
		NOTHING

	Returns:
		Skrypt cache został wyłączony [BOOL]
*/

if (hasInterface && {!scriptDone Madin_cache}) exitWith {

	["Zatrzymywanie skryptu cache"] call AF_fnc_localLog;

	terminate Madin_cache;
	// TODO
	// Włączac symulacje tylko obiektów które były zarządzane przez skrypt?
	{_x enableSimulation true; _x hideObject false;} forEach allUnits;

	true
};

false