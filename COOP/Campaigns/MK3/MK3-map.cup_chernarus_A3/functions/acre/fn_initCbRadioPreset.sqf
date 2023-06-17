#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Creates CB Radio preset.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

["ACRE_PRC117F", "default", "cbradio"] call acre_api_fnc_copyPreset;
["ACRE_PRC117F", "cbradio", 1, "label", "CB Radio CH#1"] call
acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", "cbradio", 1, "frequencyRX", 60.1] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", "cbradio", 1, "frequencyTX", 60.1] call acre_api_fnc_setPresetChannelField;

GVAR(cbRadioPresetInitialized) = true;
