#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Creates configuration hashmap for given vehicle.
 * Includes className and display name.
 *
 * Arguments:
 * 0: Vehicle to create hashmap for <OBJECT>
 *
 * Return Value:
 * Created hashmap with base properties <HASHMAP>
 *
 * Public: No
 */

params ["_vehicle"];

private _newVehicleInfo = createHashMapFromArray [
    [CLASS_NAME_PROPERTY, toUpper typeOf _vehicle],
	[DISPLAY_NAME_PROPERTY, getText (configOf _vehicle >> DISPLAY_NAME_PROPERTY)],
	["iconPath", "\A3\ui_f\data\map\markers\nato\b_unknown.paa"],
	["markerType", "b_unknown"],
	["pointCost", 5]
];
    
VehicleTypes set [toUpper typeOf _vehicle, _newVehicleInfo];

_newVehicleInfo