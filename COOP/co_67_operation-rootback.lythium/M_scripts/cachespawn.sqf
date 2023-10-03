/*
TO WKLEIĆ DO INIT GRUPY! NIE JEDNOSTKI, GRUPY!

do poprawnego działania wymagany Headless Client, JEDEN!
// ==========

if (!hasInterface && !isServer || hasInterface && isServer) then {[this,[4,30,50],30,0,2,true] execVM "M_scripts\cacheSpawn.sqf"}else
{if (isServer) then {{_x disableAI "PATH";}forEach units this}};

// ==========
4 = minimalna ilość botów
30 = maksymalna ilość botów
40 = ilość botów spawnowanych ("ticket" odrodzeń)
30 = minimalny dystans (może być większy!) do najbliższej jednostki ,przy której skrypt zostanie aktywowany. liczony od lidera. Oznacza również dystans spawnu botów (minimalny).
0 = preferowany maksymalny dystans (plus minimalny) do najbliższego gracza dla odradzania dodatkowych botów, gdy ilość jest poniżej minilanej.
Ignorowany, gdy nie ma takiej możliwości lub ustawiony na 0. Potrzebny jedynie przy ogromnych grupach rozstawionych na dużą część mapy, np. cała Kavala.
2 = ile razy maksymalnie jednostka może zrespawnować się z tego samego miejsca, zanim spawn zostanie usunięty.
true = dynamiczny spawn jednostek / false = jednostki spawnują się stacjonarne. Spawn wszystkich jednostek na raz oraz brak nowych spawnów.
przy jednostkach stacjonarnych ilość botów jest ignorowana.
nie wiesz czy i jak edytować? TO NIE DOTYKAJ! SKOPIUJ JAK JEST.
*/
_group = (_this select 0);
_unitsCount = (_this select 1);
_totalUnits = _unitsCount select 2;
_dist = _this select 2;
_mindist = _this select 3;
_limit = _this select 4;
_mobile = _this select 5;
if (!_mobile) then 
{
	_unitsCount = [1000,1000,1000];
};
_side = side _group;
_grpArr = [];
_leader = (leader _group);
_time = time + 10;
waitUntil {(uniform _leader) != "" || time > _time};
_grpType = [[typeOf _leader, getUnitLoadout _leader]];
_posl = GetPosATL _leader;
_dirl = getDir _leader;
_building = nearestObjects [_leader, ["House", "Building"], 20] select 0;
deleteVehicle _leader;
_grpArr append [[_posl,_dirl,_building,_limit]];
_units = units _group;
_distArr = [];
{
	_time = time + 10;
	waitUntil {(uniform _x) != "" || time > _time};
	_type = [typeOf _x, getUnitLoadout _x];
	_finder = _grpType findif {(_type select 0) == (_x select 0)};
	if (_finder == -1) then
	{
		_grpType pushBack _type;
	};
	_pos = GetPosATL _x;
	_dir = getDir _x;
	_building = nearestObjects [_x, ["House", "Building"], 20] select 0;
	deleteVehicle _x;
	_grpArr append [[_pos,_dir,_building,_limit]];
	_cacheDist = _posl distance _pos;
	_distArr append [_cacheDist];
}forEach _units;
deleteGroup _group;
_distArr sort false;
_distance = (_distArr select 0) + _dist;
_suspend = true;
[_grpArr,true] call CBA_fnc_shuffle;
while {_suspend} do
{
	sleep 1;
	_entities = _posl nearEntities ["AllVehicles", _distance];
	{
		if (isPlayer _x) exitWith {_suspend = false};
	}forEach _entities;
};
_newGroup = createGroup _side;
_newGroup setVariable ["MadinEnableAi", false, true];
_newGroup setVariable ["aiWait", false];
_newGroup allowFleeing 0;
_delArr = [];
{
	if (count units _newGroup >= ((_unitsCount select 0)/ 2))exitWith
	{
		{_grpArr deleteAt _x;}forEach _delArr;
		[_grpArr, _grpType, _newGroup,_unitsCount,_posl,_distArr select 0,_dist,_mindist] spawn M_fnc_dynamic_spawn;
	};
	_building = _x select 2;
	_damage = damage _building;
	if (_damage < 0.2) then
	{
		[_x,_newGroup,(selectRandom _grpType),_mobile,_dist] call M_fnc_spawn_ai;
		_delArr append [_forEachIndex];
	};
}forEach _grpArr;
_newGroup setCombatMode "RED";
sleep 15;
_newGroup setVariable ["aiWait", nil];