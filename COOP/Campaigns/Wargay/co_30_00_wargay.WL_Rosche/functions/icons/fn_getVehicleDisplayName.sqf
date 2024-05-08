#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
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

if (_vehicleOrInfo isEqualType objNull && {!(_vehicleOrInfo isKindOf "AllVehicles")}) exitWith { "" };

private _vehicleInfo = if (_vehicleOrInfo isEqualType objNull) then {
    [_vehicleOrInfo] call FUNC(getVehicleInfo)
} else {
    _vehicleOrInfo
};
    
_vehicleInfo getOrDefault [DISPLAY_NAME_PROPERTY, getText (configFile >> "CfgVehicles" >> (_vehicleInfo get CLASS_NAME_PROPERTY) >> DISPLAY_NAME_PROPERTY), true]