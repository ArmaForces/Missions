#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Handles AWACS system loop
 *
 * Example:
 * call afp_scripts_fnc_awacsLoop
 *
 * Public: No
 */

params [["_previouslyDetectedObjects", []]];

#define MIN_ASL_HEIGHT 100
#define MIN_ATL_HEIGHT 100

// Handle "detection"
private _detectedObjects = (vehicles select {
    _x isKindOf "Air"
    && {alive _x
    && {getPosASL _x select 2 >= MIN_ASL_HEIGHT
    && {getPosATL _x select 2 >= MIN_ATL_HEIGHT
    }}}
});

{
    [QGVAR(awacsObjectDetected), [_x]] call CBA_fnc_globalEvent;
} forEach _detectedObjects;

// Run dissapeared event on objects which were detected before but they are no longer visible
_previouslyDetectedObjects = _previouslyDetectedObjects - (_previouslyDetectedObjects arrayIntersect _detectedObjects);
{
    [QGVAR(awacsObjectDisappeared), [_x]] call CBA_fnc_globalEvent;
} forEach _previouslyDetectedObjects;

// Loop
[FUNC(awacsLoop), [_previouslyDetectedObjects], 15] call CBA_fnc_waitAndExecute;