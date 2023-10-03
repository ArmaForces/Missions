_enemy = (_this select 0) findNearestEnemy (_this select 0);
if (!isNull _enemy)then
{
	_enemyPos = getPosATL _enemy;
	_AI = selectRandom [1,2,3];
	if (_AI == 1) then
	{
		_pos = [_enemyPos, 10, 30, 0.5, 0, 20, 0, [], [_enemyPos]] call bis_fnc_findSafePos;
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