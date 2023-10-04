NukeTimeRemaining = NukeTimeRemaining - 1;

if (NukeTimeRemaining == 83) then {
	["COD_MW2_Whiskey_Hotel_Part_3"] remoteExec ["playMusic", 0];
};

if (NukeTimeRemaining == 0) exitWith {
	[MDL_fnc_nukeDetonate, [], 1] call CBA_fnc_waitAndExecute;
};

if (NukeTimeRemaining < 0) exitWith {};

[MDL_fnc_nukeCountdown, [], 1] call CBA_fnc_waitAndExecute;
