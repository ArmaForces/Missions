#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 *
 *
 * Arguments:
 * 0: Vehicle to add CB Radio to <VEHICLE>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_vehicle", "_side"];

[_vehicle, ["ACRE_VRC103", "CB Radio", "CB", false, ["inside"], [], CB_RADIO_MODEL, [], ["intercom_1"]], false] call acre_api_fnc_addRackToVehicle;

private _radioPreset = if (_side isEqualTo WEST) then {
    MILITIA_CB_PRESET
} else {
    if (_side isEqualTo EAST) then {
        CHDKZ_CB_PRESET
    } else {
        CIVILIAN_CB_PRESET
    };
};

[_vehicle, _radioPreset] call acre_api_fnc_setVehicleRacksPreset;
[_vehicle] call acre_api_fnc_initVehicleRacks;
