#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Draws unit icons in Draw3D MissionEventHandler.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#ifdef DEV_DEBUG
{
    drawIcon3D ["#(argb,8,8,3)color(1,0,0,1)", [1,1,1,1], _x, 0.25, 0.25, 0, "Hit", 0, 0.03];
} forEach HitpointHits;
{
    drawIcon3D ["#(argb,8,8,3)color(0,0,1,1)", [1,1,1,1], ASLToAGL _x, 0.25, 0.25, 0, "Hit", 0, 0.03];
} forEach PositionHits;
{
    _x params ["_position", "_vector"];
    drawLine3D [ASLToAGL _position, ASLToAGL _position vectorAdd vectorNormalized _vector, [0,1,0,1]];
} forEach SurfaceVectors;
{
    _x params ["_position", "_vector"];
    drawLine3D [ASLToAGL _position, ASLToAGL _position vectorAdd vectorNormalized _vector, [0,0,1,1]];
} forEach VelocityVectors;
#endif

// Always draw icon for cursor object;
// TODO: Consider cursorTarget
private _cursorObject = cursorObject;
private _vehiclesWithIcons = if (_cursorObject getVariable ["MDL_IsVisible", false] && {side effectiveCommander _cursorObject isNotEqualTo SideUnknown}) then {
    [[_cursorObject, true]]
} else { [] };

curatorMouseOver params ["_type", "_entity", "_index"];
if (_type isEqualTo "OBJECT") then {
    _vehiclesWithIcons pushBackUnique [_entity, true];
};
if (_type isEqualTo "GROUP") then {
    {
        _vehiclesWithIcons pushBackUnique [_x, true];
    } forEach ([_entity] call FUNC(getGroupVehicles));
};
    
curatorSelected params ["_objects", "_groups"];
{
    _vehiclesWithIcons pushBackUnique [_x, true];
} forEach _objects;
{
    {
        _vehiclesWithIcons pushBackUnique [_x, true];
    } forEach ([_x] call FUNC(getGroupVehicles));
} forEach _groups;

switch (IconMode) do {
    // Friendly and enemy
    case 0: {
        {
            _vehiclesWithIcons pushBackUnique [_x, false];
        // } forEach (vehicles select {
        //     side effectiveCommander _x isNotEqualTo SideUNKNOWN && side effectiveCommander _x isNotEqualTo EAST
        //     || {(side effectiveCommander _x isEqualTo EAST && {player knowsAbout _x > 1})}});
        } forEach (vehicles select {
            side effectiveCommander _x isNotEqualTo SideUNKNOWN && side effectiveCommander _x isNotEqualTo EAST
            || {(side effectiveCommander _x isEqualTo EAST && {_x getVariable ["MDL_IsVisible", false]})}});
    };
    // Enemy only
    case 1: {
        {
            _vehiclesWithIcons pushBackUnique [_x, false];
        } forEach (vehicles select {side effectiveCommander _x isNotEqualTo SideUNKNOWN && {side effectiveCommander _x isEqualTo EAST}});
    };
    default {};
};

// Draws icons. Might draw an icon twice for one object if it's targeted/highlighted.
// TODO: Don't draw icons off-screen
{
    _x call FUNC(drawIcon);
} forEach _vehiclesWithIcons;