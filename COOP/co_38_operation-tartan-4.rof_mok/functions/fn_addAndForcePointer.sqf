#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Tries to add given pointer to unit's weapon.
 * When no pointer is specified, random compatible flashlight is added.
 *
 * Arguments:
 * 0: Unit to add pointer <UNIT>
 * 1: Pointer classname <STRING> (Optional)
 *
 * Return Value:
 * True if pointer was added successfully <BOOL>
 *
 * Public: No
 */

params ["_unit", ["_pointerToAdd", ""]];

private _weapon  = currentWeapon _x;
private _pointer = _x weaponAccessories _weapon select 1;

// Add gear to the unit if enabled and the unit does not already have a flashlight
if (_weapon != "" && {_pointer == ""}) then {
    private _cfgWeapons = configFile >> "CfgWeapons";

    // Check if pointer is compatible with given weapon
    private _isPointerCompatible = if (_pointerToAdd isEqualTo "") then {
        // Get all compatible flashlight items for the unit's weapon
        private _flashlights = [_weapon, "pointer"] call CBA_fnc_compatibleItems select {
            getNumber (_cfgWeapons >> _x >> "ItemInfo" >> "FlashLight" >> "size") > 0
        };

        if (_flashlights isEqualTo []) then {
            false
        } else {
            _pointerToAdd = selectRandom _flashlights;
            true
        };
    } else {
        [_weapon, "pointer"] call CBA_fnc_compatibleItems select {
            getNumber (_cfgWeapons >> _x >> "ItemInfo" >> "FlashLight" >> "size") > 0
        } findIf {toUpper _pointerToAdd isEqualTo toUpper _x} != -1;
    };

    // Exit if the flashlight is not compatible with unit's weapon
    if (!_isPointerCompatible) exitwith {};

    // Add a flashlight to the unit's weapon
    [QZENGVAR(common,addWeaponItem), [_x, _weapon, _pointerToAdd], _x] call CBA_fnc_targetEvent;
    [QZENGVAR(common,enableGunLights), [_x, "ForceOn"], _x] call CBA_fnc_targetEvent;

    true
} else {
    false
};
