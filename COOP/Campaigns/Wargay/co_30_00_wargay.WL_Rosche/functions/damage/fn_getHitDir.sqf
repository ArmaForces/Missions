#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Returns direction [FRONT/SIDE/REAR/TOP] of the armor that was hit.
 *
 * Arguments:
 * 0: Target hit <OBJECT>
 * 1: Vector prependicular to surface hit <VECTOR>
 * 2: Velocity vector of a projectile <VECTOR>
 * 3: Projectile <OBJECT>
 *
 * Return Value:
 * Hit direction one of: FRONT/SIDE/REAR/TOP <STRING>
 *
 * Public: No
 */

params ["_target", "_surfaceVector", "_velocity", "_projectile"];

private _hitDirVectorNormalized = if (_velocity isEqualTo [0, 0, 0]) then {
	#ifdef DEV_DEBUG
	HitpointHits pushBack getPosATL _projectile;
	#endif
	getPosATL _target vectorDiff getPosATL _projectile vectorMultiply -1
} else {
	vectorNormalized _surfaceVector
};

#ifdef DEV_DEBUG
diag_log format ["WARGAY DEBUG GET HIT DIR [%1]: Target position: %2 Projectile position: %3", diag_tickTime, getPosATL _target, getPosATL _projectile];
SurfaceVectors pushBack [getPosASL _target vectorAdd [0, 0, 1], getPosATL _target vectorDiff getPosATL _projectile vectorMultiply -1];
ProjectileRelPosVectors pushBack [getPosATL _target vectorAdd [0, 0, 1], _hitDirVectorNormalized];

diag_log format ["WARGAY DEBUG GET HIT DIR [%1]: Target: %2, Vector: %3, Velocity: %4, HitVector: %5", diag_tickTime, _target, _surfaceVector, _velocity, _hitDirVectorNormalized];
#endif
    
private _targetDir = vectorDir _target;
#ifdef DEV_DEBUG
TargetDirVectors pushBack [getPosATL _target vectorAdd [0, 0, 1], _targetDir];
#endif

private _dotProduct = _targetDir vectorDotProduct _hitDirVectorNormalized;
private _topHitDir = _surfaceVector#2 atan2 sqrt (_surfaceVector#0^2 + _surfaceVector#1^2);
    
private _hitDir = if (_topHitDir > 70) then {
	"TOP"
} else {
    if (_dotProduct > 0.5) exitWith { "FRONT" };
    if (_dotProduct < -0.5) exitWith { "REAR" };
	"SIDE"
};

#ifdef DEV_DEBUG
diag_log format ["WARGAY DEBUG GET HIT DIR [%1]: Target Dir: %2, Dot product: %3, Top='%4'", diag_tickTime, _targetDir, _dotProduct, _topHitDir];
#endif

_hitDir