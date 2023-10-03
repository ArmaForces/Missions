["Terminate"] call BIS_fnc_EGSpectator;
player setUnitLoadout playerloadout;

[{alive player}, {
	// Dodanie akcji do zmiany odległości widzenia oraz nazw drużyn
	call AF_fnc_playerActions;
	player addItem "ACE_EarPlugs";
	player setVariable ["AF_crashTeleport_Ready", true, 2];
	// Ustawienie gracza dokładnie na znaczniku respawnu jeśli zostałą wybrana taka opcja
	if (missionNamespace getVariable ["AF_preciseRespawn", false]) then {
		player setPosATL getPosATL respawn_coop;
	};
}, [], -1] call CBA_fnc_waitUntilAndExecute;