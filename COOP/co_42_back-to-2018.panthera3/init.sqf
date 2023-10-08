execVM "MDL\initFunctions.sqf";

execVM "ArmaForcesScripts.sqf";
execVM "spawn_core.sqf";
maxviewdistance = 10000;
defaultviewdistance = 2000;
// DYSTANS DO DOWOLNOEJ EDYCJI /\/\/\/\/\/\/\/\/\/\
AF_coop_side = west;
// wpisać stronę! Blufor = west / Opfor = east / Indfor = resistance / Cywile = civilian
if (isServer) then {
createMarker ["respawn_" + str AF_coop_side, position respawn_coop];
deletevehicle respawn_coop;
[AF_coop_side, -1000] call BIS_fnc_respawnTickets;
};
setViewDistance defaultviewdistance;
setObjectViewDistance defaultviewdistance * 0.7;
if (hasInterface) then {
waitUntil {player == player};
execVM "markersClient.sqf";
execVM "pain.sqf";
execVM "cache_local.sqf";
}else
{
	[] spawn
	{
		while {true}do
		{
			_localUnits = [];
			{
				if (local _x) then
				{
					_localUnits pushBack _x;
				}
			}forEach allUnits;
			for "_i" from 1 to 6 do
			{
				sleep 10;
				{
					[_x]spawn
					{
						sleep random 9.9;
						[(_this select 0)] call fnc_agressive_ai;
					};
				}forEach _localUnits;
			};
		};
	};
};
if (isServer) then
{
	[] spawn
	{
		while {true} do
		{
			{	
				if (!isPlayer leader _x && {_x getVariable ["MadinEnableAi", true]}) then
				{	
					_x setVariable ["MadinEnableAi", false];
					[_x]spawn
					{
						sleep 1;
						waitUntil {sleep 1; ((behaviour leader (_this select 0)) == "COMBAT" || (count units (_this select 0)) == 0)};
						if ((count units (_this select 0)) == 0)exitWith {systemChat "ERROR, USUNIĘCIE";};
						sleep 2;
						[(_this select 0)] remoteExecCall ["fnc_loop_ai", leader (_this select 0)];
						sleep 60;
						(_this select 0) setVariable ["MadinEnableAi", nil];
					};
				};
			}forEach allGroups;
			sleep 60;
		};
	};
};
if (hasInterface && isServer) then
{
	[] spawn
	{
		while {true}do
		{
			for "_i" from 1 to 6 do
			{
				sleep 10;
				{
					[_x]spawn
					{
						sleep random 9.5;
						[(_this select 0)] call fnc_agressive_ai;
					};
				}forEach (allUnits - allPlayers);
			};
		};
	};
};



/*

Funkcje

*/




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





fnc_data_transfer = {
	// Data transfer initialization
	uisleep 1;
	_time = 0;
	_target = 2;
	while {_time < _target} do {
	_text = format ["Establishing connection with microwave: %1%2", (_time/_target)*100, "%"];  
	_text remoteExec ["systemChat"];
	_time = _time + 1;
	uisleep 1;
	};
	_time = _target;
	_text = format ["Establishing connection with microwave: %1%2", (_time/_target)*100, "%"];  
	_text remoteExec ["systemChat"];
	uisleep 1;
	
	
	_time = 0;
	_target = 10;
	while {_time < _target} do {
	_text = format ["Connecting microwave to server: %1%2", (_time/_target)*100, "%"];  
	_text remoteExec ["systemChat"];
	_time = _time + random (1);
	uisleep 1;
	};
	_time = _target;
	_text = format ["Connecting microwave to server: %1%2", (_time/_target)*100, "%"];  
	_text remoteExec ["systemChat"];
	uisleep 1;
	
	
	_time = 0;
	_target = 25;
	while {_time < _target} do {
	_text = format ["Firewall extinguishing: %1%2", (_time/_target)*100, "%"];  
	_text remoteExec ["systemChat"];
	_time = _time + random (1);
	uisleep 1;
	};
	_time = _target;
	_text = format ["Firewall extinguishing: %1%2", (_time/_target)*100, "%"];  
	_text remoteExec ["systemChat"];
	uisleep 1;
	
	
	_time = 0;
	_target = 20;
	while {_time < 20} do {
	_text = format ["Treating virus infection: %1%2", (_time/_target)*100, "%"];  
	_text remoteExec ["systemChat"];
	_time = _time + random (1);
	uisleep 1;
	};
	_time = _target;
	_text = format ["Treating virus infection: %1%2", (_time/_target)*100, "%"];  
	_text remoteExec ["systemChat"];
	uisleep 1;
	
	
	_time = 0;
	_target = 8;
	while {_time < _target} do {
	_text = format ["Securing connection: %1%2", (_time/_target)*100, "%"];  
	_text remoteExec ["systemChat"];
	_time = _time + random (1);
	uisleep 1;
	};
	_time = _target;
	_text = format ["Securing connection: %1%2", (_time/_target)*100, "%"];  
	_text remoteExec ["systemChat"];
	uisleep 1;
	
	
	_time = 0;
	_target = 3;
	while {_time < _target} do {
	_text = format ["Starting upload: %1%2", (_time/_target)*100, "%"];  
	_text remoteExec ["systemChat"];
	_time = _time + random (1);
	uisleep 1;
	};
	_time = _target;
	_text = format ["Starting upload: %1%2", (_time/_target)*100, "%"];  
	_text remoteExec ["systemChat"];
	uisleep 1;
	
	
	_time = 0;
	_time2 = 0;
	_net = 0;
	_hddread = false;
	while {_time < 100 && alive microwave && microwave in list server_room && alive server_1 && alive server_2 && alive laptop} do {
		_datacheck = false;
		_timef = floor (_time *10);
		_timet = _timef / 10;
		while {floor(_time/10) >= _time2} do {
			_hddread = true;
			_time2 = _time2 + 0.1 + (random (1))/10;
			_net = 0;
			_timef = floor (_time *10);
			_timet = _timef / 10;
			_net = (floor (random [10000, 50000, 100000]))/ 100;
			_text = format ["Data validiation progress: %1%2, Drive usage: %3 GB/s", _timet, "%", _net];  
			_text remoteExec ["systemChat"];
			_time = _time + (random (1));
			uisleep 1;
		};
		if (!_hddread) then {
			_text = format ["Data validiation progress: %1%2, Network usage: %3 Mb/s", _timet, "%", _net];  
			_text remoteExec ["systemChat"];
			_net = (floor (random [0, 1250, 1500]))/ 100;
			_time = _time + (_net / 21.37);
			uisleep 1;
		} else {
			_hddread = false;
		};
	};
	if (alive microwave) then {
		"Data validiation progress: 100%" remoteExec ["systemChat"];
		data_downloaded = true; 
		publicVariable "data_downloaded";
	} else {
		"Connection terminated. Remote host not responding." remoteExec ["systemChat"];
	};
};