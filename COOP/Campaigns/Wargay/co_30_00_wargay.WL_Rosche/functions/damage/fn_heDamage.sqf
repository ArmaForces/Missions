#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Calculates HE damage.
 *
 * Arguments:
 * 0: Armor value <NUMBER>
 * 1: Ammo base damage <NUMBER>
 * 2: Distance to target <NUMBER>
 *
 * Return Value:
 * Damage <NUMBER>
 *
 * Public: No
 */

params ["_armor", "_ammoBaseDamage", "_distanceToTarget"];

#ifdef DEV_DEBUG
diag_log format ["WARGAY DEBUG HE DAMAGE [%1]: %2 AV, %3 HE, %4 m to target", diag_tickTime, _armor, _ammoBaseDamage, _distanceToTarget];
#endif

fnc_damagePerHe = {
    params ["_armor"];

    if (_armor < 2) exitWith {1};
    if (_armor isEqualTo 2) exitWith {0.4};
    if (_armor isEqualTo 3) exitWith {0.3};
    if (_armor isEqualTo 4) exitWith {0.2};
    if (_armor isEqualTo 5) exitWith {0.15};
    if (_armor < 8) exitWith {0.1};
    if (_armor < 14) exitWith {0.05};
   	0.01
};

private _damage = _ammoBaseDamage * ([_armor] call fnc_damagePerHe);
private _maxDistanceToTarget = _ammoBaseDamage^2 + 1;
private _calculatedDamage = _damage * ((_maxDistanceToTarget - _distanceToTarget)/_maxDistanceToTarget);
0 max _calculatedDamage