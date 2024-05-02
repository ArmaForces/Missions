#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Handles damage calculation and applying using HitPart EH data.
 *
 * Arguments:
 * 0: Targeted object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit", "_hitDir", "_hitPositionAGL", "_velocity", "_ammo"];
_ammo params ["_hitValue", "_indirectHitValue", "_indirectHitRange", "_explosiveDamage", "_ammoClassName"];

private _unitType = VehicleTypes getOrDefault [toUpper typeOf _unit, []];
private _unitArmor = if (_unitType isEqualTo []) then { NO_ARMOR } else {
    _unitType getOrDefault ["armor", NO_ARMOR]
};

private _armor = switch (_hitDir) do {
    case "FRONT": { _unitArmor select 0 };
    case "SIDE": { _unitArmor select 1 };
    case "REAR": { _unitArmor select 2 };
    case "TOP": { _unitArmor select 3 };
    default { 0 };
};

private _ammoInfo = AmmoTypes getOrDefault [toUpper _ammoClassName, []];
if (_ammoInfo isEqualTo []) then {
    // Try to recover for small arms as I was lazy and didn't want to copy all the ammo classes
    private _isSmallArms = getNumber (configFile >> "CfgAmmo" >> _ammoClassName >> "caliber") < 1;
    if (_isSmallArms) then {
        private _hashMap = AmmoTypes get "SMALL_ARMS";
        AmmoTypes set [toUpper _ammoClassName, _hashMap];
    };
};
if (_ammoInfo isEqualTo []) exitWith {};

private _ammoDamage = _ammoInfo getOrDefault ["damage", 0];
if (_ammoDamage isEqualTo 0) exitWith {};

private _isUnknownAmmo = false;
private _ammoType = _ammoInfo getOrDefault ["type", "NONE"];
private _damage = switch (_ammoType) do {
    case "AP": { [_armor, _ammoDamage, _velocity] call FUNC(keDamage) };
    case "HEAT": { [_armor, _ammoDamage] call FUNC(heatDamage) };
    case "HE" : {
        private _distanceToTarget = if (_hitPositionAGL isEqualTo []) then { 0 } else { getPosATL _unit distance _hitPositionAGL };
        [_armor, _ammoDamage, _distanceToTarget] call FUNC(heDamage)
    };
    default { _isUnknownAmmo = true; 0 };
};

if (_isUnknownAmmo) exitWith {
    #ifdef DEV_DEBUG
    private _infoMsg = format ["Unknown ammunition '%1' used, ignoring calculations",_ammoClassName];
    systemChat _infoMsg;
    diag_log _infoMsg;
    #endif
};

#ifdef DEV_DEBUG
private _infoMsg = format ["Potential damage: %1 %2, Hit armor: %3 %4, Actual damage: %5", _ammoDamage, _ammoType, _hitDir, _armor, _damage];
systemChat _infoMsg;
diag_log _infoMsg;
#endif

if (_damage isEqualTo 0) exitWith {};

private _currentHp = _unit getVariable ["MDL_currentHp", 10];
private _newHp = _currentHp - _damage;

if (_newHp <= 0) exitWith {
    _unit setVariable ["MDL_currentHp", 0, true];
    {_x setDamage 1} forEach crew _unit;
    _unit setDamage 1;

    private _ehId = _unit getVariable ["MDL_HitPartEHID", -1];
    _unit removeEventHandler ["HitPart", _ehId];
};

#ifdef DEV_DEBUG
systemChat format ["Remaining HP: %1/10", _newHp];
#endif

_unit setVariable ["MDL_currentHp", _newHp, true];
// Limit to 0.8 to avoid explosions when hull or fuel are almost destroyed
_unit setDamage ((_newHp/MAX_HP) min 0.8);
["MDL_showCurrentHp", [_unit], crew _unit] call CBA_fnc_targetEvent;