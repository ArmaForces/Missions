#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Calculates damage of a HEAT projectile based on armor and ammo base damage.
 * HEAT always does at least 1 dmg.
 *
 * Arguments:
 * 0: Armor value <NUMBER>
 * 1: Ammo base damage <NUMBER>
 *
 * Return Value:
 * Damage <NUMBER>
 *
 * Public: No
 */

params ["_armor", "_ammoBaseDamage"];
    
if (_armor isEqualTo 0) exitWith { _ammoBaseDamage * 2 };
private _standardDamage = ((_ammoBaseDamage - _armor)/2) + 1;
    
// 1 dmg for each 1 AP above 10 difference from armor value (e.g., 13 AP vs 2 AV = 1 dmg)
private _extraDamage = 0 max (_ammoBaseDamage - _armor - 10);
    
// HEAT always does at least 1 dmg
1 max (_standardDamage + _extraDamage)
