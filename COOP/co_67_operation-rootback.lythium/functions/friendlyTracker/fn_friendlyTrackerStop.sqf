/*
	AF_fnc_friendlyTrackerStop

	Description:
		Funkcja zatrzymuje skrypt markerów wskazujących sojusznicze jednostki

	Parameter(s):
		NOTHING

	Returns:
		Skrypt markerów został wyłączony [BOOL]
*/

if (hasInterface && {!AF_friendlyTrackerEnabled} && {AF_friendlyTrackerRunning}) exitWith {

	["Zatrzymywanie FriendlyTracker"] call AF_fnc_localLog;

	// Usunięcie wszystkich markerów
	{
		deleteMarkerLocal (_x select 0);
	} foreach AF_friendlyTrackerMarkers;

	AF_friendlyTrackerRunning = false;

	true
};

false