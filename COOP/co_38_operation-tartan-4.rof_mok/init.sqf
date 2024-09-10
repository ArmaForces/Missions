#include "script_component.hpp"

minviewdistance = 500;
maxviewdistance = 10000;

/* SET CAMO FOR SPAWNED VEHICLES */

{
    [_x, "init", {
        [
            (_this select 0),
            ["CIV_OCRE",1],
            true
        ] call BIS_fnc_initVehicle;
    }] call CBA_fnc_addClassEventHandler;
} forEach [
    "CUP_O_Mi8_CHDKZ",
    "CUP_O_Mi8_medevac_CHDKZ",
    "CUP_O_Mi8_VIV_CHDKZ"];

{
    [_x, "init", {
        [
            (_this select 0),
            ["SLA",1],
            true
        ] call BIS_fnc_initVehicle;
    }] call CBA_fnc_addClassEventHandler;
} forEach [
    "CUP_O_UAZ_Unarmed_CHDKZ",
    "CUP_O_UAZ_AGS30_CHDKZ",
    "CUP_O_UAZ_MG_CHDKZ",
    "CUP_O_UAZ_METIS_CHDKZ",
    "CUP_O_UAZ_Open_CHDKZ",
    "CUP_O_UAZ_AA_CHDKZ",
    "CUP_O_UAZ_SPG9_CHDKZ",
    "CUP_O_BTR80A_CHDKZ",
    "CUP_O_BTR80_CHDKZ",
    "CUP_O_BTR60_CHDKZ",
    "CUP_O_T55_CHDKZ",
    "CUP_O_T72_CHDKZ",
    "CUP_O_ZSU23_Afghan_ChDKZ",
    "CUP_O_ZSU23_ChDKZ",
    "CUP_O_Ural_Repair_CHDKZ",
    "CUP_O_Ural_Reammo_CHDKZ",
    "CUP_O_Ural_Refuel_CHDKZ",
    "CUP_O_Ural_Empty_CHDKZ",
    "CUP_O_Ural_Open_CHDKZ",
    "CUP_O_Ural_ZU23_CHDKZ",
    "CUP_O_Ural_CHDKZ"];

{
    [_x, "init", {
        [
            (_this select 0),
            ["NAPA",1],
            true
        ] call BIS_fnc_initVehicle;
    }] call CBA_fnc_addClassEventHandler;
} forEach [
    "CUP_O_MTLB_pk_ChDKZ",
    "CUP_O_BMP2_CHDKZ",
    "CUP_O_BMP_HQ_CHDKZ",
    "CUP_O_BMP2_AMB_CHDKZ",
    "CUP_O_BRDM2_CHDKZ",
    "CUP_O_BRDM2_HQ_CHDKZ",
    "CUP_O_BRDM2_ATGM_CHDKZ"];

{
    [_x, "init", {
        [
            (_this select 0),
            [
                "Camo", 0.6,
                "Olive", 0.6,
                "Red", 0.6,
                "Red2", 0.6,
                "Black", 0.6,
                "DarkBlue", 0.6,
                "Grey", 0.6,
                "DarkGrey", 0.6,
                "White2", 0.6],
            true
        ] call BIS_fnc_initVehicle;
    }] call CBA_fnc_addClassEventHandler;
} forEach [
    "CUP_O_Hilux_AGS30_CHDKZ",
    "CUP_O_Hilux_igla_CHDKZ",
    "CUP_O_Hilux_metis_CHDKZ",
    "CUP_O_Hilux_MLRS_CHDKZ",
    "CUP_O_Hilux_podnos_CHDKZ",
    "CUP_O_Hilux_SPG9_CHDKZ",
    "CUP_O_Hilux_UB32_CHDKZ",
    "CUP_O_Hilux_zu23_CHDKZ",
    "CUP_O_Hilux_unarmed_CHDKZ",
    "CUP_O_Hilux_DSHKM_CHDKZ"];
