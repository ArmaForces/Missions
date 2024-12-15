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

private _unitClassName = toUpper typeOf _unit;

private _vehicleInfo = VehicleTypes getOrDefault [_unitClassName, objNull];

// Handle classes that have a parent configured
if (_vehicleInfo isEqualTo objNull) then {

    private _parentClassNames = [configOf _unit, true] call BIS_fnc_returnParents;

    LOG_3("Not found info for '%1'. Found %2 parents: %3",_unitClassName,count _parentClassNames,str _parentClassNames);

    while {_vehicleInfo isEqualTo objNull && {count _parentClassNames > 0}} do {
        private _parent = _parentClassNames deleteAt 0;
        _vehicleInfo = VehicleTypes getOrDefault [toUpper _parent, objNull];
    };

    if (_vehicleInfo isNotEqualTo objNull) then {
        LOG_3("Found matching parent '%1' for '%2' with vehicle info: %3",_vehicleInfo get CLASS_NAME_PROPERTY,_unitClassName,str _vehicleInfo);
        
        // BUG:? It might replace value in original hashmap
        _vehicleInfo set [CLASS_NAME_PROPERTY, _unitClassName];
        _vehicleInfo set [DISPLAY_NAME_PROPERTY, getText (configFile >> "CfgVehicles" >> _unitClassName >> DISPLAY_NAME_PROPERTY)];
        VehicleTypes set [_unitClassName, _vehicleInfo];

        LOG_1("Saved vehicle info: '%1'",str _vehicleInfo);
    } else {
        _vehicleInfo = [_unit] call FUNC(createVehicleInfoForNonConfiguredVehicle);
        LOG_2("Parent not found for '%1', created dummy info: %2",_unitClassName,str _vehicleInfo);
    };
};

LOG_2("Found vehicle info for '%1': %2",_unitClassName,str _vehicleInfo);

if (_key isEqualTo "") exitWith { _vehicleInfo };

_vehicleInfo getOrDefault [_key, _defaultValue]
