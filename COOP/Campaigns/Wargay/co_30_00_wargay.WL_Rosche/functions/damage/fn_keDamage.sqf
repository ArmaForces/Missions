#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Wargame Red Dragon KE formula reverse engineered.
 * Not using distance as velocity seems to fit better.
 *
 * Arguments:
 * 0: Armor value <NUMBER>
 * 1: Ammo base damage <NUMBER>
 * 2: Projectile velocity <VECTOR>
 * 3: Projectile initial velocity <VECTOR>
 *
 * Return Value:
 * Damage <NUMBER>
 *
 * Public: No
 */

#define VELOCITY_STEP 125

params ["_armor", "_ammoBaseDamage", "_velocity", "_initialVelocity"];

if (_ammoBaseDamage isEqualTo 0.1) exitWith {
	if (_armor isEqualTo 0) then { _ammoBaseDamage } else { 0 };
};

private _damageFromVelocity = _ammoBaseDamage - ((vectorMagnitude _initialVelocity - vectorMagnitude _velocity) / VELOCITY_STEP);
if (_armor isEqualTo 0) exitWith { 2 * (_ammoBaseDamage max _damageFromVelocity) };
if (_armor isEqualTo 1) exitWith { (_ammoBaseDamage max _damageFromVelocity) };
if (_damageFromVelocity < 0) exitWith { 0 };

// Half for 2 armor, decreasing .5 for every additional armor point
_damageFromVelocity - (_damageFromVelocity/2) - (_armor - 2) * 0.5