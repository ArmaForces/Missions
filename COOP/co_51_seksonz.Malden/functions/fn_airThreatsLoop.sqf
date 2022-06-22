#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Handles spawning air threats in a loop
 *
 * Example:
 * call afp_scripts_fnc_airThreatsLoop
 *
 * Public: No
 */

#define BLUE_PLANE "KOS_CRO_MiG_29"
#define BLUE_HELI_1 "KOS_CRO_Mi24V_UPK"
#define BLUE_HELI_2 "KOS_CRO_mi17amtsh3_camo"
#define BLUE_HELI_3 "KOS_CRO_Mi24V"

#define RED_PLANE "rhssaf_airforce_o_l_18_101"
#define RED_HELI_1 "rhssaf_airforce_o_ht40"

#define RED_AIR [RED_PLANE, RED_HELI_1]
#define BLUE_AIR [BLUE_PLANE, BLUE_HELI_1, BLUE_HELI_2, BLUE_HELI_3]

#define RED_SPAWN "sys_saf_air_spawn"
#define BLUE_SPAWN "sys_cro_air_spawn"

if (!isServer) exitWith {};

{
	systemChat format ["[AIR-LOOP] Spawning %1", _x#0];
	private _plane = _x call FUNC(spawnPlaneAirborne);
	private _pilot = driver _plane;
	private _waypoint = group _pilot addWaypoint [getMarkerPos "sys_marker_la_trinite", 0];
	_waypoint setWaypointType "SAD";
	_waypoint setWaypointBehaviour "COMBAT";
} forEach [
	[selectRandom BLUE_AIR, BLUE_SPAWN],
	[selectRandom RED_AIR, RED_SPAWN]
];

[FUNC(airThreatsLoop), [], random 600] call CBA_fnc_waitAndExecute;
