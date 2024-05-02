#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Shows targeted unit info to local player. 
 * Works only for objects of kind "AllVehicles".
 *
 * Arguments:
 * 0: Targeted object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit"];

if !(_unit isKindOf "AllVehicles") exitWith {};

private _unitInfo = [_unit] call fnc_getVehicleInfo;

private _messageParts = [
    [_unitInfo] call fnc_getVehicleDisplayName,
    lineBreak,
    lineBreak,
    "Armor [Front/Sides/Back/Top]:",
    lineBreak,
    _unitInfo getOrDefault ["armor", NO_ARMOR] joinString "/"
];

private _text = composeText _messageParts;
hint _text;