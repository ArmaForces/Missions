#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3, veteran29
 * Returns path to icon corresponding to given vehicle type.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_vehicle"];

private _iconType = _vehicle getVariable ["MDL_iconPath", ""];

if (_iconType isNotEqualTo "") exitWith { _iconType };

private _vehicleInfo = [_vehicle] call FUNC(getVehicleInfo);

private _iconPath = _vehicleInfo getOrDefault [
    "iconPath",
    "\A3\gui_f\data\map\markers\nato\b_unknown.paa",
    true
];

_vehicle setVariable ["MDL_iconPath", _iconPath];

_iconPath
