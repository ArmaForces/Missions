#include "script_component.hpp"
/*
 * Author: Krystol
 * Removes non-era object from map.
 * Comment out which objects you don't want to see.
 *
 * Example:
 * call afp_scripts_fnc_mapCleanup
 *
 * Public: No
 */

if (!isServer) exitWith {};

private _rm = [
    "Land_Kiosk_blueking_F",
    "Land_Kiosk_redburger_F",
    "Land_Kiosk_gyros_F",
    "Land_Kiosk_papers_F",
    "Land_Supermarket_01_malden_F",
    //"Land_LampHalogen_F",
    //"Land_LampAirport_F",
    //"Land_Flush_Light_green_F",
    //"Land_Flush_Light_yellow_F",
    //"Land_Flush_Light_red_F",
    //"Land_CombineHarvester_01_wreck_F",
    //"Land_HelipadCivil_F",
    //"Land_HelipadSquare_F",
    //"Land_HelipadCircle_F",
    "cinderblock_f.p3d",
    "toiletbox_f.p3d",
    "fieldtoilet_f.p3d",
    "cargo_20_light_green_f.p3d",
    "cargo_20_military_green_f.p3d",
    "cargo_20_grey_f.p3d",
    "cargo_20_white_f.p3d",
    "cargo_20_cyan_f.p3d",
    "cargo_20_yellow_f.p3d",
    "cargo_20_blue_f.p3d",
    "cargo_20_orange_f.p3d",
    "cargo_20_brick_red_f.p3d",
    "cargobox_v1_f.p3d",
    //"garbagebin_01_f.p3d",
    "billboard_03_duckit_f.p3d",
    "billboard_03_cheese_f.p3d",
    "billboard_03_koke_f.p3d",
    "billboard_03_getlost_f.p3d",
    "billboard_03_ygont_f.p3d",
    "billboard_03_mars_f.p3d",
    "billboard_03_winery_f.p3d",
    "billboard_03_pills_f.p3d",
    "billboard_03_supermarket_f.p3d",
    "billboard_03_maskrtnik_f.p3d",
    "billboard_03_blank_f.p3d",
    "billboard_03_aan_f.p3d",
    "billboard_03_argois_f.p3d",
    "billboard_03_lyfe_f.p3d",
    "billboard_03_plane_f.p3d",
    "billboard_02_carrental_f.p3d",
    "billboard_02_redstone_f.p3d",
    "billboard_02_ion_f.p3d",
    "billboard_02_chevre_f.p3d",
    "billboard_02_chevre2_f.p3d",
    "billboard_02_surreal_f.p3d",
    "billboard_02_chernarus_f.p3d",
    "billboard_04_mars_lyfe_f.p3d",
    "billboard_04_supermarket_maskrtnik_f.p3d",
    "billboard_04_koke_redstone_f.p3d",
    //"campingtable_small_f.p3d",
    //"campingchair_v1_f.p3d",
    "fuelstation_01_prices_malevil_f.p3d",
    "phonebooth_01_malden_f.p3d",
    "phonebooth_02_malden_f.p3d",
    "garbagecontainer_open_f.p3d",
    "garbagecontainer_closed_f.p3d",
    "fs_price_f.p3d",
    "wreck_car_f.p3d",
    //"wreck_ural_f.p3d",
    "atm_01_malden_f.p3d",
    "atm_02_malden_f.p3d",
    "signm_forrent_f.p3d",
    "signm_taxi_f.p3d"
]; 

_pos = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
_toHide = nearestObjects [_pos, [], worldSize, false];
_toHideFiltered = _toHide select {typeOf _x in _rm || {((getModelInfo _x) select 0) in _rm}};

{_x hideObjectGlobal true;} forEach _toHideFiltered;