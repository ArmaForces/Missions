#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Deletes all markers in given editor layer.
 *
 * Arguments:
 * 0: Editor layer name [STRING]
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_layerName"];

if (!isServer) exitWith { nil };

private _layerEntities = getMissionLayerEntities _layerName;
private _markers = _layerEntities select 1;

{
    deleteMarker _x;
} forEach _markers;

nil