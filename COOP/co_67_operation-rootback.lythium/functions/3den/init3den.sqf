if (is3DEN || is3DENMultiplayer) then {
	#include "blufor.sqf";
	#include "redfor.sqf";
	#include "indfor.sqf";
	#include "loadoutItems.sqf";
	#include "loadoutSavePreset.sqf";
	#include "loadoutSelector.sqf";
	#include "loadoutSet.sqf";
	#include "loadoutSetfnc.sqf";
	#include "loadoutMenu.sqf";
	#include "loadoutSaveMenu.sqf";
	#include "setStandardLoadout.sqf";
	[] spawn {
		while {true} do
		{
			waitUntil {inputAction "User11" > 0};  
			call AF_fnc_loadoutMenu;
			sleep 0.5;
		}
	};
	[] spawn {
		while {true} do
		{
			waitUntil {inputAction "User12" > 0};  
			call AF_fnc_loadoutSaveMenu;
			sleep 0.5;
		};
	};
	[] spawn {
		while {true} do
		{
			waitUntil {inputAction "User13" > 0};  
			call AF_fnc_setStandardLoadout;
			sleep 0.5;
		};
	};
};
// execVM "functions\3den\loadoutMenu.sqf";