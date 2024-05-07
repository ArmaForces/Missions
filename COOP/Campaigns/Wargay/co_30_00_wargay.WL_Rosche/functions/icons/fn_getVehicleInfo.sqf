#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Retrieves vehicle info hashmap for given unit or group (leader vehicle) if available.
 *
 * Arguments:
 * 0: Unit or group to get its vehicle <OBJECT/GROUP>
 * 1: Unit info key <STRING> (Optional, if empty whole hashmap is returned)
 * 2: Default value if key or unit info doesn't exist <ANY>
 *
 * Return Value:
 * Unit info <HASHMAP> or <ANY> retrieved or default value
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
