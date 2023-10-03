// Moduł do włączania i wyłączania świateł ulicznych. Po postawieniu modułu należy wybrać tryb działania modułu (włącz ustawia setdamage 0, a wyłącz ustawia setdamage 0.95)
// oraz wpisać w jakiej odległości od modułu należy poszukiwać świateł do zmiany ich stanu. Po zadziałaniu moduł wyświetli na czacie informację o efektach działania.

if !(isClass(configFile >> "cfgPatches" >> "achilles_data_f_achilles")) exitWith {};

["!ArmaForces", "Environment - lights blackout",
{
	params [["_ares_module_position", [0,0,0], [[]], 3]];

	private _dialogResult = [
		"Environment - lights blackout",
		[
			["Tryb", ["Włącz światła (ON)", "Wyłącz światła (OFF)"], 0],
			["Zasięg (promień) blackoutu [m]", "", "500"],
			["Dźwięk", ["Nie", "Tak"], 0]
		]
	] call Ares_fnc_showChooseDialog;

	if (_dialogResult isEqualTo []) exitWith {};
	_dialogResult params ["_toggle", "_radius", "_sound"];

	[_ares_module_position, (_toggle > 0), (parseNumber _radius), (_sound > 0)] remoteExecCall ["AF_fnc_toggleNearLights", 0, true];
}
] call Ares_fnc_RegisterCustomModule;