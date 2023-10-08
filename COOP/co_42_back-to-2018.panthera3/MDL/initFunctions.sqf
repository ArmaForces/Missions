MDL_KCz_Points = 122;


MDL_KCz_fnc_changePointsBalance = compile preprocessFileLineNumbers "MDL\fnc\MDL_KCz_fnc_changePointsBalance.sqf";


// off: 0 = [0.95] spawn "fnc_blackout";
// on: 0 = [0] spawn "fnc_blackout";

fnc_blackout = {

params ["_onoff"];

_types = ["Lamps_Base_F", "PowerLines_base_F", "Land_PowerPoleWooden_F", "Land_LampHarbour_F", "Land_LampShabby_F", "Land_PowerPoleWooden_L_F", "Land_PowerPoleWooden_small_F", "Land_LampDecor_F", "Land_LampHalogen_F", "Land_LampSolar_F", "Land_LampStreet_small_F", "Land_LampStreet_F", "Land_LampAirport_F", "Land_PowerPoleWooden_L_F"];
_Markers = ["blackout_1","blackout_2","blackout_3","blackout_4","blackout_5","blackout_6"];

for [{_i=0},{_i < (count _types)},{_i=_i+1}] do
{
   // powercoverage is a marker I placed.
	{
		_lamps = getMarkerPos _x nearObjects [_types select _i, 500];
		sleep 1;
		{
			_x setDamage _onoff;
			sleep 0.05
		} forEach _lamps;
	} forEach _Markers;
};

};

MDL_fncs_initialized = true;