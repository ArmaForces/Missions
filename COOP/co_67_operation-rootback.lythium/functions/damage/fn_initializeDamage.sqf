/*
	AF_fnc_initializeDamage

	Description:
		Inicjalizuje obsługe obrażeń ArmaForces

	Parameter(s):
		NOTHING

	Returns:
		Zainicjalizowano [BOOL]
*/

if (hasInterface) then {
	["Inicjalizacja systemu obrażeń"] call AF_fnc_localLog;

	AF_painLayer_priority = -10000;

	[{!isNull player}, {
		player call AF_fnc_addDamageHandlers;

		player addEventHandler ["Respawn", {
			params ["_unit"];

			_unit call AF_fnc_addDamageHandlers;
			_unit setVariable ["AF_heartAttack", false, true];
		}];

		// Initialize damage state loop
		[] call AF_fnc_checkVitalsLoop;

	}] call CBA_fnc_waitUntilAndExecute;
};

true
