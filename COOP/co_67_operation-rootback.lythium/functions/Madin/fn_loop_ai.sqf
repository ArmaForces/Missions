private _group = _this select 0;
private _leader = leader _group;
if ((behaviour _leader) == "AWARE")exitWith {[_group] call M_fnc_aiAskHelp};
if (_group getVariable ["defend",false]) exitWith {[_leader] call M_fnc_aihide};
_danger = _leader findNearestEnemy _leader;
_units = units _group;
//systemChat str (behaviour _leader);
if (!(_group getVariable ["AF_canDeleteWaypoint",true]) && {(count (waypoints _group)) < 1}) then
{
	(_group setVariable ["AF_canDeleteWaypoint",nil]);
};
if (!isNull _danger && (_group getVariable ["AF_canDeleteWaypoint",true]))then
{
	if ((_group getVariable ["alerted",time]) < (time + 180))then
	{
		_list = _leader nearEntities ["Man", 200];
		_groups = [];
		{
			_groups pushBackUnique (group _x);
		}forEach _list;
		_side = side _leader;
		{
			if ((side _x) == _side) then
			{
				_x reveal [_danger, 4];
				_x setVariable ["alerted",time,true];
			};
		}forEach _groups;
	};
	_distance = _leader distance _danger;
	_halfDistance = _distance / 2;
	if ((vehicle _leader) == _leader) then
	{
		if ((vehicle _danger) isKindOf "tank")exitWith
		{
			[_leader] call M_fnc_aihide;
		};
		while {(count (waypoints _group)) > 0} do
		{
			deleteWaypoint ((waypoints _group) select 0);
		};
		//szukanie pojazdów / dział do obsadzenia
		_list = _leader nearEntities ["LandVehicle", 100];
		{
			private _allow = _x getVariable ["timetaken",[0,objNull]];
			//systemChat str _allow;
			if (!((allTurrets _x) isEqualTo []) && {((crew _x) findIf {alive _x}) == -1} && {(((_allow select 0) +90) < time)})exitWith
			{
				_ang = _x getRelDir _danger;
				if ((_ang <= 70) || (_ang >= 290)) then
				{
					_allunits = units _group;
					_alive = _units findIf {(!(isFormationLeader _x) && alive _x)};
					if (_alive != -1)then
					{
						_x setVariable ["timetaken",[time,_unit]];
						_unit = (_units select _alive);
						[_unit] joinSilent grpNull;
						(group _unit) setVariable ["MadinEnableAi", false];
						_wp = (group _unit) addWaypoint [position _x, 0];
						_wp waypointAttachVehicle _x;
						_wp setWaypointType "GETIN";
						[_unit] allowGetIn true;
						_unit assignAsGunner _x;
						[_unit] orderGetIn true;
						_unit addEventHandler ["GetInMan", {
							params ["_unit", "_role", "_vehicle", "_turret"];
							_unit assignAsGunner _vehicle;
						}];
					};
				};
			};
		}forEach _list;
		if (_distance < _group getVariable ["hideDistance",AF_Hide_distance]) then
		{
			_group addWaypoint [position _danger, 10];
			_enemy = _leader findNearestEnemy _leader;
			if (!isNull _enemy)then
			{
				_enemyPos = getPosATL _enemy;
				_buildingsPos = [];
				_buildings = (nearestObjects [_enemyPos, ["House", "Building"], 30]);
				{
					_allpositions = _x buildingPos -1;
					{
						_buildingsPos pushBack _x;
					}forEach _allpositions;
				}forEach _buildings;
				_posCount = count _buildingsPos;
				{
					if (_posCount > _forEachIndex) then
					{
						_pos = (_buildingsPos select _forEachIndex);
						_x doMove _pos;
						/*
						[_pos] spawn
						{
							private _pos = _this select 0;
							private _3dMarker = "VR_3DSelector_01_default_F" createVehicleLocal _pos;
							private _marker = createMarkerLocal [str _pos, _pos];
							_marker setMarkerColorLocal "ColorBlue";
							sleep 15;
							deleteVehicle _3dMarker;
							deleteVehicle _Marker;
						};
						*/
					}else
					{
						_pos = [_enemyPos, _halfDistance, _distance, 0.5, 0, 20, 0, [], [_enemyPos]] call bis_fnc_findSafePos;
						_x doMove _pos;
						/*
						[_pos] spawn
						{
							private _pos = _this select 0;
							private _3dMarker = "VR_3DSelector_01_incomplete_F" createVehicleLocal _pos;
							private _marker = createMarkerLocal [str _pos, _pos];
							_marker setMarkerColorLocal "ColorOrange";
							sleep 15;
							deleteVehicle _3dMarker;
							deleteVehicle _Marker;
						};
						*/
					};
				}forEach _units;
			}
		}else
		{
			[_leader] call M_fnc_aihide;
		};
	}else
	{
		if (random 1 < 0.75) then
		{
			_veh = vehicle _leader;
			_type = typeOf _veh;
			if ((vehicle _danger) isKindOf "tank" && {!(_veh isKindOf "tank")})then
			{
				_danger = _unit;
			};
			_pos = getposATL _danger findEmptyPosition [20,150,_type];
			if ((count _pos) != 0) then
			{
				_veh engineOn true;
				while {(count (waypoints _group)) > 0} do
				{
					deleteWaypoint ((waypoints _group) select 0);
				};
				_group addWaypoint [_pos, 0];
			};
			if ((_unit getVariable ["fireEH",-1]) != -1) then
			{
				_id = _veh addEventHandler ["fired", {
				params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
				_unit removeEventHandler ["fired", _unit getVariable ["fireEH",0]];
				_unit setVariable ["fireEH",nil];
				_enemy = ((crew _unit) select 0) findNearestEnemy ((crew _unit) select 0);
				if (!isNull _enemy)then
				{
					[_unit,_enemy] spawn
					{
						params ["_unit", "_enemy"];
						//sleep (random 1) + 1;
						//_unit doWatch _enemy;
						sleep random 1;
						_unit fire ((weapons _unit) select 0);
						_unit doWatch objNull;
					};
				};
				}];
				_veh setVariable ["fireEH",_id];
			};
		};
	};
}else
{
	if ((vehicle _leader) == _leader) then
	{
	[_leader] call M_fnc_aihide;
	};
};