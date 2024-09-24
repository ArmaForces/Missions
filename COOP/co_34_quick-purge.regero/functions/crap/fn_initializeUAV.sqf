#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Initializes UAV loiter
 *
 * Arguments:
 * UAV vehicle to initialize <OBJECT/STRING>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_uav", ["_position", LOITER_POSITION]];

if (_uav isEqualType "") then {
    _uav = createVehicle [_uav, [0, 0, 0], [], 100, "FLY"];
    createVehicleCrew _uav;
};

_uav enableUAVWaypoints false;
_uav lockDriver true;
// _uav flyInHeight LOITER_HEIGHT;
_uav setGroupIdGlobal ["Hawk Eye"];
_uav setFuel 1;
_uav setFuelConsumptionCoef 0.25;

// Create loiter waypoint
private _waypoint = group driver _uav addWaypoint [_position, 0];
_waypoint setWaypointBehaviour "CARELESS";
_waypoint setWaypointCombatMode "BLUE";
_waypoint setWaypointSpeed "LIMITED";
_waypoint setWaypointType "LOITER";
_waypoint setWaypointLoiterRadius LOITER_RADIUS;
_waypoint setWaypointLoiterAltitude LOITER_HEIGHT;

// Make it airborne if it's not
if ((getPosATL _uav select 2) < 1) then {
    private _initialHeight = 250 max (LOITER_HEIGHT - 1000);
    private _uavPosition = getPosASL _uav;
    _uavPosition set [2, (_uavPosition select 2) + _initialHeight];
    _uav setPosASL _uavPosition;
};

// Add some initial speed
_uav setVelocity (vectorDir _uav vectorMultiply 300);

[{
    params ["_uav", "_position"];
    _uav distance2D _position < (LOITER_RADIUS + 0.1 * LOITER_RADIUS)
}, {
    params ["_uav"];
    [_uav, "Hawk Eye on station"] remoteExec ["sideChat", 0];
}, [_uav, _position], 900] call CBA_fnc_waitUntilAndExecute;
