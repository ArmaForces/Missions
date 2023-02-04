
// LIST
airfield_list = [
["Main","airfield_main",["radar_airfield_main_1","radar_airfield_main_2","radar_airfield_main_3"]],
["North-West","airfield_nw",["radar_airfield_nw_1","radar_airfield_nw_2","radar_airfield_nw_3"]],
["North-East","airfield_ne",["radar_airfield_ne_1","radar_airfield_ne_2","radar_airfield_ne_3"]],
["South-East","airfield_se",["radar_airfield_se_1","radar_airfield_se_2","radar_airfield_se_3"]],
["South-West","airfield_sw",["radar_airfield_sw_1","radar_airfield_sw_2","radar_airfield_sw_3"]]
];

// SPAWN AIRFIELD RADARS
{
	airfield = _x select 0;
	_radar_positions = _x select 2;
	_airfield_radar = createVehicle ["rhs_prv13", getMarkerPos (_radar_positions select 0), _radar_positions, 0, "NONE"];
	_airfield_radar addEventHandler ["Killed", {[airfield] spawn "MDL_PvPJets_fnc_radar_killed";}];
} forEach airfield_list;