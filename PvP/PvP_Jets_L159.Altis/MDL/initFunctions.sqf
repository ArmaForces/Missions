MDL_fncsInitialized = false;
execVM "MDL\config.sqf";

//MDL_fnc_VehicleEH = compile preprocessFileLineNumbers "MDL\fnc\MDL_fnc_VehicleEH.sqf";
MDL_PvPJets_fnc_planeRespawn = compile preprocessFileLineNumbers "MDL\fnc\MDL_PvPJets_fnc_planeRespawn.sqf";
//MDL_PvPJets_fnc_planeGetLoadoutByName = compile preprocessFileLineNumbers "MDL\fnc\MDL_PvPJets_fnc_planeGetLoadoutByName.sqf";
MDL_PvPJets_fnc_planeChangeLoadout = compile preprocessFileLineNumbers "MDL\fnc\MDL_PvPJets_fnc_planeChangeLoadout.sqf";
//MDL_PvPJets_fnc_radar_killed = compile preprocessFileLineNumbers "MDL\fnc\MDL_PvPJets_fnc_radar_killed.sqf";
//MDL_PvPJets_fnc_spawn_airfields = compile preprocessFileLineNumbers "MDL\fnc\MDL_PvPJets_fnc_spawn_airfields.sqf";
//MDL_PvPJets_fnc_spawnerAddPlanes = compile preprocessFileLineNumbers "MDL\fnc\MDL_PvPJets_fnc_spawnerAddPlanes.sqf";

MDL_fncsInitialized = true;