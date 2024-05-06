#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * 
 *
 * Arguments:
 * "HitPart" EH params
 *
 * Return Value:
 * None
 *
 * Public: No
 */

(_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect", "_instigator"];

// if (_selection isEqualTo []) exitWith {};
if (!alive _target) exitWith {
	_target removeEventHandler [_thisEvent, _thisEventHandler];
};

private _isHandledForTarget = _projectile getVariable [str _target, false];

if (_isHandledForTarget) exitWith {};

#ifdef DEV_DEBUG
diag_log format ["WARGAY DEBUG HIT PART [%1]: Selection: %2 Vector: %3, Velocity: %4", diag_tickTime, str _selection, str _vector, str _velocity];
#endif

// Do not handle projectiles coming at a surface at extreme angles
private _velocityAndSurfaceProduct = vectorNormalized _velocity vectorDotProduct _vector;
if (_velocity isNotEqualTo [0, 0, 0] && {_velocityAndSurfaceProduct < 0.15 && {_velocityAndSurfaceProduct > -0.15}}) exitWith {};

private _hitDir = [_target, _vector, _velocity, _position] call FUNC(getHitDir);

#ifdef DEV_DEBUG
PositionHits pushBack (_position);
SurfaceVectors pushBack ([_position, _vector]);
VelocityVectors pushBack ([_position, _velocity]);
#endif

_projectile setVariable [str _target, true];

private _hitPosition = if (_isDirect) then { [] } else { ASLToAGL _position };

[_target, _hitDir, _hitPosition, _velocity, _ammo] call FUNC(calculateAndApplyDamage);
