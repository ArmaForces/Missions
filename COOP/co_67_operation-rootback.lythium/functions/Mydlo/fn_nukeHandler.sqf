if (!isServer) exitWith {};

private _nuke_town_area = createMarkerLocal ["sys_marker_nukeInitial", getPos nuclear_device];
_nuke_town_area setMarkerShapeLocal "ELLIPSE";
_nuke_town_area setMarkerSizeLocal [1000, 1000];

[{!isNil "NukeTimeRemaining" && {daytime > 16.75 || {!isNil 'start_countdown'}}}, {
	NukeTimeRemaining = 900;
	[MDL_fnc_nukeCountdown, [], 0] call CBA_fnc_waitAndExecute;
}, [], -1] call CBA_fnc_waitUntilAndExecute;

[nuclear_device, "Rozbrój bombę", "", "", "true", "true", {
	// On start
	titleText ["Upewnij się, że jesteś inżynierem i masz odpowiednie narzędzia!", "PLAIN", 1];
}, {}, {
	// On complete
	if (-1 == (items (_this select 1) findIf {_x == "ACE_DefusalKit"})) then {
		titleText [": )", "PLAIN", 1];
		[MDL_fnc_nukeDetonate, [], 3] call CBA_fnc_waitAndExecute;
	};
	NukeTimeRemaining = -1;
}, {}, [], 20, 9, false, false] remoteExec ["BIS_fnc_holdActionAdd", 0, true];

[nuclear_device, "Sprawdz pozostaly czas", "", "", "true", "true", {}, {}, {
	remoteExec ["MDL_fnc_nukeTimer", 2];
}, {}, [], 1, 10, false, false] remoteExec ["BIS_fnc_holdActionAdd", 0, true];