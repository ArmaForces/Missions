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
 *
 * Return Value:
 * Damage <NUMBER>
 *
 * Public: No
 */

#define BASE_AP_SPEED 1300
#define VELOCITY_STEP 150

params ["_armor", "_ammoBaseDamage", "_velocity"];

private _damageFromVelocity = _ammoBaseDamage - ((BASE_AP_SPEED - vectorMagnitude _velocity) / VELOCITY_STEP);

if (_armor isEqualTo 0) exitWith { 2 * (_ammoBaseDamage max _damageFromVelocity) };
if (_armor isEqualTo 1) exitWith { (_ammoBaseDamage max _damageFromVelocity) };
if (_damageFromVelocity < 0) exitWith { 0 };

// Half for 2 armor, decreasing .5 for every additional armor point
_damageFromVelocity - (_damageFromVelocity/2) - (_armor - 2) * 0.5