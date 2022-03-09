#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Initializes conditions for tasks
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

if (!isServer) exitWith { nil };

GVAR(conditionsWithEvents) = [];

[{
    !alive west_sam;
}, "WestSAMSiteDestroyed"] call FUNC(taskConditionsAdd);

[{
    !alive east_sam;
}, "EastSAMSiteDestroyed"] call FUNC(taskConditionsAdd);

// OLD

// ARTILLERY
[{
    !alive artillery_1 && {!alive artillery_2}
}, "Artillery_Destroyed"] call FUNC(taskConditionsAdd);

// BALOTA RADAR
[{
    !alive balota_radar
}, "Balota_Radar_Destroyed"] call FUNC(taskConditionsAdd);

[{
    !alive cherno_transformer || {!alive cherno_transformer_1 || {!alive cherno_transformer_2}}
}, "Chernogorsk_Transformer_Destroyed"] call FUNC(taskConditionsAdd);

["Balota_Radar_Destroyed", {
    deleteVehicle balota_radar_unit;
}] call CBA_fnc_addEventHandler;

// RADIO TOWERS
{
    private _radioTowerMarker = format ["radio_tower_%1", _x];
    private _generatorName = format ["generator_%1", _radioTowerMarker];
    private _eventName = format ["%1_shutdown", _generatorName];
    private _generator = missionNamespace getVariable [_generatorName, objNull];
    if (!isNull _generator) then {
        [{
            params ["_generator"];
            isNil "_generator" || {!alive _generator}
        }, _eventName, [_generator]] call FUNC(taskConditionsAdd);
    };
} forEach RADIO_TOWERS_LOCATIONS;

[nil] call FUNC(taskConditionsLoop);
