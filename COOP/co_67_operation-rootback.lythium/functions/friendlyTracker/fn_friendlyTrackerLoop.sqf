/*
	AF_fnc_friendlyTrackerLoop

	Description:
		Funkcja zajmuje się tworzeniem i odświeżaniem markerów (poprzez ich usuwanie)

	Parameter(s):
		NOTHING

	Returns:
		NOTHING
*/

// Sprawdzenie czy skrypt nie został wyłączony
if (!AF_friendlyTrackerEnabled) exitWith {
	[] call AF_fnc_friendlyTrackerStop;
};

// Usunięcie wszystkich markerów
{
	deleteMarkerLocal (_x select 0);
} foreach AF_friendlyTrackerMarkers;

private _playerSide = side player;
// Utworzenie markera dla każdego gracza znajdującego się w grze
{
	if (side _x isEqualTo _playerSide) then {
		// Jeżeli włączone jest wymaganie GPS do pokazywania markerów i gracz nie ma przypisanego GPS do slotu to idziemy do następnego
		if (AF_friendlyTrackerGPS && {(items _x findIf {_x == "ItemcTabHCam"})/*((assignedItems _x findIf {_x in ["ItemGPS", "ItemAndroid", "ItemMicroDAGR", "ItemcTab"] || {["UavTerminal", _x] call BIS_fnc_inString}})*/ == -1}) exitWith {};

		private _isPlayerGroup = group _x isEqualTo group player;
		private _marker = format["gracz_%1", getPlayerUID _x];
		createMarkerLocal [_marker, getPos _x];
		_marker setMarkerTypeLocal "mil_dot";
		AF_friendlyTrackerMarkers pushBack [_marker, _x];
		// Jeżeli gracz nie jest w pojeździe
		if (isNull objectParent _x) then {
			_marker setMarkerSizeLocal [0.5, 0.5];
		} else {
			_marker setMarkerSizeLocal [0.75, 0.75];
		};
		// Określenie koloru markera
		switch (true) do {
			// Gracz jest oznaczony na żółto
			case (_x isEqualTo player): {
				_marker setMarkerColorLocal "ColorYellow";
			};
			// Oznaczanie nieprzytomnych na pomarańczowo
			// jeżeli włączone i w drużynie gracza lub właczone pokazywanie wszystkich
			case (AF_friendlyTrackerShowUnconc && (_x getVariable ["ACE_isUnconscious", false]) && {_isPlayerGroup || {AF_friendlyTrackerShowAllGroups}}): {
				_marker setmarkercolorlocal "ColorOrange";
			};
			// Drużyna gracza jest oznaczona na zielono
			case (_isPlayerGroup): {
				_marker setMarkerColorLocal "ColorGreen";
			};
			// Oznaczenie jednostek z innych grup na niebiesko jeżeli włączone
			case (AF_friendlyTrackerShowAllGroups): {
				_marker setMarkerColorLocal "ColorWEST";
			};
			// Usunięcie markera jeżeli niedopasowano do żadnej reguły
			default {
				deleteMarkerLocal _marker;
			};
		};
	};
} foreach AllPlayers;

// Odłożenie odświeżenia w czasie zależnie od ustawień CBA
[AF_fnc_friendlyTrackerLoop, [], AF_friendlyTrackerRefreshRate] call CBA_fnc_waitAndExecute;