#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Draws 3D icon above given unit.
 *
 * Arguments:
 * 0: Alive unit to draw an icon for <OBJECT>
 * 1: Include unit name and HP text <BOOL> (Optional, default false)
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#define ABOVE_UNIT [0, 0, 1.5]

params ["_target", ["_includeText", false]];

if (!alive _target || {_target getVariable ["MDL_currentHp", 0] isEqualTo 0}) exitWith {};
   
private _worldPos = _target modelToWorldVisual ABOVE_UNIT;
private _iconDescription = if (_includeText) then {
    format ["%1 - %2", [_target] call FUNC(getVehicleDisplayName), [_target, " "] call FUNC(currentHpString)]
} else { "" };

private _icon = [_target] call afft_friendly_tracker_fnc_getVehicleMarkerType;
private _iconPath = format ["\A3\ui_f\data\map\markers\nato\%1.paa", _icon];
private _iconSize = (GVAR(unitIconSizeMultiplier) * 0.01 * safeZoneW) / getNumber (configFile >> "CfgInGameUI" >> "Cursor" >> "activeWidth");
private _sideColor = if (side effectiveCommander _target isEqualTo WEST) then { GVAR(westIconColor) } else { GVAR(eastIconColor) };
// #ifdef DEV_DEBUG
// private _icon3DParams = [_iconPath, [_sideColor, [1,1,1,1]], _worldPos, _iconSize, _iconHeight, 0, _iconDescription, 0, 0.02, "EtelkaMonospacePro"];
// diag_log format ["WARGAY DEBUG ICON3D [%1]: Params: %2", diag_tickTime, str _icon3DParams];
// #endif

// TODO: Configurable switch to increase/decrease size with distance
if (GVAR(unitIconSizeDependsOnDistance)) then {
    private _distance = player distance _worldPos;
    private _factor = (2 - ((_distance - 50) * 0.0005)) min 2 max 0.75;
    // private _factor = 2 min (1 max ((_distance - 300) * 0.0014));
    _iconSize = _iconSize * _factor;
};

drawIcon3D [
    _iconPath,
    [_sideColor, [1,1,1,1]],
    _worldPos,
    _iconSize,
    _iconSize,
    0,
    _iconDescription,
    _includeText, // True = outline, False = nothing
    GVAR(unitIconTextSizeMultiplier) * 0.02,
    "EtelkaMonospacePro"
];