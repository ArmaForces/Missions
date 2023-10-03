// Sprawdzanie czy gracz ma tickety, jeśli nie to go zabija
if (AF_ticketsPerPlayer) then {
	[player] remoteExecCall ["AF_fnc_playerTicketsCheck", 2, false];
};

// Dodanie zatyczek do uszu i krótkiego radia
if (-1 == ((items player) findIf {_x == "ACE_EarPlugs"})) then {
	player addItem "ACE_EarPlugs"
};
player addItem "ACRE_PRC343";

// Zapisanie loadout gracza
playerloadout = getUnitLoadout player;

// Dodanie akcji do zmiany odległości widzenia oraz nazw drużyn
call AF_fnc_playerActions;

// Dodanie gracza do zeusa
[{
	{
		[_x, [[player], true]] remoteExec ["addCuratorEditableObjects", 2];
	} forEach allCurators;
}, [], 1] call CBA_fnc_waitAndExecute;

// Sprawdzenie czy gracz został rozłączony i odpalenie mu okna dialogowego
[{
	[player, getPlayerUID player] remoteExec ["AF_fnc_crashTeleportCheck", 2];
}, [], 1] call CBA_fnc_waitAndExecute;

// Przypisanie zmiennej do gracza po pewnym czasie od startu by zapobiec sytuacji, w której gracz zostaje wyrzucony na starcie i po wejściu do gry serwer chce go teleportować, co jest bez sensu
[{
	if (alive player) then {
		player setVariable ["AF_crashTeleport_Ready", true, true];
	};
}, [], 300] call CBA_fnc_waitAndExecute;

// Ustawianie odległości widzenia trawy
if (AF_DetailDistance >= 0) then {
	if (getTerrainGrid > AF_DetailDistance) then {
		setTerrainGrid AF_DetailDistance;
	} else {
		setTerrainGrid getTerrainGrid;
	};
};

// A to nie wiem po co, niech ktoś
{
	_x addEventHandler ["CuratorWaypointPlaced", {
		params ["_curator", "_group", "_waypointID"];
		[_group, ["AF_canDeleteWaypoint", false]] remoteExecCall ["setVariable", leader _group];
	}];
} forEach allCurators;
