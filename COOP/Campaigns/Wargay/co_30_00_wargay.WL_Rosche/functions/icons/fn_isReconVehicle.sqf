#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Checks if given unit or group is recon.
 *
 * Arguments:
 * 0: Unit or group to check if it's recon <OBJECT/GROUP>
 *
 * Return Value:
 * True if vehicle of a unit (or his leader) is recon <BOOL>
 *
 * Public: No
 */

params ["_unitOrGroup"];

[_unitOrGroup, "isRecon", false] call FUNC(getVehicleInfo) isEqualTo 1
