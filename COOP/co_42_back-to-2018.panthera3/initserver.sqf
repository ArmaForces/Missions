[] spawn {
	while {true}do
	{
		sleep 3;
		_deadArr = [];
		{
			if (!(_x getVariable ["GCblackList", false]))then
			{
				_deadArr pushBack _x;
			};
		}forEach (allDeadMen - allPlayers);
		_countdead = count _deadArr;
		if (_countdead > 10) then
		{
			{
				_GCdist = 25 - _countdead;
				if (_GCdist < 2 || (_x getVariable ["GCmaxTime", false])) then {_GCdist = 2};
				if (({isPlayer _x} count (_x nearEntities ["allVehicles", _GCdist])) == 0)then
				{
					_countdead = _countdead - 1;
					_x setVariable ["GCblackList", nil];
					{deleteVehicle _x}forEach (_x getVariable ["GC",[]]);
					[_x] remoteExec ["hideBody",_x];
					[_x] spawn
					{
						sleep 5;
						deleteVehicle (_this select 0);
					};
				};
				sleep 0.1;
			}forEach _deadArr;
		};
	};
};
faggots = [];
addMissionEventHandler ["EntityKilled",
{
	if (!isPlayer(_this select 0) && {(_this select 0) isKindOf "man"}) then
	{
		if (!((_this select 0)getVariable ["GCblackList", false])) then
		{
			(_this select 0) setVariable ["GCblackList", true];
			[(_this select 0)] spawn
			{
				sleep 1;
				_GC = nearestObjects [(_this select 0), ["WeaponHolder", "WeaponHolderSimulated", "GroundWeaponHolder"], 2];
				(_this select 0) setVariable ["GC",_GC];
				_near = nearestObjects [(_this select 0), ["Man"], 5];
				if (({!alive _x} count _near) > 3)then
				{
					{
						if (!alive _x)exitWith
						{
							sleep 3;
							_x setVariable ["GCmaxTime", true];
						};
					}forEach _near;
				};
				sleep 30;
				(_this select 0) setVariable ["GCblackList", false];
				sleep 180;
				(_this select 0) setVariable ["GCmaxTime", true];
			};
		};
	};
	if (!((_this select 0) isKindOf "man") && {(_this select 0) isKindOf "AllVehicles"}) then
	{
		[(_this select 0)] spawn
		{
			sleep 0.5;
			_garbagecollector = nearestObjects [(_this select 0), ["man"], 10];
			{if (!alive _x) then {deleteVehicle _x};} forEach _garbagecollector;
			sleep 2;
			_garbagecollector = nearestObjects [(_this select 0), ["man"], 10];
			{if (!alive _x) then {deleteVehicle _x};} forEach _garbagecollector;
		};
	};
}];
{
	_x setSkill ["aimingAccuracy",(0.05 + (random 0.05))];
	_x setSkill ["aimingShake",(0.05 + (random 0.05))];
	_x setSkill ["spotDistance",(0.75 + (random 0.15))];
	_x setSkill ["spotTime",(0.6 + (random 0.1))];
	_x setSkill ["courage",(0.7 + (random 0.3))];
	_x setSkill ["commanding",1.0];
	_x setSkill ["aimingSpeed",(0.6 + (random 0.15))];
	_x setSkill ["general",1.0];
	_x setSkill ["endurance",1.0];
	_x setSkill ["reloadSpeed",(0.7 + (random 0.3))];
	_x allowFleeing 0;
}forEach allUnits;