/*
	AF_fnc_restartAfterMissionEnd

	Description:
		Funkcja powoduje restart servera po końcu misji

	Parameter(s):
		NONE

	Returns:
		NOTHING
*/
#define AUTORESTART_DELAY	60 * 25


if (!isServer) exitWith {};
if (isNil {[] call AF_fnc_getCommandPwd}) exitWith {
	["Brak hasła do komend, nie można włączyć restartu po końcu misji", "AUTORESTART"] call AF_fnc_serverLog;
};

[format ["Włączanie autorestartu za: %1", AUTORESTART_DELAY], "AUTORESTART"] call AF_fnc_serverLog;

[{
	private _restartStatus = ([] call AF_fnc_getCommandPwd) serverCommand '#restartserveraftermission';
	if (_restartStatus) then {
		["Włączono autorestart po końcu misji", "AUTORESTART"] call AF_fnc_serverLog;
	} else {
		["Niepowodzenie podczas włączania komendy do autorestartu po misji (błędne hasło?)", "AUTORESTART"] call AF_fnc_serverLog;
	};
}, nil, AUTORESTART_DELAY] call CBA_fnc_waitAndExecute;