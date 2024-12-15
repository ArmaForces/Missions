#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Handles refueling vehicle.
 *
 * Arguments:
 * 0: Vehicle to refuel <OBJECT>
 * 1: New fuel amount 0-1 <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_vehicle", ["_fuel", 1]];

_vehicle setFuel _fuel;
