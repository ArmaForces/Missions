// Moduły do dźwieków, są dwa:

// 1 - pierwszy, pozwalający na odtwarzanie dźwieków w miejscu postawienia modułu (zarówno dźwięki odgórnie zdefiniowane oraz te znajdujące się w katalogu \Sounds),

// 2 - drugi, który pozwala ustawić typ dźwięku oraz opcje zmiany głośności dźwięku [dB] i odległości [m] od miejsca postawienia modułu, w której głośność odtwarzanego dźwięku będzie już równa 0.


// Pierwszy

if (isServer) then {
	private _sound_folder_server = MISSION_LOC + "Sounds\";
	private _sound_types_import_string = "FilesInFolderArma" callExtension (_sound_folder_server);
	AF_ares_sound_types_import_array = _sound_types_import_string splitstring ",";
	publicVariable "AF_ares_sound_types_import_array";
};

if !(isClass(configFile >> "cfgPatches" >> "achilles_data_f_achilles")) exitWith {};

AF_ares_sound_type = "";
AF_ares_sound_volume = 10;
AF_ares_sound_range = 100;
AF_sound_folder = MISSION_LOC + "Sounds\";

["!ArmaForces", "Sound - select",
{
	private _predefined_sounds = [] + ["Dog (random, 3)", "Owl (random, 3)"];
	private _sound_types_array = _predefined_sounds + AF_ares_sound_types_import_array;

	private _dialogResult = [
		"Sound - select",
		[
			["Dźwięk", _sound_types_array, 0],
			["Głośność dźwięku [+dB]", "", "10"],
			["Zasięg dźwięku [m]", "", "50"]
		]
	] call Ares_fnc_showChooseDialog;

	if (_dialogResult isEqualTo []) exitWith {};
	_dialogResult params ["_comboBoxResult", "_sound_volume_local", "_sound_range_local"];

	private _sound_type_local = _sound_types_array select _comboBoxResult;

	systemchat ("Wybrano pozycję nr "+(str _comboBoxResult)+", dzwiek to "+_sound_type_local+", glosnosc to +"+_sound_volume_local+" dB, a zasieg dzwieku to "+_sound_range_local+" m");

	AF_ares_sound_type = _sound_type_local;
	AF_ares_sound_volume = parseNumber _sound_volume_local;
	AF_ares_sound_range = parseNumber _sound_range_local;

}] call Ares_fnc_RegisterCustomModule;


// Drugi

["!ArmaForces", "Sound - spawn",
{
	params [["_ares_module_position", [0,0,0], [[]], 3]];

	private _sound_to_play = AF_ares_sound_type;
	if (_sound_to_play isEqualTo "") exitWith {
		["Nie wybrano żadnego dźwieku!"] call Achilles_fnc_showZeusErrorMessage;
	};

	private _sound_to_play_src = switch (_sound_to_play) do {
		case "Dog (random, 3)": {selectRandom ["A3\Sounds_F\ambient\animals\dog1.wss","A3\Sounds_F\ambient\animals\dog2.wss","A3\Sounds_F\ambient\animals\dog3.wss"]};
		case "Owl (random, 3)": {selectRandom ["A3\Sounds_F\ambient\animals\owl1.wss","A3\Sounds_F\ambient\animals\owl2.wss","A3\Sounds_F\ambient\animals\owl3.wss"]};
		default {_sound_to_play};
	};

	if (_sound_to_play_src find "A3\Sounds" == -1) then {_sound_to_play_src = (AF_sound_folder + _sound_to_play_src)};
	systemchat ("Odtwarzam dźwięk - "+ _sound_to_play);

	playSound3D [
		_sound_to_play_src,
		objNull,
		false,
		AGLToASL _ares_module_position,
		AF_ares_sound_volume,
		1,
		AF_ares_sound_range
	];

}] call Ares_fnc_RegisterCustomModule;
