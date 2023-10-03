/*
	AF_fnc_serverLog

	Description:
		Funkcja loguje tekst po stronie serwera

	Parameter(s):
		_log - Tekst do zalogowania	[STRING]
		_context - Kontekst logu	[ANY]

	Returns:
		NOTHING
*/

_this remoteExec ["AF_fnc_localLog", 2];

nil