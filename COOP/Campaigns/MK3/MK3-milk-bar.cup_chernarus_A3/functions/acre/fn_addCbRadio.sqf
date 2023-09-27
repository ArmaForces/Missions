#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Adds rack with CB Radio to vehicle.
 *
 * Arguments:
 * Vehicle to add CB Radio to it <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_vehicle"];

[{!isNil QGVAR(cbRadioPresetInitialized)}, {
    [_vehicle, ["ACRE_VRC103", "CB Radio", "CB", false, ["inside"], [], "ACRE_PRC117F", [], ["intercom_1"]], true, {}] call acre_api_fnc_addRackToVehicle;
    [_vehicle, "cbradio"] call acre_api_fnc_setVehicleRacksPreset;
    [_vehicle, {}] call acre_api_fnc_initVehicleRacks;
}] call CBA_fnc_waitUntilAndExecute;

GVAR(cbRadioPresetInitialized)
