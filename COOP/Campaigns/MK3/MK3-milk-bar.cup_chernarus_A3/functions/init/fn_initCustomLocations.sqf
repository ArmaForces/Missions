#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Initializes custom locations used for intro text.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

if (!isServer) exitWith {};

private _layerEntities = getMissionLayerEntities "CustomLocations";

if (_layerEntities isEqualTo []) exitWith {[]};

_layerEntities select 0 apply {
    private _position = position _x;
    private _area = triggerArea _x;
    private _name = triggerText _x;
    deleteVehicle _x;
    private _areaArray = [_position];
    _areaArray append _area;
    [_name, _areaArray]
}
