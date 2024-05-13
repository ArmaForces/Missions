#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Completes refueling fully fueling vehicle
 *
 * Arguments:
 * 0: Unit being refueled <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_target"];
["MDL_refuelVehicle", [_target, 1]] call CBA_fnc_globalEvent;
systemChat LLSTRING(RefuelFinished);
