/*
TO WKLEIĆ DO SAMEGO POJAZDU!

do poprawnego działania wymagany Headless Client, JEDEN!
// ==========

if (!hasInterface && !isServer || hasInterface && isServer) then {[this, "marker_0", "warunek",0,1,120,0,200,2]execVM "M_scripts\vehSpawn.sqf"}else
{if (isServer) then {this lock true;{_x disableAI "PATH";}forEach crew this}};

// ==========
marker_0 = marker na który przyjedzie wsparcie
warunek = warunkek który musi zwrócić true, by wsparcie przyjechało
0 = ilość sekund, po których ma pojawić się pojazd
1 = ile razy pojazd ma się pojawić
120 = w jakich odstępach. UWAGA! jeśli więcej niż 1 pojazd, czas musi być wystarczający. Inaczej pojazdy będą pojawiały się na sobie = BOOM
0 = odległość markera, do której wsparcie przyjedzie jeśli w tej odległości znajduje się wróg. dla 0 pojazd zawsze przyjedzie na marker
200 = odległość, na której zatrzyma się pojazd przed celem by wyrzucić piechotę
nie wiesz czy i jak edytować? TO NIE DOTYKAJ! SKOPIUJ JAK JEST.
*/
params ["_vehicle", "_marker","_trigger","_sleep","_count","_interval","_radius",["_dist",100],["_minimal",100]];
_vehType = typeOf _vehicle;
_Vehiclepos = getPos _vehicle;
_vehicleDir = getDir _vehicle;
_fullCrew = fullCrew _vehicle;
_side = side ((_fullCrew select 0) select 0);
{
	_x pushBack (getUnitLoadout (_x select 0));
	_type = typeOf (_x select 0);
	_x set [0, _type];
}forEach _fullCrew;
_vehCustom = ([_vehicle] call BIS_fnc_getVehicleCustomization) select 0;
{_grDel = group _x; deleteVehicle _x; deleteGroup _grDel;}forEach (crew _vehicle);
deleteVehicle _vehicle;
_markerPos = getMarkerPos _marker;
waitUntil {sleep 1;missionNamespace getVariable [_trigger, false]};
sleep _sleep;
for "_i" from 1 to (_count) do {
	_aidebug = true;
	while {_aidebug} do
	{
		_veh = createVehicle [_vehType, _Vehiclepos, [], 0, "NONE"];
		[_veh, _vehCustom] call BIS_fnc_initVehicle;
		_veh setDir _vehicleDir;
		_veh lock true;
		_GroupVeh = createGroup [_side, false];
		_GroupCargo = createGroup [_side, false];
		_GroupVeh setVariable ["MadinEnableAi", false, true];
		{
			if (_x select 1 != "cargo" && _x select 1 != "Turret") then
			{
				_unit = _GroupVeh createUnit [_x select 0, _Vehiclepos, [], 5, "NONE"];
				_unit setUnitLoadout (_x select 5);
				_unit setVariable ["acex_headless_blacklist", true];
				[_unit] call AF_fnc_AI_Init;
				_ideh = _unit addEventHandler ["killed",{
					(units group (_this select 0)) allowGetIn false;
					{_x removeEventHandler ["killed", (group (_this select 0)) getVariable ['killedEh',0]]}forEach (units group (_this select 0));
					(group (_this select 0)) setVariable ["killedEh",nil];
				}];
				_GroupVeh setVariable ["killedEh",_ideh];
				if (_x select 1 == "driver")exitWith
					{
						_unit moveInDriver _veh;
						_unit assignAsDriver _veh;
					};
				if (_x select 1 == "commander")exitWith
					{
						_unit moveInCommander _veh;
						_unit assignAsCommander _veh;
					};
				if (_x select 1 == "gunner")exitWith
					{
						_unit moveInGunner _veh;
						_unit assignAsGunner _veh;
					};
				_unit moveInCargo _veh;
				{[_x,[[_unit],true]] remoteExec ["addCuratorEditableObjects", 0];}forEach allCurators;
			}else
			{
				_unit = _GroupCargo createUnit [_x select 0, _Vehiclepos, [], 5, "NONE"];
				_unit setUnitLoadout (_x select 5);
				_unit setVariable ["acex_headless_blacklist", true];
				[_unit] call AF_fnc_AI_Init;
				if (_x select 1 == "Turret")then
				{
					_unit moveInTurret [_veh, _x select 3];
					_unit assignAsTurret [_veh, _x select 3];
				}else
				{
					_unit moveInCargo _veh;
				};
				_ideh = _unit addEventHandler ["killed",{
					(units group (_this select 0)) allowGetIn false;
					{_x removeEventHandler ["killed", (group (_this select 0)) getVariable ['killedEh',0]]}forEach (units group (_this select 0));
					(group (_this select 0)) setVariable ["killedEh",nil];
				}];
				_GroupCargo setVariable ["killedEh",_ideh];
				{[_x,[[_unit],true]] remoteExec ["addCuratorEditableObjects", 0];}forEach allCurators;
			};
		}forEach _fullCrew;
		{[_x,[[_veh],true]] remoteExec ["addCuratorEditableObjects", 0];}forEach allCurators;
		sleep 2;
		{
			if (vehicle _x == _x) then {deleteVehicle _x};
		}forEach (units _GroupCargo);
		_destination = _markerPos;
		if (_radius > 0) then
		{
			_nearplayers = _markerPos nearEntities ["allVehicles", _radius];
			_players = [];
			{
				if (isPlayer _x) then
				{
					_players pushBack _x;
				};
			}forEach _nearplayers;
			if ((count _players) != 0)then
			{
				_destination = getPosATL (selectRandom _players);
			};
		};
		_veh engineOn true;
		_waypointdriver = _GroupVeh addWaypoint [_destination, 0];
		_waypointdriver setWaypointCompletionRadius 50;
		_waypointCargo = _GroupCargo addWaypoint [_destination, 25];
		_waypointCargo setWaypointCompletionRadius 50;
		_GroupCargo setVariable ["AF_canDeleteWaypoint",false];
		sleep 30;
		_failstart = (_Vehiclepos distance _veh);
		if (_failstart > 50)exitWith
		{
			if ((count units _GroupCargo) != 0) then
			{
				[_destination,_waypointdriver,_veh,_GroupVeh,_GroupCargo,_dist]spawn
				{
					params ["_destination","_waypointdriver", "_veh","_GroupVeh","_GroupCargo","_dist"];
					sleep 10;
					_suspend = true;
					_wait = time + ((_destination distance _veh) / 5);
					while {_suspend} do
					{
						sleep 1;
						if (!alive _veh || (_destination distance _veh) < (_dist + random 25) || time > _wait) exitWith {};
						_leader = (leader _GroupVeh);
						_enemy = _leader findNearestEnemy _leader;
						if (!isNull _enemy) then
						{
							_distance = _leader distance _enemy;
							if (_distance < 200) then
							{
								_enemyPos = getposATL _enemy;
								_suspend = false;
								(units _GroupCargo) allowGetIn false;
								{
									_pos = [_enemyPos, 30, 200, 0.5, 0, 20, 0, [], [getposATL _x]] call BIS_fnc_findSafePos;
									_x doMove _pos;
								}forEach units _GroupCargo;
							};
						}else
						{
							if (((speed _veh) < 1) && (_leader distance _destination) < 300 || (count crew _veh) == 0)then
							{
								_suspend = false;
							};
						};
					};
					_veh forceSpeed 0;
					waitUntil {sleep 1; (speed _veh) < 1 || ({alive _x} count (units _GroupVeh)) == 0};
					_waypointdriver setWaypointPosition [getPos _veh, 0];
					_waypointdriver setWaypointType "TR UNLOAD";
					(units _GroupCargo) allowGetIn false;
					sleep 5;
					_waypointGroup = _GroupCargo addWaypoint [_destination, 25];
					_waypointGroup setWaypointCompletionRadius 5;
					[_GroupVeh,_GroupCargo] call M_fnc_aiAskHelp;
					sleep 5;
					_veh forceSpeed -1;
					{
						_lead = (leader _x);
						_danger = _lead findNearestEnemy _lead;
						if (!isNull _danger)then
						{
							if (isNull objectParent _lead) then
							{
								_waypoint = _x addWaypoint [getposATL _danger, 10];
							}else
							{
								while {(count (waypoints _x)) > 0} do
								{
									deleteWaypoint ((waypoints _x) select 0);
								};
								_empty = (getposATL _danger) findEmptyPosition [0,30,typeOf (vehicle _lead)];
								_waypoint = _x addWaypoint [_empty, 0];
								_waypoint setWaypointCompletionRadius 25;
							};
						}
					}forEach [_GroupVeh,_GroupCargo];
					_GroupVeh setVariable ["MadinEnableAi", nil, true];
					[_GroupVeh] remoteExecCall ["M_fnc_loop_ai", leader _GroupVeh];
					if ((count units _GroupVeh) == 1)then
					{
						(units _GroupVeh) joinSilent _GroupCargo;
						(units _GroupCargo) allowGetIn false;
					};
					[_GroupCargo,(_dist / 4) + 50,_destination]spawn
					{
						params ["_GroupCargo","_dist","_destination"];
						_leader = leader _GroupCargo;
						waitUntil {sleep 10; !alive _leader || (_leader distance _destination) < _dist};
						_GroupCargo setVariable ["AF_canDeleteWaypoint",nil];
					};
					[_GroupCargo,_veh]spawn
					{
						sleep 10;
						(_this select 1) lock false;
						waitUntil {sleep 10; (count units (_this select 0)) == 0};
						deleteGroup (_this select 0);
					};
				};
				sleep _interval;
				_units = units _groupCargo;
				waitUntil {sleep 5; _minimal > {alive _x} count _units};
			}else
			{
				deleteGroup _GroupCargo;
				_GroupVeh setVariable ["MadinEnableAi", nil, true];
				_veh lock false;
				sleep _interval;
				_units = crew _veh;
				waitUntil {sleep 5; _minimal > {alive _x} count _units};
			};
			[_GroupVeh]spawn
			{
				sleep 10;
				waitUntil {sleep 10; (count units (_this select 0)) == 0};
				deleteGroup (_this select 0);
			};
		};
		{deleteVehicle _x}forEach units _GroupVeh;
		{deleteVehicle _x}forEach units _GroupCargo;
		{deleteGroup _x}forEach [_GroupVeh,_GroupCargo];
		deleteVehicle _veh;
		sleep 1;
	};
};