#include "\a3\ui_f\hpp\definecommoncolors.inc"

if (!hasInterface) exitWith {};
if (missionNamespace getVariable ["MDL_PVP_configured", false]) exitWith {
    diag_log text "[PVP] INFO: gamemode already configured";
};

diag_log text "[PVP] INFO: configure dialog";

private _display = uiNamespace getVariable "RscDisplayMission";
_display = _display createDisplay "RscDisplayEmpty";
(uiNamespace setVariable ["MDL_PVP_ConfigureDialog", _display]);

_display displayAddEventHandler ["KeyDown", {
    params ["_display", "_dik"];
    if (_dik == 1) exitWith {
        [] spawn {
            disableSerialization;
            private _interruptDisplay = (findDisplay 46) createDisplay "RscDisplayInterrupt";
            waitUntil {_interruptDisplay isEqualTo displayNull};
            [] call MDL_PvPJets_fnc_configureDialog;
        };
    };
    true
}];

if (player != [] call MDL_PVPJets_fnc_getAdmin) exitWith {
    "MDL_PVP_Wait" cutText [localize "STR_LOAD_GAME", "BLACK FADED", 1e10];
};

"MDL_PVP_Wait" cutText ["", "BLACK IN"];
player setVariable ["MDL_PVP_Admin", true];

private _dlgW = safeZoneW / 4;
private _dlgH = safeZoneH / 2;

private _dlgX = safeZoneX + (safeZoneW/2 - _dlgW/2);
private _dlgY = safeZoneY + (safeZoneH/2 - _dlgW/2);

private _titleColor = [
    profileNamespace getVariable ["GUI_BCG_RGB_R", 0.13],
    profileNamespace getVariable ["GUI_BCG_RGB_G", 0.54],
    profileNamespace getVariable ["GUI_BCG_RGB_B", 0.21],
    profileNamespace getVariable ["GUI_BCG_RGB_A", 0.8]
];

private _titleTextColor = [
    profileNamespace getVariable ["GUI_TITLETEXT_RGB_R", 1.0],
    profileNamespace getVariable ["GUI_TITLETEXT_RGB_G", 1.0],
    profileNamespace getVariable ["GUI_TITLETEXT_RGB_B", 1.0],
    profileNamespace getVariable ["GUI_TITLETEXT_RGB_A", 0.6]
];

// full screen background
private _ctrlBg = _display ctrlCreate ["RscBackgroundGUI", -1];
_ctrlBg ctrlSetPosition [safeZoneX, safeZoneY, safeZoneW, safeZoneH];
_ctrlBg ctrlCommit 0;

//--------- dialog layout
// header
private _headerH = _dlgH * 0.05;
private _ctrlHeader = _display ctrlCreate ["RscText", -1];
_ctrlHeader ctrlSetText toUpper localize "STR_AFSG_PvPJets_Configure";
_ctrlHeader ctrlSetTextColor _titleTextColor;
_ctrlHeader ctrlSetBackgroundColor _titleColor;
_ctrlHeader ctrlSetPosition [_dlgX, _dlgY, _dlgW, _headerH - pixelH*2];
_ctrlHeader ctrlCommit 0;

// main controls group
private _mainH = _dlgH * 0.85;
private _ctrlMainGrp = _display ctrlCreate ["RscControlsGroup", -1];
_ctrlMainGrp ctrlSetPosition [_dlgX, _dlgY + _headerH, _dlgW, _mainH];
_ctrlMainGrp ctrlCommit 0;

// footer / button
private _ctrlContinue = _display ctrlCreate ["RscButton", -1];
_ctrlContinue ctrlSetText localize "STR_DISP_HINTC_CONTINUE";
_ctrlContinue ctrlSetPosition [_dlgX, _dlgY + (_headerH + _mainH) + pixelH*2, _dlgW, _dlgH * 0.1 - pixelH*2];
_ctrlContinue ctrlCommit 0;
_ctrlContinue ctrlEnable false;
uiNamespace setVariable ["MDL_PVP_ctrlContinue", _ctrlContinue];

