#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Returns direction [FRONT/SIDE/REAR/TOP] of the armor that was hit.
 *
 * Arguments:
 * 0: Target hit <OBJECT>
 * 1: Vector prependicular to surface hit <VECTOR>
 * 2: Velocity vector of a projectile <VECTOR>
 * 3: Hit position (AGL world) <POSITION>
 *
 * Return Value:
 * Hit direction one of: FRONT/SIDE/REAR/TOP <STRING>
 *
 * Public: No
 */

params ["_target", "_surfaceVector", "_velocity", "_hitWorldPosition"];

private _hitModelPosition = _target worldToModel _hitWorldPosition;
private _surfaceVectorNormalized = vectorNormalized _surfaceVector;
private _velocityVectorNormalized = vectorNormalized _velocity;

#ifdef DEV_DEBUG
diag_log format ["WARGAY DEBUG GET HIT DIR [%1]: Target: %2, Vector: %3, Velocity: %4, HitPosition: %5", diag_tickTime, _target, _surfaceVector, _velocity, _hitModelPosition];
#endif
    
private _targetDir = vectorDir _target;
    
private _dotProduct = _targetDir vectorDotProduct _surfaceVectorNormalized;
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