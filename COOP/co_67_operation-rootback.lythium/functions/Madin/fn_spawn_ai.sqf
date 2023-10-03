_unit = (_this select 1) createUnit [((_this select 2)select 0), [0,0,0], [], 0, "CAN_COLLIDE"];
_mobile = _this select 3;
_spawndist = _this select 4;
[_unit] call AF_fnc_EventHandlers;
_unit setUnitLoadout ((_this select 2)select 1);
//[str ((_this select 2)select 1)] remoteExec ["systemChat"];
_unit allowDamage false;
_unit setDir ((_this select 0) select 1);
[_unit,"AmovPsitMstpSrasWrflDnon_AmovPercMstpSlowWrflDnon"] remoteExec ["SyncSwitchMove", 0];
[_unit,((_this select 0) select 0),((_this select 2)select 1)] spawn {
sleep 0.1;
(_this select 0) setUnitPos "UP";
(_this select 0) setPosATL (_this select 1);
(_this select 0) allowDamage true;
};
_unit disableAI "PATH";
_unit setVariable ["acex_headless_blacklist", true];
[_unit] call AF_fnc_AI_init;
if (_mobile) then
{
	_ehID = _unit addEventHandler ["Hit",
	{
		(_this select 0) setUnitPos "AUTO";
		(_this select 0) removeEventHandler ["Hit",(_this select 0) getvariable "hitEH"];
	}];
	_unit setVariable ["hitEH",_ehID];
	[_unit] spawn M_fnc_spawn_eh;
	[_unit,_spawndist]spawn
	{
		_unit = _this select 0;
		_spawndist = _this select 1;
		sleep 5;
		if(({isPlayer _x} count (_unit nearEntities ["allVehicles", _spawndist])) == 0)then
		{
			_time = ((group _unit) getVariable ["lastSpawn", time]) + 180;
			if (_time > time)then
			{
				{
					[_x] call M_fnc_hunter_ai;
				}forEach (units group _unit);
			}else
			{
				{
					[_x] call M_fnc_flank_ai;
				}forEach (units group _unit);
			};
		}else
		{
			_time = time + (random [30,120,180]);
			_suspend = true;
			while {_suspend} do
			{
				sleep 20;
				_spawndist = _spawndist * 0.9;
				if (!alive _unit || _time < time || (({isPlayer _x} count (_unit nearEntities ["allVehicles", _spawndist])) == 0)) then
				{
					_suspend = false;
					[_unit] call M_fnc_hunter_ai;
				};
			};
		};
	};
};
{[_x,[[_unit],true]] remoteExec ["addCuratorEditableObjects", 0];}forEach allCurators;