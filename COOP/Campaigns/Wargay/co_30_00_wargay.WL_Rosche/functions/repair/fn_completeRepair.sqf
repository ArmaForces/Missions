#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Completes repair fully repairing vehicle
 *
 * Arguments:
 * 0: Unit being repaired <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_target"];
["MDL_healDamage", [_target]] call CBA_fnc_serverEvent;
systemChat LLSTRING(RepairFinished);
