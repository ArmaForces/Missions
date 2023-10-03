params ["_spawnBuildings","_minDist","_type","_side","_tickets","_limit","_activation","_center","_patrolCount"];
_units = [];
_stationary = createGroup [_side, false];
_patrol = createGroup [_side, false];
//_stationary setVariable ["allowAi", false];
//_patrol setVariable ["allowAi", false];
_stationary setVariable ["hideDistance",1000];
_patrol setVariable ["hideDistance",1000];
while {!(_spawnBuildings isEqualTo []) && {_tickets > 0}} do
{
	private _newArr = +_spawnBuildings;
	{
		if (damage (_x  select 0) < 0.2) then
		{
			_nearplayers = (_x select 1) nearEntities ["allVehicles", _minDist];
			_player = _nearplayers findIf {isPlayer _x};
			if (_player != -1)then
			{
				_randpos = selectRandom (_x select 2);
				_pos = _randpos select 0;
				_dir = _randpos select 1;
				_list =_pos nearEntities ["Man", 0.5];
				if ((count _list) == 0) then
				{
					_unitArr = _type select 0;
					_unit1 = _unitArr select 0;
					_unit = [_patrol,_unit1,_pos,_dir] call M_fnc_spawnAI;
					_unit setUnitLoadout (_unitArr select 1);
					_type deleteAt 0;
					_type pushBack _unitArr;
					_tickets = _tickets - 1;
					_unit disableAI "PATH";
					[_unit] spawn {
						sleep random [10,30,45];
						(_this select 0) enableAI "PATH";
					};
				};
				_newArr deleteAt _forEachIndex;
			};
		}else
		{
			_newArr deleteAt _forEachIndex;
		};
	}forEach _spawnBuildings;
	_spawnBuildings = _newArr;

	if ((_tickets > 0) && {(({alive _x} count units _patrol) + ({alive _x} count units _stationary)) < _patrolCount}) then
	{
		_random = floor random (count _spawnBuildings);
		(_spawnBuildings select _random) params ["_building", "_buildingPos", "_buildingPositions", "_buildingSpawnLimit"];

		{
			_x params ["_pos", "_dir"];

			_list =_pos nearEntities ["Man", 0.5];
			if ((count _list) == 0) then
			{
				_unitArr = _type deleteAt 0;
				_unit1 = _unitArr select 0;
				_unit = [_patrol,_unit1,_pos,_dir] call M_fnc_spawnAI;
				_unit setUnitLoadout (_unitArr select 1);

				_type pushBack _unitArr;
				_tickets = _tickets - 1;
			};
		} forEach _buildingPositions;

		_limit = _buildingSpawnLimit - 1;
		if (_limit <= 0) then {_spawnBuildings deleteAt _random};
		[_patrol, _activation] spawn {
			params ["_group", "_activation"];

			sleep 3;
			{
				[_group] call M_fnc_aiAskHelp;
				if ((count (waypoints _group)) < 2) then
				{
					_nearPlayers = (getposATL (leader _group)) nearEntities ["AllVehicles", _activation];
					_find = _nearPlayers findIf {isPlayer _x};
					if (_find != -1) then {
						_group addWaypoint [position (_nearPlayers select _find), 0];
					};
				};
			} forEach units _group;
		};
	};
	//hintSilent format ["boty %1 / budynki %2 / tickety %3",(count allunits) - 1,count _spawnBuildings,_tickets];
	waitUntil {sleep 1;((_center nearEntities ["AllVehicles", _activation]) findIf {isPlayer _x}) != -1};
};