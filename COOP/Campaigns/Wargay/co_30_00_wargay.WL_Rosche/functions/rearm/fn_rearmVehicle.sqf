#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Handles rearming vehicle.
 *
 * Arguments:
 * 0: Vehicle to rearm <OBJECT>
 * 1: New ammo amount 0-1 <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_vehicle", ["_ammo", 1]];

_vehicle setVehicleAmmo _ammo;
