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
call FUNC(drawHitDebug);
#endif

// Always draw icon for cursor object;
// TODO: Consider cursorTarget
private _cursorObject = cursorObject;
private _vehiclesWithIcons = if (
    side effectiveCommander _cursorObject isEqualTo side player || {
        (_cursorObject getVariable ["MDL_IsVisible", false]
        && {side effectiveCommander _cursorObject isNotEqualTo SideUnknown})
}) then {
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

switch (GVAR(unitIconMode)) do {
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
        } forEach (vehicles select {
            side effectiveCommander _x isNotEqualTo SideUNKNOWN
            && {side effectiveCommander _x isEqualTo EAST}
            && {_x getVariable ["MDL_IsVisible", false]}});
    };
    default {};
};

// Draws icons. Might draw an icon twice for one object if it's targeted/highlighted.
{
    _x call FUNC(drawIcon);
} forEach _vehiclesWithIcons;