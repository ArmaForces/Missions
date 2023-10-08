/*
TO WKLEIĆ DO INIT GRUPY! NIE JEDNOSTKI, GRUPY!

do poprawnego działania wymagany Headless Client, JEDEN!
// ==========

if (!hasInterface && !isServer || hasInterface && isServer) then {[this,[8,20,40]] execVM "cacheSpawn.sqf"}else
{if (isServer) then {{_x disableAI "PATH";}forEach units this}};

// ==========
10 = minimalna ilość botów
15 = maksymalna ilość botów
50 = ilość botów spawnowanych (łącznie = to +  minimalna ilość botów)
nie wiesz czy i jak edytować? TO NIE DOTYKAJ! SKOPIUJ JAK JEST.
*/
_group = (_this select 0);
_unitsCount = (_this select 1);
_totalUnits = (_this select 1) select 2;
_side = side _group;
_grpArr = [];
_grpType = [typeOf (leader _group)];
_posl = GetPosATL (leader _group);
_dirl = getDir (leader _group);
deleteVehicle (leader _group);
_grpArr append [[_posl, _dirl]];
_units = units _group;
_distArr = [];
{
	_grpType pushBackUnique (typeOf _x);
	_pos = GetPosATL _x;
	_dir = getDir _x;
	deleteVehicle _x;
	_grpArr append [[_pos, _dir]];
	_cacheDist = _posl distance _pos;
	_distArr append [_cacheDist];
}forEach _units;
deleteGroup _group;
_distArr sort false;
_distance = (_distArr select 0) + 30;
_suspend = true;
_grpArr call BIS_fnc_arrayShuffle;
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
		[_grpArr, _grpType, _newGroup,_unitsCount,_posl,_distArr select 0] spawn fnc_dynamic_spawn;
	};
	_building = damage (nearestObjects [(_x select 0), ["House", "Building"], 50] select 0);
	if ((_building) < 0.25) then
	{
		[_x,_newGroup,(selectRandom _grpType)] call fnc_spawn_ai;
		_delArr append [_forEachIndex];
	};
}forEach _grpArr;
_newGroup setCombatMode "RED";
sleep 15;
_newGroup setVariable ["aiWait", nil];