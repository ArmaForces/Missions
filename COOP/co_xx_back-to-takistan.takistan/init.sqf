#include "script_component.hpp"

minviewdistance = 500;
maxviewdistance = 10000;

if (!hasInterface || isServer) then {
	[QGVAR(BastamStartEscape), {
		// Open gate for truck
		truck_building_ddd animate ["door_2_rot", 1];
		truck_building_ddd animate ["door_3_rot", 1];

		// Move the truck
		truck_ddd engineOn true;
		#include "ddd.sqf";
		[truck_ddd, ddd] spawn BIS_fnc_unitPlay;
	}] call CBA_fnc_addEventHandler;
};

