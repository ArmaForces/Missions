/*
	AF_fnc_playerTicketsCheck

	Description:
		Respawn z limitem na osoby, nie grupę

	Parameter(s):
		[OBJECT]: _unit - jednostka do sprawdzenia ticketów

	Returns:
		NOTHING
*/
params ["_unit"];
if (!isServer) exitWith {false};
private _find = AF_respawn_array findIf {_x select 0 == _unit};
if (_find != -1) then {
	private _element = AF_respawn_array select _find;
	private _respawns =  _element select 1;
	if (_respawns >= 0) then {
		[_unit, _respawns] remoteExecCall ["BIS_fnc_respawnTickets", _unit, false];
	} else {
		_unit setDamage 1;
		["Skończyły się twoje respawny"] remoteExec ["systemChat", _unit, false];
	};
} else {
	AF_respawn_array pushBack [_unit, AF_respawn_tickets];
	[_unit, AF_respawn_tickets] remoteExecCall ["BIS_fnc_respawnTickets", _unit, false];
};