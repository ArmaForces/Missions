[{(!isNil("scudCountdown")) OR daytime >= 5.5 OR !(alive scud)},{
	if (!alive scud) exitWith {};
	if ((gunner scud) isEqualTo objNull) exitWith {
		[{!((gunner scud) isEqualTo objNull) OR (!alive scud)}, {
			if (!alive scud) exitWith {};
			call MDL_fnc_scudLauncher;
		}, [], -1] call CBA_fnc_waitUntilAndExecute;
	};
	
	if ((side (gunner scud)) == WEST) exitWith {
		call MDL_fnc_scudLauncher;
	};
	// Raise launcher, status 2 when finished
	[scud,'PREP'] execVM '\pook_ARTY\scripts\SCUD.sqf';
	[{(((scud getVariable ["ScudLoadStatus", 0]) == 2) AND daytime >= 5.967) OR !(alive scud)}, {
		if (!alive scud) exitWith {};
		if ((gunner scud) isEqualTo objNull) exitWith {
			[{!((gunner scud) isEqualTo objNull) OR (!alive scud)}, {
				if (!alive scud) exitWith {};
				call MDL_fnc_scudLauncher;
			}, [], -1] call CBA_fnc_waitUntilAndExecute;
		};
		if ((side (gunner scud)) == WEST) exitWith {
			call MDL_fnc_scudLauncher;
		};
		// Select warhead, status 3 when finished
		[scud,'NUK'] execVM '\pook_ARTY\scripts\SCUD.sqf';
	}, [], -1] call CBA_fnc_waitUntilAndExecute;

	[{(((scud getVariable ["ScudLoadStatus", 0]) == 3) AND daytime >= 5.99832) OR !(alive scud)}, {
		if (!alive scud) exitWith {};
		if ((gunner scud) isEqualTo objNull) exitWith {
			[{!((gunner scud) isEqualTo objNull) OR (!alive scud)}, {
				if (!alive scud) exitWith {};
				call MDL_fnc_scudLauncher;
			}, [], -1] call CBA_fnc_waitUntilAndExecute;
		};
		if ((side (gunner scud)) == WEST) exitWith {
			call MDL_fnc_scudLauncher;
		};
		// Select warhead, status 3 when finished
		(gunner scud) doArtilleryFire [getMarkerPos "marker_airfield", "pook_SCUD_1Rnd_5kt", 1];
	}, [], -1] call CBA_fnc_waitUntilAndExecute;
}, [], -1] call CBA_fnc_waitUntilAndExecute;