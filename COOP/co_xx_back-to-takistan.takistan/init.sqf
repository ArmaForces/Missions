#include "script_component.hpp"

minviewdistance = 500;
maxviewdistance = 10000;

// TODO: Remove
skipTime 2;

if (!hasInterface || isServer) then {
	[QGVAR(BastamStartEscape), {
		
		// Start Lada which will come to Bastam
		ladaToBastam_unitCapture engineOn true;
		#include "unitCaptureData\UC_ladaToBastam.hpp"
		[ladaToBastam_unitCapture, LADATOBASTAM_UC_DATA] spawn BIS_fnc_unitPlay;
		
		// Start the SUV
		[{
			suv1_unitCapture engineOn true;
		#include "unitCaptureData\UC_suv1.hpp"
		[suv1_unitCapture, SUV1_UC_DATA] spawn BIS_fnc_unitPlay;
		}, [], 0.25] call CBA_fnc_waitAndExecute;

		// Move the truck slightly after that
		[{
			// Open gate for truck
			truck_building_UC animate ["door_2_rot", 1];
			truck_building_UC animate ["door_3_rot", 1];

			truck_unitCapture engineOn true;
			#include "unitCaptureData\UC_truck.hpp"
			[truck_unitCapture, TRUCK_UC_DATA] spawn BIS_fnc_unitPlay;
		}, [], 3.25] call CBA_fnc_waitAndExecute;

		// Start Lada which will come to Bastam
		// [{
		// 	ladaToBastam_unitCapture engineOn true;
		// 	#include "unitCaptureData\UC_ladaToBastam.hpp"
		// 	[ladaToBastam_unitCapture, LADATOBASTAM_UC_DATA] spawn BIS_fnc_unitPlay;
		// }, [], 5] call CBA_fnc_waitAndExecute;
	}] call CBA_fnc_addEventHandler;

	[QGVAR(BastamUazGarageOpen), {
		// Open gate for UAZ
		uaz_garage_UC animateSource ["Door_4_sound_source", 1];
		// Slightly open second one
		uaz_garage_UC animateSource ["Door_5_sound_source", 0.1];

		uaz_unitCapture engineOn true;
		#include "unitCaptureData\UC_garage_uaz.hpp"
		[uaz_unitCapture, UAZ_UC_DATA] spawn BIS_fnc_unitPlay;
	}] call CBA_fnc_addEventHandler;

	[QGVAR(BastamAlarm), {
		[{
			[QGVAR(BastamUazGarageOpen)] call CBA_fnc_serverEvent;
		}, [], random 10] call CBA_fnc_waitAndExecute;
	}] call CBA_fnc_addEventHandler;
};
