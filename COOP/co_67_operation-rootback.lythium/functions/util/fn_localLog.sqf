/*
	AF_fnc_localLog

	Description:
		Funkcja loguje tekst lokalnie

	Parameter(s):
		_log - Tekst do zalogowania	[STRING]
		_context - Kontekst logu	[ANY]

	Returns:
		NOTHING
*/
params [
	["_log", nil, [""]],
	["_context", ""]
];

if !(_context isEqualTo "") then {_context = format ["[%1] ", str _context]};

diag_log text format ["[ArmaForces] %1%2", _context, _log];

nil