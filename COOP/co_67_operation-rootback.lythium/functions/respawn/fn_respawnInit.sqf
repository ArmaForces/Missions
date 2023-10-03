/*
	AF_fnc_respawnInit

	Description:
		Inicjalizuje respawn i ilość respawnów

*/
switch (AF_side) do {
    case 1: {AF_coop_side = west};
    case 2: {AF_coop_side = east};
	case 3: {AF_coop_side = resistance};
	case 4: {AF_coop_side = civilian};
    default {AF_coop_side = west};
};

if (isServer) then {
	createMarker ["respawn", position respawn_coop];
	hideObjectGlobal respawn_coop;
	[AF_coop_side, AF_respawn_tickets] call BIS_fnc_respawnTickets;
	// Inicjalizacja ticketów dla pozostałych stron by uniknąć problemów w przypadku, gdy użytkownik zapomni wybrać stronę lub gracze są po wielu stronach.
	{
		[_x, -1] call BIS_fnc_respawnTickets;
	} forEach ([west, east, resistance] - [AF_coop_side]);
};