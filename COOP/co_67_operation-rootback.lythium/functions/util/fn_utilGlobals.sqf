
AF_LIGHT_CLASSES = [
	"Lamps_Base_F",
	"PowerLines_base_F",
	"Land_LampStreet_small_F",
	"Land_PowerPoleWooden_L_F",
	"Land_PowerPoleWooden_small_F",
	"Land_LampShabby_F",
	"Land_u_Addon_02_V1_F",
	"Land_LampStreet_F",
	"Land_fs_roof_F",
	"Land_fs_sign_F",
	"Land_NavigLight",
	"Land_NavigLight_3_F",
	"Land_Flush_Light_green_F",
	"Land_Flush_Light_red_F",
	"Land_Flush_Light_yellow_F",
	"Land_runway_edgelight",
	"Land_runway_edgelight_blue_F",
	"Land_Runway_PAPI",
	"Land_Runway_PAPI_2",
	"Land_Runway_PAPI_3",
	"Land_Runway_PAPI_4",
	"Land_LampAirport_F",
	"Land_LampDecor_F",
	"Land_LampHalogen_F",
	"Land_LampHarbour_F",
	"Land_LampSolar_F",
	"Land_LampStadium_F"
];

MISSION_LOC = call {
    private "_arr";
    _arr = toArray str missionConfigFile;
    _arr resize (count _arr - 15);
    toString _arr
};