ACRE_Loaded = !isNil "acre_main";

#include "MDL\initFunctions.sqf";
// [] execVM "MDN\initFunctions.sqf";

if (ACRE_Loaded) then {
	["ACRE_PRC117F", "default", "blufor"] call acre_api_fnc_copyPreset;
	["ACRE_PRC117F", "default", "redfor"] call acre_api_fnc_copyPreset;

	["ACRE_PRC117F", "blufor", 1, "frequencyTX", 59.0] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "blufor", 1, "frequencyRX", 59.0] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "redfor", 1, "frequencyTX", 60.0] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "redfor", 1, "frequencyRX", 60.0] call acre_api_fnc_setPresetChannelField;
} else {
	player linkItem "ItemRadio";
};

[] call MDL_PvPJets_fnc_initGameMode;
