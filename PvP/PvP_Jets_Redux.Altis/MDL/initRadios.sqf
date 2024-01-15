if (!ACRE_Loaded) exitWith {
    player linkItem "ItemRadio";
};

diag_log text "[PVP] INFO: Setting up ACRE radios";

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
} forEach ["ACRE_PRC117F"];

MDL_PVP_fnc_addACRERadios = {
    waitUntil {alive player};

    // add 2 radios to uniform
    private _loadout = getUnitLoadout player;
    _loadout#3#1 pushBack ["ACRE_PRC117F", 2];
    player setUnitLoadout _loadout;

    waitUntil {[] call acre_api_fnc_isInitialized};

    private _radios = [] call acre_api_fnc_getCurrentRadioList;
    _radios = _radios select {[_x, "ACRE_PRC117F"] call acre_api_fnc_isKindOf};
    private _sideRadio = _radios select 0;
    private _sharedRadio = _radios select 1;

    [[_sideRadio, _sharedRadio]] call acre_api_fnc_setMultiPushToTalkAssignment;
    [_sideRadio] call acre_api_fnc_setCurrentRadio;

    [_sideRadio, 1] call acre_api_fnc_setRadioChannel;
    [_sideRadio, "LEFT" ] call acre_api_fnc_setRadioSpatial;

    [_sharedRadio, 2] call acre_api_fnc_setRadioChannel;
    [_sharedRadio, "RIGHT" ] call acre_api_fnc_setRadioSpatial;
};

[] spawn MDL_PVP_fnc_addACRERadios;
