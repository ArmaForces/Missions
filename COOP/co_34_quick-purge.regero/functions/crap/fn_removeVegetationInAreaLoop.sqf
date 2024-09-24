#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Removes all vegetation in trigger area.
 *
 * Arguments:
 * Vegetation left to remove <ARRAY<OBJECT>>
 * Delay between removals <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_objects", "_interval"];

private _objectToRemove = _objects deleteAt 0;
deleteVehicle _objectToRemove;
if (!isNil "_objectToRemove") then {
    _objectToRemove hideObjectGlobal true;
};

// systemChat "Object removed";

if (_objects isEqualTo []) exitWith {};

[FUNC(removeVegetationInAreaLoop), [_objects, _interval], _interval] call CBA_fnc_waitAndExecute;