if (!hasInterface) exitWith {};

AL_Teleports = [
	[tp_driver_license, "Kurs prawa jazdy"],
	[tp_driver_license_end, "Kurs prawa jazdy (koniec)"],
	[tp_air_spawn_1, "Spawner lotniczy 1"],
	[tp_air_spawn_2, "Spawner lotniczy 2"],
	[tp_vehicle_spawn_1, "Spawner pojazdów 1"],
	[tp_vehicle_spawn_2, "Spawner pojazdów 2"],
	[tp_strzelnica, "Strzelnica"],
	[tp_szkolenie_medyczne, "Szkolenie medyczne"],
	[tp_terminal, "Terminal/Spawn"]
];

private _Maps = allMissionObjects "Land_MapBoard_F";

// Filter all maps to find teleporters and call function to add teleport actions
{
	[_x] call AL_fnc_teleporterAddDestination;
} forEach (_Maps select {_x getVariable ["AL_Teleporter", false]});