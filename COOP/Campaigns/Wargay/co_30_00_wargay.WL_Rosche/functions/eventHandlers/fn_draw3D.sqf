#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3, veteran29
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

// Always draw icon for cursor object
// Not using cursorTarget to avoid issues with knowledge that might be lagging
private _cursorObject = cursorObject;
private _vehiclesWithIcons = if (
    side effectiveCommander _cursorObject isEqualTo playerSide || {
        (_cursorObject getVariable ["MDL_IsVisible", false]
        && {side effectiveCommander _cursorObject isNotEqualTo sideUnknown})
}) then {
    [[_cursorObject, true]]
} else { [] };

switch (GVAR(unitIconMode)) do {
    // Friendly and enemy
    case 0: {
        _vehiclesWithIcons append (vehicles select {(
                side effectiveCommander _x isEqualTo playerSide
            ) || {
                _x getVariable ["MDL_IsVisible", false]
                && {side effectiveCommander _x isEqualTo EAST}
            }
        });
    };
    // Enemy only
    case 1: {
        _vehiclesWithIcons append (vehicles select {
            _x getVariable ["MDL_IsVisible", false]
            && {side effectiveCommander _x isEqualTo EAST}
        });
    };
    default {};
};

// curator icons
if (!isNull findDisplay 312) then {
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
};

// Draws icons. Might draw an icon twice for one object if it's targeted/highlighted.
{
    _x call FUNC(drawIcon);
} forEach _vehiclesWithIcons;
