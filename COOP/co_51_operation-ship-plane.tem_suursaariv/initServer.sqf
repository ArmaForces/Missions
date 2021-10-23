#include "script_component.hpp"

// Frigate flags
frigate_players forceFlagTexture '\A3\ui_f\data\map\markers\flags\Denmark_ca.paa';
frigate_korean_1 forceFlagTexture '\KPA\data\flag_dprk_co.paa';
frigate_korean_2 forceFlagTexture '\KPA\data\flag_dprk_co.paa';
frigate_korean_3 forceFlagTexture '\KPA\data\flag_dprk_co.paa';


private _infantryArmoryCrates = [
	rearm_crate_1,
	rearm_crate_2
];

{
	// Stanag
	_x addItemCargoGlobal ["CUP_30Rnd_556x45_PMAG_QP_Tan", 30];
	_x addItemCargoGlobal ["CUP_30Rnd_556x45_PMAG_QP_Tracer_Green", 70];
	_x addItemCargoGlobal ["CUP_20Rnd_762x51_HK417", 10];
	// MG mags
	_x addItemCargoGlobal ["sfp_200Rnd_556x45_ksp90", 30];
	_x addItemCargoGlobal ["CUP_100Rnd_556x45_BetaCMag_ar15", 30];
	// Pistol ammo
	_x addItemCargoGlobal ["CUP_17Rnd_9x19_glock17", 30];
	// Redeye
	_x addItemCargoGlobal ["sfp_rbs69", 1];
	_x addItemCargoGlobal ["sfp_rbs69_mag", 3];
	// Gustav
	_x addItemCargoGlobal ["sfp_grg86", 2];
	_x addItemCargoGlobal ["MRAWS_HEAT_F", 12];
	_x addItemCargoGlobal ["MRAWS_HE_F", 12];
	// AT-4
	_x addItemCargoGlobal ["CUP_launch_M136", 8];
	// LAW72
	_x addItemCargoGlobal ["CUP_launch_M72A6", 16];
} forEach _infantryArmoryCrates;


["AirfieldSecured", {
	deleteVehicle airfield_flag_korean_1;
	"sys_marker_delivery_zone" setMarkerAlpha 1;
	"sys_marker_base" setMarkerType "hd_flag";
	"sys_marker_base" setMarkerColor "ColorWEST";

	private _areaId = airfieldhq_buildable_module getVariable ["afmf_buildables_area", ""];
	["afmf_buildables_deliverSupply", [_areaId]] call CBA_fnc_serverEvent;
}] call CBA_fnc_addEventHandler;

["FieldHospitalBuilt", {
	"sys_marker_field_hospital" setMarkerType "b_med";
	"sys_marker_field_hospital" setMarkerColor "ColorWEST";
	"sys_marker_field_hospital" setMarkerSize [0.5, 0.5];
	//"sys_marker_field_hospital" setMarkerText "Szpital polowy";
}] call CBA_fnc_addEventHandler;

["ServiceDepotBuilt", {
	"sys_marker_service_depot" setMarkerType "b_service";
	"sys_marker_service_depot" setMarkerColor "ColorWEST";
	"sys_marker_service_depot" setMarkerSize [0.5, 0.5];
	//"sys_marker_service_depo" setMarkerText "Punkt serwisowy";
}] call CBA_fnc_addEventHandler;
