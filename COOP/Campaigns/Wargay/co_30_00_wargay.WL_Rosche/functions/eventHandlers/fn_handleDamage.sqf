#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Overrides damage handler to ignore default engine damage handling.
 *
 * Arguments:
 * "HandleDamage" EH params
 *
 * Return Value:
 * Damage taken by the unit if overriden <NUMBER/NOTHING>
 *
 * Public: No
 */

params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit", "_context"];

// Exclude total damage info (_context == 0), FakeHeadHit (3) and TotalDamageBeforeBleeding (4)
if (_context isEqualTo 0 || {_context > 2}) exitWith { damage _unit };
            
// Most likely a collision so let the engine handle it
if (_projectile isEqualTo "" && {isNull _instigator}) exitWith {};
// TODO: Consider changing HP afterwards somehow

#ifdef DEV_DEBUG
diag_log format ["WARGAY DEBUG HANDLE DAMAGE [%1]: %2", diag_tickTime, str _this];
#endif

private _selectionHitpointName = getText (configOf _unit >> "Hitpoints" >> _hitPoint >> "name");
private _modelHitpointPosition = _unit selectionPosition _selectionHitpointName;

#ifdef DEV_DEBUG
diag_log format ["WARGAY DEBUG HANDLE DAMAGE [%1]: Model hitpoint name '%2' and position %3", diag_tickTime, _selectionHitpointName, str _modelHitpointPosition];
#endif

if (_modelHitpointPosition isEqualTo [0, 0, 0]) exitWith { damage _unit };

#ifdef DEV_DEBUG
HitpointHits pushBackUnique (_unit modelToWorld _modelHitpointPosition);
#endif

0