/*
	AF_fnc_playerTicketsUpdate

	Description:
		Aktualizacja ticketów osób

	Parameter(s):
		[OBJECT]: _unit - jednostka do zaktualizowania ticketów

	Returns:
		NOTHING
*/
_unit = _this select 0;
_find = AF_respawn_array findIf {_x select 0 == _unit};
if (_find != -1) then {
	_element = AF_respawn_array select _find;
	_element set [1, (_element select 1) - 1];
};