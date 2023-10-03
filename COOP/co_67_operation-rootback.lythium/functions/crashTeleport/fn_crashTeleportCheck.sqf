/*
	AF_fnc_crashTeleportCheck

	Description:
		Sprawdzanie, czy gracz ma zostać teleportowany i wyświetlenie mu dialogu czy chce teleportacji tam gdzie był.

	Parameter(s):
		[OBJECT]: _unit - jednostka gracza
		[STRING]: _uid - uid gracza

	Returns:
		NOTHING
*/

params ["_unit", "_uid"];

// Sprawdzenie czy gracz jest na liście tych, którzy opuścili grę i wyświetlenie mu okna dialogowego o teleportacji
private _index = disconnectArr findIf {_uid == (_x#0)};
if (_index != -1) exitWith {
	[] remoteExec ["AF_fnc_crashTeleportDialog", remoteExecutedOwner];
};