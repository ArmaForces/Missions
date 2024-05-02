#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Returns displayNameShort for given vehicle type.
 *
 * Arguments:
 * //TODO: Fill
 *
 * Return Value:
 * Short display name of a vehicle type <STRING>
 *
 * Public: No
 */

params ["_vehicleOrInfo"];

if (_vehicleOrInfo isEqualType objNull && {!(_vehicleOrInfo isKindOf "AllVehicles")}) exitWith { "" };

private _vehicleInfo = if (_vehicleOrInfo isEqualType objNull) then {
    private _retrievedVehicleInfo = VehicleTypes getOrDefault [toUpper typeOf _vehicleOrInfo, objNull];

	if (_retrievedVehicleInfo isEqualTo objNull) then {
        _retrievedVehicleInfo = [_vehicleOrInfo] call FUNC(createVehicleInfoForNonConfiguredVehicle);
    };

    _retrievedVehicleInfo
} else {
    _vehicleOrInfo
};
    
_vehicleInfo getOrDefault [DISPLAY_NAME_PROPERTY, getText (configFile >> "CfgVehicles" >> (_vehicleInfo get "className") >> DISPLAY_NAME_PROPERTY), true]