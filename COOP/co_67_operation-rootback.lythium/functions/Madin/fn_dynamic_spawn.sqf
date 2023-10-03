params ["_grpArr", "_grpType", "_newGroup","_unitsCount","_posl","_cacheDist","_dist","_mindist"];
_newArr = _grpArr;
_side = side _newGroup;
_newdist = _dist + (_mindist / 10);
_unitsSpawn = _unitsCount select 2;
_fpsWatchdog = (_unitsCount select 0) * 1.5 + 15;
if (_fpsWatchdog > 50) then {_fpsWatchdog = 50};
while {_unitsSpawn > 0 && (count _grpArr) != 0} do
{
	_nearbyAi = {side _x == _side} count (_posl nearEntities ["AllVehicles", _cacheDist]);
	{
		_distance = _dist;
		_alliveUnits = {alive _x} count (units _newGroup);
		if (_unitsCount select 0 > _alliveUnits) then {_distance = _distance + _mindist};
		_nearplayers = (_x select 0) nearEntities ["allVehicles", _distance];
		_player = _nearplayers findIf {isPlayer _x};
		if (_player != -1)then
		{
			_building = _x select 2;
			_damage = damage _building;
			if ((count (nearestObjects [(_x select 0), ["man"], 1.5])) == 0 && {_damage <= 0.2} && {_unitsCount select 1 > _alliveUnits} && {_nearbyAi < 60})then
			{
				_tonearest = ((_nearplayers select _player) distance (_x select 0));
				[_x,_newGroup,(selectRandom _grpType),true,_dist] spawn M_fnc_spawn_ai;
				_limit = (_x select 3);
				_x set [3,_limit - 1];
				_newArr deleteAt _forEachIndex;
				_unitsSpawn = _unitsSpawn - 1;
				_newGroup setVariable ["lastSpawn", time];
			};
		};
	}forEach _grpArr;
	_grpArr = _newArr;
	_alliveUnits = {alive _x} count (units _newGroup);
	if (_unitsCount select 0 > _alliveUnits && {_nearbyAi < _fpsWatchdog} || _alliveUnits <= 3) then
	{
		{
			_pos = _x;
			_building = _pos select 2;
			_damage = damage _building;
			_newArr deleteAt _forEachIndex;
			if (_damage < 0.2)exitWith
			{
				_nears = (_pos select 0) nearEntities [["Man"], 1.5];
				if (count _nears == 0) then
				{
					[_pos,_newGroup,(selectRandom _grpType),true,_dist] spawn M_fnc_spawn_ai;
					_unitsSpawn = _unitsSpawn - 1;
					_limit = (_pos select 3);
					//systemChat str _limit;
					if (_limit > 1) then
					{
						_pos set [3,_limit - 1];
						_newArr pushBack _pos;
					};
				}else
				{
					_newArr pushBack _pos;
					(_nears select 0) enableAI "PATH";
				};
			};
		}forEach _grpArr;
		_grpArr = _newArr;
	};
	sleep 1;
	_time = (_newGroup getVariable ["lastSpawn", time]) + 360;
	if (_time < time)then
	{
		_newGroup setVariable ["lastSpawn", time];
		{
			_enemy = _x findNearestEnemy _x;
			if (!isNull _enemy)then
			{
				_x doMove (getPosATL _enemy);
				_x enableAI "PATH";
			};
		}forEach (units _newGroup);
	};
};