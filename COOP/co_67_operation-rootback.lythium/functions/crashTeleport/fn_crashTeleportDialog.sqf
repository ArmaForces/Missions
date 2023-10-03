/*
	AF_fnc_crashTeleportDialog

	Description:
		GUI teleportu

	Parameter(s):
		NOTHING

	Returns:
		NOTHING
*/

disableSerialization;
private _dir = getdir player;
private _pos = getPosATL player;
// Czekaj aż gracz się ruszy i wyświetl mu okno dialogowe o teleportacji
[{alive player && {(_this select 0) != (getdir player) || speed player != 0}},{
	createDialog "AF_dlg_crashTeleport";
	player setVariable ["AF_crashTeleport_Ready",true,2];
}, [_dir, _pos], -1] call CBA_fnc_waitUntilAndExecute;
