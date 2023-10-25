#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Add keys & lock player synchronized vehicles.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

private _synchronizedObjects = synchronizedObjects player;

{
    if (_x isKindOf "AllVehicles") then {
        private _vehicleDisplayName = getText (configFile >> "CfgVehicles" >> (typeof _x) >> "displayName");
        private _vehiclePlate = getPlateNumber _x;
        INFO_1("Found vehicle %1 (%2)", _vehicleDisplayName, _vehiclePlate);

        [player, _x, true] call ace_vehiclelock_fnc_addKeyForVehicle;
        INFO_1("Created key for vehicle %1 (%2)", _vehicleDisplayName, _vehiclePlate);
        player commandChat format [LLSTRING(OwnedVehicle), _vehicleDisplayName, _vehiclePlate];

        // Lock vehicle
        INFO_1("Locking vehicle %1 (%2)", _vehicleDisplayName, _vehiclePlate);
        [_x, true] call ACE_VehicleLock_fnc_setVehicleLockEH;
    };
} forEach _synchronizedObjects;

nil
