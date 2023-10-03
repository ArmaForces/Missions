if (isServer) then
{
	[] spawn
	{
		while {true} do
		{
			if (AF_enableAI) then
			{
				{
					if (!isPlayer leader _x && {_x getVariable ["MadinEnableAi", true]}) then
					{
						_x setVariable ["MadinEnableAi", false];
						[_x]spawn
						{
							_group = (_this select 0);
							sleep 1;
							waitUntil {sleep 1; ((behaviour leader _group) == "COMBAT" || (behaviour leader _group) == "AWARE" || (count units _group) == 0)};
							if ((count units _group) == 0)exitWith {};
							sleep random 1;
							[_group] remoteExecCall ["M_fnc_loop_ai", leader _group];
							sleep random [45,60,75];
							_group setVariable ["MadinEnableAi", nil];
						};
					};
				}forEach allGroups;
			};
			sleep 60;
		};
	};
};
// HC and Server
if (!hasInterface || isServer) then {
	[] spawn
	{
		while {true} do
		{
			{
				[_x,AF_grenadeSpam - 1] spawn {
					sleep random (_this select 1);
					[(_this select 0)] call M_fnc_agressive_ai;
				};
			} forEach ([] call AF_fnc_getAllLocalUnits);
			sleep AF_grenadeSpam;
		};
	};
};