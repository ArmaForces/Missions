if (!isServer) exitWith {};

heli_spawn_location = "Land_HelipadSquare_F";
heli_spawn_point = "VR_3DSelector_01_exit_F";
plane_spawn_location = "Land_HelipadEmpty_F";
plane_spawn_point = "VR_3DSelector_01_default_F";
vehicle_spawn_location = "Land_HelipadCivil_F";
vehicle_spawn_point = "VR_3DSelector_01_complete_F";

AL_Air = ["Air"] call AL_fnc_getSpawnerList;
AL_Armored = ["Armored"] call AL_fnc_getSpawnerList;
AL_Car = ["Car"] call AL_fnc_getSpawnerList;
AL_Ship = ["Ship"] call AL_fnc_getSpawnerList;

AL_Vehicles = [];
{
	{
		AL_Vehicles pushBack _x;
	} forEach _x;
} forEach [AL_Armored, AL_Car];

private _VRSelectors = allMissionObjects "VR_Helper_base_F";

// Filter all maps to find teleporters and call function to add teleport actions
{
	if (_x getVariable ["AL_Spawner", false]) then {
		[_x] call AL_fnc_spawnerInit;
	}
} forEach _VRSelectors;