#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3, veteran29
 * Returns displayNameShort for given vehicle type.
 *
 * Arguments:
 * 0: Vehicle or unit info <OBJECT/HASHMAP>
 *
 * Return Value:
 * Short display name of a vehicle type <STRING>
 *
 * Public: No
 */

params ["_vehicleOrInfo"];

if (
    _vehicleOrInfo isEqualType objNull 
    && {!(_vehicleOrInfo isKindOf "AllVehicles")}
) exitWith { "" };

if (_vehicleOrInfo isEqualType objNull) then {
    _vehicleOrInfo = [_vehicleOrInfo] call FUNC(getVehicleInfo);
};

_vehicleOrInfo getOrDefaultCall [
    DISPLAY_NAME_PROPERTY,
    {getText (configFile >> "CfgVehicles" >> (_vehicleOrInfo get CLASS_NAME_PROPERTY) >> DISPLAY_NAME_PROPERTY)},
    true
] // return
