sleep 10;
private _unit = _this select 0;
if ((((group _unit) getVariable ["M_nearbuildings",[]]) findIf {!alive _x}) != -1) then
{
	(group _unit) setVariable ["M_spawn_active",false];
};
if ((group _unit) getVariable ["M_spawn_active",false])then
{
	_unit addEventHandler ["Killed",
	{
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		_group = group _unit;
		if (_group getVariable ["M_spawn_active",false])then
		{
			_pos = _group getVariable "M_spawner" select 0;
			_dir = _group getVariable "M_spawner" select 1;
			_allgear = _group getVariable "M_gear";
			_gear = _allgear select 0;
			_allgear deleteAt 0;
			_allgear pushBack _gear;
			_group setVariable ["M_gear",_allgear];
			_new = [_group, _gear select 0,_pos,_dir] call M_fnc_spawnAI;
			_new setUnitLoadout (_gear select 1);
			_tickets = (_group getVariable ["M_respAI",0]) - 1;
			if (_tickets > 0)then
			{
				_group setVariable ["M_respAI",_tickets];
				[_new] spawn M_fnc_M_AirespawnEH;
			};
			_new spawn
			{
				_group = group _this;
				sleep random [1,2,3];
				_this selectWeapon ((weapons _this) select 0);
				_this doMove (_group getVariable ["M_spawner_pos",getposATL (leader _group)]);
				sleep random [5,10,15];
				[_this] call M_fnc_hunter_ai;
			};
		};
	}];
};