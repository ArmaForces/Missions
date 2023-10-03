//Moduł do przełączania działania funkcji w zakresie Faggots. Po postawieniu modułu w pustym miejscu do wyboru: 

//1 - Włącz (powoduje włączenie loga Faggotsów, domyślnie odpala się przy inicie misji), 

//2 - Wyłącz (powoduje wyłączenie loga Faggotsów, należy użyć gdy gracze skończyli robić gnój na starcie i realizują cel misji 
//    oraz gdy chcemy odwołać karanie Faggotsów i umożliwić normalną rozgrywkę),

//3 - Informacja (powoduje wyświetlenie na czacie informacji o aktualnym stanie zmiennej Faggots[], wskazującej kto robi gnój oraz informacji 
//    o ostatnim wpisie zmiennej Faggots_full[], wskazującej wszystkie przewinienia graczy. Wybór ten powoduje też zapisanie w logu
//    .rpt serwera stanu zmiennej Faggots[] oraz pełnego stanu zmiennej Faggots_full[]),

//4 - Ukarz Faggotsów (powoduje ukaranie Faggotsów za wszystkie dotychczasowe przewinienia oraz powoduje karanie każdego kolejnego przewinienia.
//	  Ponadto, jeżeli postawi się moduł Aresa Faggots na konkretnej jednostce gracza i wybierze się wybór nr 4, to ukarany zostanie tylko ten gracz.)

if !(isClass(configFile >> "cfgPatches" >> "achilles_data_f_achilles")) exitWith {};

["!ArmaForces", "!Faggots", 
{
	params [["_ares_module_position", [0,0,0], [[]], 3], ["_object_under_cursor", objNull, [objNull]]];

	_mode_onoff = 1;
	private _dialogResult =
	[
		"Faggots",
		[
			["Tryb",["Faggots - wyłącz (OFF)","Faggots - włącz (ON)","Faggots - informacja","!!!UKARZ FAGGOTSÓW!!!"],2]
		]
	] call Ares_fnc_showChooseDialog;

	if (_dialogResult isEqualTo []) exitWith{};
	_dialogResult params ["_comboBoxResult"];
	_modeonoff = _comboBoxResult;
	
	if (_modeonoff == 0 || _modeonoff == 1) then {[_modeonoff] remoteExecCall ["AF_fnc_faggotsLog",2];};
	if (_comboBoxResult == 2) then {[] remoteExecCall ["AF_fnc_faggotsInfo",2];};
	if (_comboBoxResult == 3) then {[_object_under_cursor] remoteExecCall ["AF_fnc_faggotsPunish",2];};
}
] call Ares_fnc_RegisterCustomModule;