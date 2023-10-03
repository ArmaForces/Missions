/*
	AF_fnc_getCommandPwd

	Description:
		Funkcja zwraca hasło do komend z pliku 'userconfig/commandpwd

	Parameter(s):
		NONE

	Returns:
		NOTHING
*/
if (!isServer) exitWith {nil};
if (!isNil "AF_COMMAND_PASSWORD") exitWith {AF_COMMAND_PASSWORD};

#define PASSWORD_FILE			('userconfig\commandpwd')
#define FILE_EXISTS(FILE)		(loadFile (FILE)  != "")

if (!isFilePatchingEnabled) exitWith {
	["Filepatching wyłączone, nie można pobierać hasła z pliku", "AUTORESTART"] call AF_fnc_serverLog;
};

if (!FILE_EXISTS(PASSWORD_FILE)) exitWith {
	[format["Nie odnaleziono pliku z hasłem %1", PASSWORD_FILE], "AUTORESTART"] call AF_fnc_serverLog;
};

AF_COMMAND_PASSWORD = loadFile PASSWORD_FILE;
