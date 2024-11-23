/*
 * Author: 3Mydlo3
 * Function returns all available vehicles from config by desired class and side
 *
 * Arguments:
 * 0: vehicle class [STRING] (armored, car, air)
 * 1: vehicle side [SIDE]
 *
 * Return Value:
 * 0: array of vehicles [ARRAY]
 *
 * Example:
 * ["Armored", "WEST"] call AL_fnc_getVehiclesFromConfig
 *
 * Public: No
 */

params [["_vehicleClass", "All"], ["_vehicleSide", "All"]];

_vehicleSide = switch (_vehicleSide) do {
	case EAST: {0};
	case WEST: {1};
	case INDEPENDENT: {2};
	case CIVILIAN: {3};
	default {"All"};
};

private _additionalCondition = "";

switch (true) do {
	case !(_vehicleClass isEqualTo "All" && {!(_vehicleSide isEqualTo "All")}): {
		_additionalCondition = format ["&& 
			{
				getText (_x >> 'vehicleClass') in ['%1'] && 
				{ getNumber (_x >> 'side') == %2 }
			}
		)", _vehicleClass, _vehicleSide];
	};
	case !(_vehicleClass isEqualTo "All"): {
		_additionalCondition = format ["&& 
			{
				getText (_x >> 'vehicleClass') in ['%1']
			}
		)", _vehicleClass];
	};
	case !(_vehicleSide isEqualTo "All"): {
		_additionalCondition = format ["&& 
			{
				getText (_x >> 'vehicleClass') in ['Armored', 'Car', 'Air', 'Ship'] && 
				{ getNumber (_x >> 'side') == %1 }
			}
		)", _vehicleSide];
	};
	default {};
};

private _condition = format ["( (getNumber (_x >> 'scope') >= 2) %1", [_additionalCondition, " )"] select (_additionalCondition isEqualTo "")];

private _vehicleConfigs = _condition configClasses (configFile >> "CfgVehicles");

private _vehicles = [];
{
	_vehicles pushBack [getText (_x >> "displayName"), configName _x];
} forEach _vehicleConfigs;

_vehicles