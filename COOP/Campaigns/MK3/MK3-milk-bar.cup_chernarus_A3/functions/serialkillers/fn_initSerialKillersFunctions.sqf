#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Initializes stuff necessary for SK functions to work.
 *
 */

// Prepare all location types for getNearestLocation function
GVAR(allLocationTypes) = ("true" configClasses (configFile >> "CfgLocationTypes")) apply {configName _x};

// Location names cache namespace (to prevent reading from config every time)
GVAR(locationNames) = call CBA_fnc_createNamespace;

if (isServer) then {
    GVAR(cities) = call FUNC(getAllMapCities);
};
