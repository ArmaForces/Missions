#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * //TODO: Fill
 *
 * Arguments:
 * //TODO: Fill
 *
 * Return Value:
 * //TODO: Fill
 *
 * Public: No
 */

params ["_unitOrGroup", ["_key", ""], ["_defaultValue", objNull]];

private _unit = if (_unitOrGroup isEqualType objNull) then {
    vehicle _unitOrGroup
} else {
    vehicle leader _unitOrGroup
};

private _vehicleInfo = VehicleTypes getOrDefault [toUpper typeOf _unit, objNull];
if (_vehicleInfo isEqualTo objNull) exitWith { _defaultValue };

if (_key isEqualTo "") exitWith { _vehicleInfo };

_vehicleInfo getOrDefault [_key, _defaultValue]
