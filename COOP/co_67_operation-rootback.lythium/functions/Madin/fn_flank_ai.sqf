if ((_this select 0) getVariable ["flankAi", true])then
{
	_enemy = (_this select 0) findNearestEnemy (_this select 0);
	if (!isNull _enemy)then
	{
		(_this select 0) setVariable ["flankAi", false];
		_enemyPos = getPosATL _enemy;
		_pos = [_enemyPos, 10, 30, 0.5, 0, 20, 0, [], [_enemyPos]] call bis_fnc_findSafePos;
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
				sleep 180;
				[(_this select 0)] call call M_fnc_hunter_ai;
			};
		};
	};
};