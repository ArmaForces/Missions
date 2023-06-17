#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Checks if there are any duplicated license plates.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * True if no duplicated plates <BOOL>
 *
 * Public: No
 */

if (!isServer) exitWith {};

private _vehicles = vehicles;
private _licensePlateAndVehicle = _vehicles apply {[getPlateNumber _x, _x]};
private _licensePlates = _licensePlateAndVehicle apply {_x select 0};

private _uniquePlateNumbers = _licensePlates arrayIntersect _licensePlates;
{
    private _plateNumber = _x;
    private _index = _licensePlates findIf {_x isEqualTo _plateNumber};
    _licensePlates deleteAt _index;
} forEach _uniquePlateNumbers;

private _duplicatedLicensePlates = _licensePlates - [""];

if (count _duplicatedLicensePlates > 0) then {
    systemChat format ["Duplicated license plates! %1", str _duplicatedLicensePlates];
    {
        private _licensePlate = _x;
        private _vehiclesWithDuplicatedPlate = _licensePlateAndVehicle
            select {_x select 0 isEqualTo _licensePlate}
            apply {
                private _vehicle = _x select 1;
                private _position = getPos _vehicle;
                private _type = typeOf _vehicle;
                [_type, _position]
                };
        systemChat format ["Duplicated license plate: %1, vehicles: %2", _licensePlate, str _vehiclesWithDuplicatedPlate];
    } forEach _duplicatedLicensePlates;
    false
} else {
    true
};
