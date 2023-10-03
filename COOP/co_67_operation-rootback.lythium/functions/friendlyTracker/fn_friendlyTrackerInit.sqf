/*
	AF_fnc_friendlyTrackerInit

	Description:
		Funkcja inicjalizuje skrypt markerów wskazujących sojusznicze jednostki

	Parameter(s):
		NOTHING

	Returns:
		NOTHING
*/

if (!hasInterface) exitWith {};

if (isNil("AF_friendlyTrackerRunning")) then {AF_friendlyTrackerRunning = false};

[{!AF_friendlyTrackerRunning}, {
	AF_friendlyTrackerRunning = true;

	["Uruchamianie FriendlyTracker"] call AF_fnc_localLog;

	AF_friendlyTrackerMarkers = [];

	[] call AF_fnc_friendlyTrackerLoop;
}, [], AF_friendlyTrackerRefreshRate + 1, {}] call CBA_fnc_waitUntilAndExecute;