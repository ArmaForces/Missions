#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Draws debug hits data.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#ifdef DEV_DEBUG
{
    drawIcon3D ["#(argb,8,8,3)color(1,0,0,1)", [1,1,1,1], _x, 0.25, 0.25, 0, "Hit", 0, 0.03];
} forEach HitpointHits;
{
    drawIcon3D ["#(argb,8,8,3)color(0,0,1,1)", [1,1,1,1], ASLToAGL _x, 0.25, 0.25, 0, "Hit", 0, 0.03];
} forEach PositionHits;
{
    _x params ["_position", "_vector"];
    drawLine3D [ASLToAGL _position, ASLToAGL _position vectorAdd vectorNormalized _vector, [0,1,0,1]];
} forEach SurfaceVectors;
{
    _x params ["_position", "_vector"];
    drawLine3D [ASLToAGL _position, ASLToAGL _position vectorAdd vectorNormalized _vector, [0,0,1,1]];
} forEach VelocityVectors;
#endif
