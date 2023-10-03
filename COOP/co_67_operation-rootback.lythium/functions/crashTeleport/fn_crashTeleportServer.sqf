/*
	AF_fnc_crashTeleportServer

	Description:
		Funkcja teleportu po crashu army po stronie serwera

	Parameter(s):
		[OBJECT]: _unit - jednostka gracza
		[STRING]: _uid - uid gracza

	Returns:
		NOTHING
*/
params ["_unit", "_uid"];

// Przekazanie graczowi jego loadoutu sprzed opuszczenia rozgrywki i zlecenie teleportacji
private _index = disconnectArr findIf {_uid == (_x#0)};
if (_index != -1) exitWith {
	[disconnectArr#_index#1, disconnectArr#_index#4] remoteExec ["AF_fnc_crashTeleportPlayer", remoteExecutedOwner];
};