_ctrlContinue ctrlAddEventHandler ["ButtonClick", {
    publicVariable "MDL_PVP_preset";
    publicVariable "MDL_PVP_tickets";
    missionNamespace setVariable ["MDL_PVP_configured", true, true];

    ctrlParent (_this#0) closeDisplay 1;
}];

//-------------------------

private _ctrlPreset = _display ctrlCreate ["RscListBox", -1, _ctrlMainGrp];
_ctrlPreset ctrlSetPosition [0, 0, _dlgW, _mainH * 0.5];
_ctrlPreset ctrlCommit 0;
uiNamespace setVariable ["MDL_PVP_ctrlPreset", _ctrlPreset];

// fill the list of available presets
private _cfgVehicles = configFile >> "CfgVehicles";
{
    private _preset = _y;
    private _idx = _ctrlPreset lbAdd (_preset get "displayName");

    if ([WEST, EAST] findIf {isNull (_cfgVehicles >> (_preset get _x get "plane"))} != -1) then {
        _ctrlPreset lbSetData [_idx, ""];
    } else {
        _ctrlPreset lbSetData [_idx, _x];
    };
} forEach MDL_PVP_presetsHash;

// handle missing preset plane (mods not loaded)
_ctrlPreset ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlPreset", "_idx"];

    private _preset = _ctrlPreset lbData _idx;
    private _planeAvailable = _preset != "";
    private _ctrlContinue = uiNamespace getVariable "MDL_PVP_ctrlContinue";

    _ctrlContinue ctrlEnable _planeAvailable;
    if (!_planeAvailable) then {
        _ctrlContinue ctrlSetTooltip "Selected preset plane is not available";
    } else {
        _ctrlContinue ctrlSetTooltip "Continue and start the Game Mode";
    };

    MDL_PVP_preset = MDL_PVP_presetsHash get _preset;
}];

_ctrlPreset lbSetCurSel 0;

private _ctrlTicketsGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _ctrlMainGrp];
_ctrlTicketsGroup ctrlSetPosition [0, _mainH * 0.5, _dlgW, _mainH * 0.1];
_ctrlTicketsGroup ctrlCommit 0;

private _ctrlTickets = _display ctrlCreate ["ctrlXSliderH", -1, _ctrlTicketsGroup];
_ctrlTickets ctrlSetPosition [0, 0 + pixelH*5/2, _dlgW * 0.7, _mainH * 0.1 - pixelH*5];
_ctrlTickets ctrlCommit 0;
uiNamespace setVariable ["MDL_PVP_ctrlTickets", _ctrlTickets];

_ctrlTickets sliderSetRange [200, 2000];
_ctrlTickets sliderSetSpeed [100, 10, 10];
_ctrlTickets sliderSetPosition MDL_PVP_tickets;
_ctrlTickets ctrlAddEventHandler ["SliderPosChanged", {
    params ["_ctrlTickets", "_value"];

    private _ctrlTicketsText = uiNamespace getVariable "MDL_PVP_ctrlTicketsText";
    _ctrlTicketsText ctrlSetText format [localize "STR_AFSG_PvPJets_ConfigureTickets", sliderPosition _ctrlTickets];

    MDL_PVP_tickets = _value;
}];

private _ctrlTicketsText = _display ctrlCreate ["RscText", -1, _ctrlTicketsGroup];
_ctrlTicketsText ctrlSetPosition [_dlgW * 0.7, 0, _dlgW * 0.3, _mainH * 0.1];
_ctrlTicketsText ctrlCommit 0;
uiNamespace setVariable ["MDL_PVP_ctrlTicketsText", _ctrlTicketsText];
_ctrlTicketsText ctrlSetText format [localize "STR_AFSG_PvPJets_ConfigureTickets", sliderPosition _ctrlTickets];
