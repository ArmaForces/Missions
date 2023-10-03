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
				_groupEH reveal [_killer, 4];
				_time = (_groupEH getVariable ["lastSpawn", time]) + 180;
				if (_time > time)then
				{
					{
						[_x] call M_fnc_hunter_ai;
					}forEach (units _groupEH);
				}else
				{
					{
						[_x] call M_fnc_flank_ai;
					}forEach (units _groupEH);
				};
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