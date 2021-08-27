#include "script_component.hpp"

if (!isNil QUOTE(RESPAWN_HELPER_VR)) then {
    createMarker ["respawn", position RESPAWN_HELPER_VR];
};

GVAR(cities) = call FUNC(getAllMapCities);
GVAR(citiesCount) = count GVAR(cities);
GVAR(licensePlates) = call CBA_fnc_createNamespace;

private _civilianVehicles = vehicles select {
    _x isKindOf "AllVehicles"
    && {getNumber (configFile >> "CfgVehicles" >> typeOf _x >> "side") isEqualTo 3}
};

// Randomize plates for all civilian vehicles
if (GVAR(citiesCount) > 0) then {
    {
        [_x] call FUNC(randomizePlates);
    } forEach _civilianVehicles;
};

// Randomize damage
{
    private _vehicle = _x;
    {
        _vehicle setHitPointDamage [_x, random 1];
    } forEach (getAllHitPointsDamage _x select 0);
} forEach _civilianVehicles;
