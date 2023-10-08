/*
TO WKLEIĆ DO INIT GRUPY! NIE JEDNOSTKI, GRUPY!

do poprawnego działania wymagany Headless Client, JEDEN!
// ==========

if (!hasInterface && !isServer || hasInterface && isServer) then {[this, 15, 150, 750, 0] execVM "civilians.sqf";};

// ==========
this = to
15 = ilość botów
150 = maksymalna odległość chałup, do których boty będą wchodzić
750 = odległość aktywacji
0 - rodzaj cywili. 0 = Grecja, 1 = Takistan, 2 = Ruskie, 3 = robotnicy
nie wiesz czy i jak edytować? TO NIE DOTYKAJ! SKOPIUJ JAK JEST.
*/
_Gre = ["C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_Man_casual_4_F","C_Man_casual_5_F","C_Man_casual_6_F","C_Man_casual_1_F","C_Man_casual_2_F","C_Man_casual_3_F","C_man_sport_1_F","C_man_sport_2_F","C_man_sport_3_F"];
_Tak = ["LOP_Tak_Civ_Man_06","LOP_Tak_Civ_Man_08","LOP_Tak_Civ_Man_07","LOP_Tak_Civ_Man_05","LOP_Tak_Civ_Man_01","LOP_Tak_Civ_Man_10","LOP_Tak_Civ_Man_02","LOP_Tak_Civ_Man_09","LOP_Tak_Civ_Man_11","LOP_Tak_Civ_Man_12","LOP_Tak_Civ_Man_04","LOP_Tak_Civ_Man_14","LOP_Tak_Civ_Man_13","LOP_Tak_Civ_Man_16","LOP_Tak_Civ_Man_15"];
_rus = ["LOP_Tak_Civ_Man_06"];
_work = ["C_man_w_worker_F","C_Man_UtilityWorker_01_F","C_Man_ConstructionWorker_01_Black_F","C_Man_ConstructionWorker_01_Red_F","C_Man_ConstructionWorker_01_Blue_F"];
_arrCiv = [_Gre,_Tak,_rus,_work];
_buildings = (nearestObjects [_this select 0, ["House", "Building"], _this select 2]);
_allAgents = [];
_playerDetect = false;
Madin_ai_spawning = true;
while {Madin_ai_spawning} do
{
	while {!_playerDetect} do
	{
		{
			if (((getPosATL _x) distance (_this select 0)) < (_this select 3))exitWith
			{
				systemchat str "spawnowanie botów";
				_playerDetect = true;
				for "_i" from 1 to (_this select 1) do
				{
					_searching = true;
					while {_searching} do
					{
						_building = (selectRandom _buildings);
						_allpositions = _building buildingPos -1;
						if ((count _allpositions) > 0)then
						{
							_searching = false;
							_pos = selectRandom _allpositions;
							_agent = createAgent [selectRandom (_arrCiv select (_this select 4)), _pos, [], 0, "CAN_COLLIDE"];
							_agent disableAI "FSM";
							_agent setBehaviour "CARELESS";
							_agent forceWalk true;
							_allAgents pushBackUnique _agent;
							_agent addEventHandler ["Killed",
							{
								_killer = (_this select 0) getVariable ["ace_medical_lastDamageSource", objNull];
								{
								if (_killer == _x) exitWith
									{  
										_pos = getpos (_this select 0);  
										_mark1 = createMarker [str _pos, _this select 0];   
										_text1 = format ["Cywil zabity przez %1", name _killer];  
										_mark1 setMArkerType "mil_Warning";  
										_mark1 setMarkerText _text1;  
										_mark1 setMarkerColor "ColorRed";  
										_mark1 setMarkerSize [0.5, 0.5];  
										_mark1 setMarkerAlpha 0.75;
									};
								}forEach allPlayers;
							}];
							_eh1 = _agent addEventHandler ["FiredNear",
							{
								(_this select 0) forceWalk false;
								doStop (_this select 0);
								switch(round(random 2))do{
								case 0:{ [(_this select 0),"ApanPercMstpSnonWnonDnon_G01"] remoteExec ["SyncSwitchMove", 0]; (_this select 0) forceSpeed ((_this select 0) getSpeed "FAST");};
								case 1:{(_this select 0) playMoveNow "ApanPknlMstpSnonWnonDnon_G01";(_this select 0) forceSpeed ((_this select 0) getSpeed "FAST");};
								case 2:{(_this select 0) playMoveNow "ApanPpneMstpSnonWnonDnon_G01";(_this select 0) forceSpeed ((_this select 0) getSpeed "FAST");};
								default{(_this select 0) playMoveNow "ApanPknlMstpSnonWnonDnon_G01";(_this select 0) forceSpeed ((_this select 0) getSpeed "FAST");};};	
								_buildings = (nearestObjects [_this select 0, ["House", "Building"], 30]);
								_building = (selectRandom _buildings);
								_allpositions = _building buildingPos -1;
								if ((count _allpositions) > 0)then
								{
									_pos = selectRandom _allpositions;
									(_this select 0) moveTo _pos;
								}else
								{
									(_this select 0) moveTo getPosATL _building;
								};
								(_this select 0) removeEventHandler ["FiredNear", 0];
							}];
							[_agent, _buildings] spawn
							{
								while {alive (_this select 0)}do
								{
									_building = (selectRandom (_this select 1));
									_allpositions = _building buildingPos -1;
									if ((count _allpositions) > 0)then
									{
										_pos = selectRandom _allpositions;
										(_this select 0) moveTo _pos;
									}else{
									(_this select 0) moveTo getPosATL _building;
									};
									if (!isForcedWalk (_this select 0)) then{
									sleep random [60,120,240];
									};
									sleep random [30,60,120];
								};
							};
						};
					};
					sleep 0.01;
				};
			};
			sleep 0.02;
		}forEach allPlayers;
		sleep 1;
	};
	sleep 1;
	while {_playerDetect} do
	{
		sleep 1;
		_playersNear = {((getPosATL _x) distance (_this select 0)) < ((_this select 3) + 100)} count allPlayers;
		if (_playersNear == 0)exitWith
		{
			systemchat str "usuwanie botów";
			{deleteVehicle _x}forEach _allAgents;
			_allAgents = [];
			_playerDetect = false;
		};
		sleep 0.02;
	};
};
{deleteVehicle _x}forEach _allAgents;
_allAgents = [];
_playerDetect = false;