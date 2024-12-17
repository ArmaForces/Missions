#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Removes all vegetation in trigger area.
 *
 * Arguments:
 * Area <TRIGGER>
 * Duration it will take to remove all vegetation <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_trigger", ["_removalDuration", -1]];

// systemChat "Removing vegetation in area";

private _triggerArea = triggerArea _trigger;
private _longerSide = (_triggerArea select 0) max (_triggerArea select 1);

private _weedBushes = nearestTerrainObjects [getPosATL _trigger, ["Tree", "Bush"], _longerSide];

private _inAreaVegetation = _weedBushes inAreaArray _trigger;

private _interval = _removalDuration / count _inAreaVegetation;

// systemChat format ["%1 objects to remove in %2, with %3 interval", count _inAreaVegetation, _removalDuration, _interval];

[FUNC(removeVegetationInAreaLoop), [_inAreaVegetation, _interval], _interval] call CBA_fnc_waitAndExecute;
