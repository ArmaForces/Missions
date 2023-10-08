fnc_spawn_ai = {
_unit = (_this select 1) createUnit [(_this select 2), [0,0,0], [], 0, "CAN_COLLIDE"];
_unit allowDamage false;
_unit setDir ((_this select 0) select 1);
[_unit,"AmovPsitMstpSrasWrflDnon_AmovPercMstpSlowWrflDnon"] remoteExec ["SyncSwitchMove", 0];
[_unit,((_this select 0) select 0)] spawn {
sleep 0.1;
(_this select 0) setUnitPos "UP";
(_this select 0) setPosATL (_this select 1);
(_this select 0) allowDamage true;
};
_unit disableAI "PATH";
[_unit] spawn fnc_spawn_eh;
_unit setVariable ["acex_headless_blacklist", true];
_unit setSkill ["aimingAccuracy",(0.05 + (random 0.05))];
_unit setSkill ["aimingShake",(0.05 + (random 0.05))];
_unit setSkill ["spotDistance",(0.75 + (random 0.15))];
_unit setSkill ["spotTime",(0.6 + (random 0.1))];
_unit setSkill ["courage",(0.7 + (random 0.3))];
_unit setSkill ["commanding",1.0];
_unit setSkill ["aimingSpeed",(0.6 + (random 0.15))];
_unit setSkill ["general",1.0];
_unit setSkill ["endurance",1.0];
_unit setSkill ["reloadSpeed",(0.7 + (random 0.3))];
_unit allowFleeing 0;
[_unit]spawn
{
	sleep 5;
	if(({isPlayer _x} count ((_this select 0) nearEntities ["allVehicles", 30])) == 0)then
	{
		_time = ((group (_this select 0)) getVariable ["lastSpawn", time]) + 120;
		if (_time > time)then
		{
			{
				[_x] call fnc_hunter_ai;
			}forEach (units group (_this select 0));
		}else
		{
			{
				[_x] call fnc_flank_ai;
			}forEach (units group (_this select 0));
		};
	};
};
{[_x,[[_unit],true]] remoteExec ["addCuratorEditableObjects", 0];}forEach allCurators;
};
fnc_agressive_ai = {
	_enemy = (_this select 0) findNearestEnemy (_this select 0);
	if (!isNull _enemy && {!(vehicle _enemy isKindOf "Air")} && {!(vehicle _enemy isKindOf "Ship")})then
	{
		_AA = ["rhs_weap_fim92","rhs_weap_igla","rhs_weap_fgm148","launch_NLAW_F"];
		_distance = (_this select 0) distance _enemy;
		if ((random 1) < 0.2 && {(secondaryWeapon (_this select 0)) != ""} && {!((secondaryWeapon (_this select 0)) in _AA)} && {((secondaryWeaponMagazine (_this select 0))select 0) != ""} && {_distance > 30} && {_distance < 400})exitWith
		{
			_nearVeh = nearestObjects [_enemy, ["AllVehicles","Static"], 10];
			{
				_vehFire = _x;
				if (!(_vehFire isKindOf "Man") && {([(_this select 0), "VIEW", _vehFire] checkVisibility [eyePos (_this select 0), (getPosASL _vehFire) vectorAdd [0,0,1.5]]) > 0.1})exitWith
				{
					if (count crew _vehFire != 0)exitWith
					{
						if ((side (crew _vehFire select 0)) != (side (_this select 0)))exitWith
						{
							(_this select 0) lookAt _vehFire;
							(_this select 0) doWatch _vehFire;
							(_this select 0) forceWeaponFire [secondaryWeapon (_this select 0),secondaryWeapon (_this select 0)];
							(_this select 0) doFire _vehFire;
							(_this select 0) fire (secondaryWeapon (_this select 0));
							[(_this select 0),_vehFire] spawn
							{
								sleep 1;
								(_this select 0) fire (secondaryWeapon (_this select 0));
							};
						};
					};
					(_this select 0) lookAt _vehFire;
					(_this select 0) doWatch _vehFire;
					(_this select 0) forceWeaponFire [secondaryWeapon (_this select 0),secondaryWeapon (_this select 0)];
					(_this select 0) doFire _vehFire;
					(_this select 0) fire (secondaryWeapon (_this select 0));
					[(_this select 0),_vehFire] spawn
					{
						sleep 1;
						(_this select 0) fire (secondaryWeapon (_this select 0));
					};
				};
			}forEach _nearVeh;
		};
		if (_distance < 50 && {_distance > 5})exitWith
		{
			_visiblity = [(_this select 0), "VIEW"] checkVisibility [eyePos (_this select 0), eyePos _enemy];
			if (_visiblity > 0.5) then 
			{
				_nearFriendly = (_enemy nearEntities [["Man"], 4]);
				if (((side (_this select 0)) countSide _nearFriendly) == 0) then
				{
					doStop (_this select 0);
					(_this select 0) lookAt _enemy;
					(_this select 0) doWatch _enemy;
					(_this select 0) forceWeaponFire ["HandGrenadeMuzzle","HandGrenadeMuzzle"];
					(_this select 0) forceWeaponFire ["MiniGrenadeMuzzle","MiniGrenadeMuzzle"];
					(_this select 0) forceWeaponFire ["Rhsusf_Throw_Grenade","Rhsusf_Throw_Grenade"];
					(_this select 0) forceWeaponFire ["Rhs_Throw_Grenade","Rhs_Throw_Grenade"];
					(_this select 0) forceWeaponFire ["Rhs_Throw_RgnGrenade","Rhs_Throw_RgnGrenade"];
					(_this select 0) forceWeaponFire ["rhsgref_Throw_Grenade","rhsgref_Throw_Grenade"];
				}
			};
		};
	};
};
fnc_loop_ai = {
	_leader = leader (_this select 0);
	_danger = _leader findNearestEnemy _leader;
	if (!isNull _danger)then
	{
		_distance = _leader distance _danger;
		if (_distance < 150) then
		{
			_group = (units (_this select 0));
			while {(count (waypoints (_this select 0))) > 0} do
			{
				deleteWaypoint ((waypoints (_this select 0)) select 0);
			};
			(_this select 0) addWaypoint [position _danger, 10];
			_enemy = _x findNearestEnemy _x;
			if (!isNull _enemy)then
			{
				_enemyPos = getPosATL _enemy;
				_AI = selectRandom [1,2,3];
				if (_AI == 1) then
				{
					_pos = [_enemyPos, 1, 40, 0.5, 0, 20, 0, [], [_enemyPos]] call BIS_fnc_findSafePos;
					_x doMove _pos;
				};
				if (_AI == 2) then
				{
					_x doMove _enemyPos;
					_x setSpeedMode "FULL";
				};
				if (_AI == 3) then
				{
					_buildings = (nearestObjects [_enemyPos, ["House", "Building"], 20]);
					if ((count _buildings) > 0) then
					{
						_building = (selectRandom _buildings);
						_allpositions = _building buildingPos -1;
						if ((count _allpositions) > 0) then
						{
							_pos = selectRandom _allpositions;
							_x doMove _pos;
							_x setSpeedMode "FULL";
						};
					};
				};
			}forEach _group;
		};
	};
};
fnc_hunter_ai = {
	_enemy = (_this select 0) findNearestEnemy (_this select 0);
	if (!isNull _enemy)then
	{
		_enemyPos = getPosATL _enemy;
		_AI = selectRandom [1,2,3];
		if (_AI == 1) then
		{
			_pos = [_enemyPos, 10, 30, 0.5, 0, 20, 0, [], [_enemyPos]] call BIS_fnc_findSafePos;
			(_this select 0) enableAI "PATH";
			(_this select 0) doMove _pos;
		};
		if (_AI == 2) then
		{
			(_this select 0) doMove _enemyPos;
			(_this select 0) enableAI "PATH";
			(_this select 0) setSpeedMode "FULL";
		};
		if (_AI == 3) then
		{
			_buildings = (nearestObjects [_enemyPos, ["House", "Building"], 20]);
			if ((count _buildings) > 0) then
			{
				_building = (selectRandom _buildings);
				_allpositions = _building buildingPos -1;
				if ((count _allpositions) > 0) then
				{
					_pos = selectRandom _allpositions;
					(_this select 0) enableAI "PATH";
					(_this select 0) doMove _pos;
					(_this select 0) setSpeedMode "FULL";
				};
			};
		};
	};
};
fnc_flank_ai = {
	if ((_this select 0) getVariable ["flankAi", true])then
	{
		_enemy = (_this select 0) findNearestEnemy (_this select 0);
		if (!isNull _enemy)then
		{
			(_this select 0) setVariable ["flankAi", false];
			_enemyPos = getPosATL _enemy;
			_pos = [_enemyPos, 10, 30, 0.5, 0, 20, 0, [], [_enemyPos]] call BIS_fnc_findSafePos;
			(_this select 0) enableAI "PATH";
			(_this select 0) doMove _pos;
			[(_this select 0),_pos]spawn
			{
				_time = time + 120;
				waitUntil {sleep 1; !alive (_this select 0) || time > _time || ((_this select 1) distance (_this select 0)) < 1};
				if (((_this select 1) distance (_this select 0)) < 1)then
				{
					doStop (_this select 0);
					(_this select 0) setVariable ["flankAi", nil];
				};
			};
		};
	};
};
fnc_spawn_eh =
{
	_unit = _this select 0;
	_unit addEventHandler ["Killed",
	{
		_groupEH = group (_this select 0);
		if (_groupEH getVariable ["allowAi", true])then
		{
			_killer = (_this select 0) getVariable ["ace_medical_lastDamageSource", objNull];
			{
				if (_killer == _x && {(_x distance (_this select 0)) <= 50}) exitWith
				{
					_aliveArr = [];
					{
						if (_x getVariable ["ACE_isUnconscious", false] && {!alive _x})then
						{
							_dist = _x distance _killer;
							_aliveArr pushBack [_dist, _x];
						};
					}forEach units _groupEH;
					_aliveArr sort true;
					if (count _aliveArr > 0) then
					{
						_groupEH selectLeader ((_aliveArr select 0) select 1);
					};
					_groupEH setVariable ["allowAi", false];
					_groupEH reveal [_killer, 1];
					_time = (_groupEH getVariable ["lastSpawn", time]) + 180;
					if (_time > time)then
					{
						{
							[_x] call fnc_hunter_ai;
						}forEach (units _groupEH);
					}else
					{
						{
							[_x] call fnc_flank_ai;
						}forEach (units _groupEH);
					};
					(_this select 0) reveal _killer;
					if ((count (waypoints (_this select 0))) == 0) then
					{
						(_this select 0) addWaypoint [position _killer, 0];
					};
					[_groupEH]spawn
					{
						sleep random [60,120,180];
						(_this select 0) setVariable ["allowAi", nil];
					};
				};
			}forEach allPlayers;
		};
	}];
	_unit addEventHandler ["Hit",
	{
		(_this select 0) setUnitPos "AUTO";
	}];
};
fnc_dynamic_spawn =
{
	params ["_grpArr", "_grpType", "_newGroup","_unitsCount","_posl","_cacheDist"];
	_cacheDist = _cacheDist + 300;
	_newArr = _grpArr;
	_side = side _newGroup;
	_unitsSpawn = _unitsCount select 2;
	_fpsWatchdog = (_unitsCount select 0) * 1.2 + 1;
	if (_fpsWatchdog > 20) then {_fpsWatchdog = 20};
	while {_unitsSpawn > 0 && (count _grpArr) > 5} do
	{	
		_nearbyAi = {side _x == _side} count (_posl nearEntities ["AllVehicles", _cacheDist]);
		{
			_w = _forEachIndex;
			if (({isPlayer _x} count ((_x select 0) nearEntities ["allVehicles", 30])) != 0)then
			{
				_building = damage (nearestObjects [(_x select 0), ["House", "Building"], 20] select 0);
				if (_building > 0.25 || _unitsCount select 1 <={alive _x} count (units _newGroup) || (count (nearestObjects [(_x select 0), ["man"], 2])) != 0 || _nearbyAi >= 35)then
				{
					_newArr deleteAt _w;
				}else
				{
					[_x,_newGroup,(selectRandom _grpType)] call fnc_spawn_ai;
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
			_freeSpot = true;
			while {_freeSpot && (count _grpArr) > 5} do
			{
				_randomPos = selectRandom _grpArr;
				_building = damage (nearestObjects [(_randomPos select 0), ["House", "Building"], 20] select 0);
				if (_building < 0.25)exitWith
				{
					[_randomPos,_newGroup,(selectRandom _grpType)] call fnc_spawn_ai;
					_unitsSpawn = _unitsSpawn - 1;
					_freeSpot = false;
				};
				_grpArr deleteAt (_grpArr find _randomPos);
			};
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
};