#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Shows targeted unit info to local player. 
 * Works only for objects of kind "AllVehicles".
 *
 * Arguments:
 * 0: Targeted object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit"];

if !(_unit isKindOf "AllVehicles") exitWith {};

private _unitInfo = [_unit] call FUNC(getVehicleInfo);

if (_unitInfo isEqualTo objNull) exitWith {};

private _messageParts = [
    [_unitInfo] call FUNC(getVehicleDisplayName),
    lineBreak,
    lineBreak
];

// Get ammo and its damage
private _ammoInfo = [_unit] call FUNC(getAmmoInfo);
if (_ammoInfo isNotEqualTo objNull) then {
    private _ammoInfoText = keys _ammoInfo apply {
        private _displayName = _ammoInfo get _x get DISPLAY_NAME_PROPERTY;
        private _damage = _ammoInfo get _x get DAMAGE_PROPERTY;
        private _damageType = _ammoInfo get _x get TYPE_PROPERTY;
        if (_damage isEqualTo 0 || {_damageType isEqualTo "NONE"}) then { "" } else {
            format ["%1: %2 %3", _displayName, _damage, _damageType];
        };
    } select {_x isNotEqualTo ""};

    if (_ammoInfoText isNotEqualTo []) then {
        _messageParts pushBack "Ammo:";
        _messageParts pushBack lineBreak;

        {
            _messageParts pushBack _x;
            _messageParts pushBack lineBreak;
        } forEach _ammoInfoText;

        _messageParts pushBack lineBreak;
    };
};

private _armorInfoParts = [
    "Armor [Front/Sides/Back/Top]:",
    lineBreak,
    _unitInfo getOrDefault ["armor", NO_ARMOR] joinString "/"
];

_messageParts append _armorInfoParts;

// TODO: Include ammo stats

private _text = composeText _messageParts;
hint _text;