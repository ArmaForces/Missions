#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 *
 *
 * Arguments:
 *
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#define CB_GENERAL_FREQ 67.2
#define EMERGENCY_SERVICES_FREQ 65.3
#define MILITIA_CHDKZ_SHARED_FREQ 69.1

/* MILITIA */

[CB_RADIO_MODEL, "default3", MILITIA_CB_PRESET] call acre_api_fnc_copyPreset;
[CB_RADIO_MODEL, MILITIA_CB_PRESET, 1, "name", "Emergency Services Internal"] call acre_api_fnc_setPresetChannelField;
[CB_RADIO_MODEL, MILITIA_CB_PRESET, 2, "name", "Chedaks Comms"] call acre_api_fnc_setPresetChannelField;
[CB_RADIO_MODEL, MILITIA_CB_PRESET, 3, "name", "CB General"] call acre_api_fnc_setPresetChannelField;
[CB_RADIO_MODEL, MILITIA_CB_PRESET, 19, "name", "CB General"] call acre_api_fnc_setPresetChannelField;

["ACRE_PRC117F", MILITIA_CB_PRESET, 1, "frequencyRX", EMERGENCY_SERVICES_FREQ] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", MILITIA_CB_PRESET, 1, "frequencyTX", EMERGENCY_SERVICES_FREQ] call acre_api_fnc_setPresetChannelField;

["ACRE_PRC117F", MILITIA_CB_PRESET, 2, "frequencyRX", MILITIA_CHDKZ_SHARED_FREQ] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", MILITIA_CB_PRESET, 2, "frequencyTX", MILITIA_CHDKZ_SHARED_FREQ] call acre_api_fnc_setPresetChannelField;

["ACRE_PRC117F", MILITIA_CB_PRESET, 3, "frequencyRX", CB_GENERAL_FREQ] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", MILITIA_CB_PRESET, 3, "frequencyTX", CB_GENERAL_FREQ] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", MILITIA_CB_PRESET, 19, "frequencyRX", CB_GENERAL_FREQ] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", MILITIA_CB_PRESET, 19, "frequencyTX", CB_GENERAL_FREQ] call acre_api_fnc_setPresetChannelField;

/* CHDKZ */

[CB_RADIO_MODEL, "default2", CHDKZ_CB_PRESET] call acre_api_fnc_copyPreset;
[CB_RADIO_MODEL, CHDKZ_CB_PRESET, 1, "name", "Chedaks Internal"] call acre_api_fnc_setPresetChannelField;
[CB_RADIO_MODEL, CHDKZ_CB_PRESET, 2, "name", "Militia Comms"] call acre_api_fnc_setPresetChannelField;
[CB_RADIO_MODEL, CHDKZ_CB_PRESET, 3, "name", "CB General"] call acre_api_fnc_setPresetChannelField;
[CB_RADIO_MODEL, CHDKZ_CB_PRESET, 19, "name", "CB General"] call acre_api_fnc_setPresetChannelField;

["ACRE_PRC117F", CHDKZ_CB_PRESET, 2, "frequencyRX", MILITIA_CHDKZ_SHARED_FREQ] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", CHDKZ_CB_PRESET, 2, "frequencyTX", MILITIA_CHDKZ_SHARED_FREQ] call acre_api_fnc_setPresetChannelField;

["ACRE_PRC117F", CHDKZ_CB_PRESET, 3, "frequencyRX", CB_GENERAL_FREQ] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", CHDKZ_CB_PRESET, 3, "frequencyTX", CB_GENERAL_FREQ] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", CHDKZ_CB_PRESET, 19, "frequencyRX", CB_GENERAL_FREQ] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", CHDKZ_CB_PRESET, 19, "frequencyTX", CB_GENERAL_FREQ] call acre_api_fnc_setPresetChannelField;

/* CIVILIAN */

[CB_RADIO_MODEL, "default", CIVILIAN_CB_PRESET] call acre_api_fnc_copyPreset;
// TODO: Configure 1st channel the same way as 19th
//[CB_RADIO_MODEL, CIVILIAN_CB_PRESET, 1, "name", "CB General"] call acre_api_fnc_setPresetChannelField;
[CB_RADIO_MODEL, CIVILIAN_CB_PRESET, 19, "name", "CB General"] call acre_api_fnc_setPresetChannelField;

["ACRE_PRC117F", CIVILIAN_CB_PRESET, 1, "frequencyRX", CB_GENERAL_FREQ] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", CIVILIAN_CB_PRESET, 1, "frequencyTX", CB_GENERAL_FREQ] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", CIVILIAN_CB_PRESET, 19, "frequencyRX", CB_GENERAL_FREQ] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", CIVILIAN_CB_PRESET, 19, "frequencyTX", CB_GENERAL_FREQ] call acre_api_fnc_setPresetChannelField;

GVAR(cbRadioPresetInitialized) = true;
