ACRE_Loaded = !isNil "acre_main";

#include "MDL\initFunctions.sqf";
// [] execVM "MDN\initFunctions.sqf";

if (ACRE_Loaded) then {
	{
		[_x, "default", "blufor"] call acre_api_fnc_copyPreset;
		[_x, "default", "redfor"] call acre_api_fnc_copyPreset;

		[_x, "blufor", 1, "frequencyTX", 59.0] call acre_api_fnc_setPresetChannelField;
		[_x, "blufor", 1, "frequencyRX", 59.0] call acre_api_fnc_setPresetChannelField;
		[_x, "blufor", 1, "label", "BLUFOR"] call acre_api_fnc_setPresetChannelField;
		[_x, "blufor", 2, "label", "Shared"] call acre_api_fnc_setPresetChannelField;
		
		[_x, "redfor", 1, "frequencyTX", 60.0] call acre_api_fnc_setPresetChannelField;
		[_x, "redfor", 1, "frequencyRX", 60.0] call acre_api_fnc_setPresetChannelField;
		[_x, "redfor", 1, "label", "REDFOR"] call acre_api_fnc_setPresetChannelField;
		[_x, "redfor", 2, "label", "Shared"] call acre_api_fnc_setPresetChannelField;

		if (hasInterface) then {
			[_x, MDL_PVP_Radio_Presets_Hash get playerSide] call acre_api_fnc_setPreset;
		};
	} forEach ["ACRE_VRC103", "ACRE_PRC117F"];
} else {
	player linkItem "ItemRadio";
};

[] call MDL_PvPJets_fnc_initGameMode;
