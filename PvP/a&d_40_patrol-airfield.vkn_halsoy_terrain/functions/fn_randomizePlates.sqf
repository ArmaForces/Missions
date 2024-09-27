#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Randomize license plates on vehicle 
 *
 * Arguments:
 * 0: Vehicle to randomize its plates <OBJECT>
 *
 * Return Value:
 * Randomized plate <STRING>
 *
 * Example:
 * [vehicle player] call afp_scripts_fnc_randomizePlates
 *
 * Public: No
 */

params ["_vehicle", ["_originCity", ""]];

if (!isServer) exitWith {};

if (_originCity isEqualTo "") then {
    private _distantChance = 0.2;
    if (random 1 < _distantChance) then {
        _originCity = [selectRandom GVAR(cities)] call FUNC(getLocationName);
    } else {
        _originCity = [_vehicle] call FUNC(getNearestCityName);
    };
};

// Create city plate part
private _cityPartLength = 4;
private _cityRemaining = _originCity;
private _cityPart = [];
// Extract first 4 nonvowels from city name
while {count _cityPart < _cityPartLength && {!(count _cityRemaining isEqualTo 0)}} do {
    private _char = _cityRemaining select [0, 1];
    _cityRemaining = _cityRemaining select [1, count _cityRemaining -1];
    if (!(_char in ["a", "e", "i", "o", "u", "y", " "])) then {
        _cityPart pushBack _char;
    };
};

_cityPart = _cityPart joinString "";
_cityPart = toUpper(_cityPart);

// Create namespace for given city if not yet exists
private _cityPlatesNamespace = GVAR(licensePlates) getVariable [_cityPart, objNull];
if (isNull _cityPlatesNamespace) then {
    _cityPlatesNamespace = call CBA_fnc_createNamespace;
    GVAR(licensePlates) setVariable [_cityPart, _cityPlatesNamespace];
};

// Randomize number until not already taken
private _numberPart = floor (random 9999);
while {_numberPart in allVariables _cityPlatesNamespace} do {
    _numberPart = floor (random 9999);
};

// Check if lower than to add trailing zeors
private _trailingZeros = [];
{
    if (_numberPart < _x) then {
        _trailingZeros append ["0"];
    };
} forEach [1000, 100, 10];
_trailingZeros = _trailingZeros joinString "";
_numberPart = [_numberPart, _trailingZeros] joinString "";

// Assign number to vehicle
_cityPlatesNamespace setVariable [_numberPart, _vehicle];

// Create and set plate number
_licensePlate = format ["%1 - %2", _cityPart, _numberPart];
_vehicle setPlateNumber _licensePlate;
_vehicle setVariable [QGVAR(plateRandomized), true];

_licensePlate