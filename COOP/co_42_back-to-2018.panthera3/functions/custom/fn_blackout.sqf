#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Disables/Enables lights in predetermined areas.
 *
 * Arguments:
 * 0: Disable lights <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_lightsEnabled"];

if (!isServer) exitWith {};

private _types = ["Lamps_Base_F", "PowerLines_base_F", "Land_PowerPoleWooden_F", "Land_LampHarbour_F", "Land_LampShabby_F", "Land_PowerPoleWooden_L_F", "Land_PowerPoleWooden_small_F", "Land_LampDecor_F", "Land_LampHalogen_F", "Land_LampSolar_F", "Land_LampStreet_small_F", "Land_LampStreet_F", "Land_LampAirport_F", "Land_PowerPoleWooden_L_F"];
private _markers = ["blackout_1","blackout_2","blackout_3","blackout_4","blackout_5","blackout_6"];

private _damage = [0, 1] select _lightsEnabled;

{
    nearestObjects [getMarkerPos _x, _types, 500]
        apply {_x setDamage _damage};
} forEach _markers;
