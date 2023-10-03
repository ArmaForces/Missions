/*
TO WKLEIĆ DO SAMEGO POJAZDU!

do poprawnego działania wymagany Headless Client, JEDEN!
// ==========

if (!hasInterface && !isServer || hasInterface && isServer) then {[this,8,50] execVM "M_scripts\airesp.sqf"}else
{if (isServer) then {{_x disableAI "PATH";}forEach units group this}};


// ==========
this = to, nie zmieniamy
8 = ilość ticketów odrodzeń dla grupy
50 = odległość gracza od respawnu, przy której respawn jest usuwany

respawn jednostek po śmierci jednej osoby z drużyny. Miejsce respawnu jest jednostka, do której wrzucimy skrypt (TYLKO JEDNA!)
wklejamy tylko do jednej jednostki, która nie jest liderem grupy.
Lidera grupy ustawiamy przy wyjściu ze spawnu, będzie to pierwszy waypoint nowo powstałej jednostki (by ai nie przechodziło na start przez ściany)
UWAGA! nowe jednostki potrzebują dosyć sporo miejsca wokół siebie, by były w stanie znaleźć wyjście / nie przechodziły przez ściany. Armowy pathfinding.

nie wiesz czy i jak edytować? TO NIE DOTYKAJ! SKOPIUJ JAK JEST.
*/
waitUntil {time > 0};
params ["_spawner","_tickets","_radius","_newLoadout"];
_spawner = _this select 0;
_group = group _spawner;
_pos = GetPosATL _spawner;
_dir = getDir _spawner;
_gear = [];
{
	_gear pushBackUnique [typeOf _x,getUnitLoadout _x]; 
}forEach (units _group);
_id = clientOwner;
[_group,_id] remoteExec ["setGroupOwner",2,false];
waitUntil {sleep 1; local _group};
_group setVariable ["M_spawner",[_pos,_dir]];
_group setVariable ["M_spawner_pos",getposATL (leader _group)];
_group setVariable ["M_respAI",_tickets];
_group setVariable ["M_gear",_gear];
_buildings = [];
_nearbuildings = (nearestObjects [_pos, ["House", "Building"], 10]);
{
	if (alive _x) then
	{
		_buildings pushBack _x;
	};
}forEach _nearBuildings;
_group setVariable ["M_nearbuildings",_buildings];
{
	if ((uniform _x) == "") then 
	{
		_unit = _x;
		if (_gear isEqualTo []) then
		{
			_x setUnitLoadout (typeOf _unit);
		}else
		{
			_loadout = _gear findIf {(_x select 0) == (typeOf _unit)};
			_unit setUnitLoadout ((_gear select _loadout)select 1);
		};
	};
	[_x] spawn M_fnc_M_AirespawnEH;
}forEach (units _group);
_group setVariable ["M_spawn_active",true];
_wp = waypoints _group;
if ((count _wp) > 1) then {
_wPos = waypointPosition (_wp select 1);
{_x setposATL _wPos}forEach (units _group);
};
while {_group getVariable ["M_spawn_active",false]} do
{
_nearplayers = _pos nearEntities ["allVehicles", _radius];
_player = _nearplayers findIf {isPlayer _x};
	if (_player != -1)then
	{
		_group setVariable ["M_spawn_active",false];
	};
sleep 1;
};