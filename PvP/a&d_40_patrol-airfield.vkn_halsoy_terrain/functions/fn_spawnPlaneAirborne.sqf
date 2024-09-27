#include "script_component.hpp"
/*
 * Author: Krystol, 3Mydlo3
 * Does something important
 *
 * Example:
 * call afp_scripts_fnc_spawnPlaneAirborne
 *
 * Public: No
 */

#define DEFAULT_HEIGHT 500

params ["_planeClassname", "_initialPosition"];

if (count _initialPosition isEqualTo 2) then {
	_initialPosition append [DEFAULT_HEIGHT];
};

if (_initialPosition isEqualType "") then {
	_initialPosition = getMarkerPos _initialPosition;
};

private _vehicle = createVehicle [_planeClassname, _initialPosition, [], 0, "FLY"];
createVehicleCrew _vehicle;

_vehicle