#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Initializes equipment in vehicle
 *
 * Arguments:
 * Vehicle to fill with standard equipment <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_vehicle"];

// TODO: Consider replacing M16A4 with rhs_weap_m4a1_carryhandle_mstock

private _equipmentList = [
    // Primary weapon ammo
    ["rhs_mag_30Rnd_556x45_M855A1_PMAG", 50],
    ["rhsusf_200Rnd_556x45_soft_pouch", 20],
    ["rhsusf_mag_15Rnd_9x19_JHP", 20],

    // Launchers
    ["rhs_weap_m72a7", 4],
    ["rhs_weap_M136_hedp", 2],
    ["rhs_weap_fim92", 2],
    ["rhs_fim92_mag", 6],

    // Grenade Launcher
    // Smokes (Grenade Launcher)
    ["1Rnd_SmokeRed_Grenade_shell", 25],
    ["1Rnd_SmokeYellow_Grenade_shell", 25],
    ["1Rnd_SmokeBlue_Grenade_shell", 25],
    ["1Rnd_SmokePurple_Grenade_shell", 25],
    ["1Rnd_SmokeGreen_Grenade_shell", 25],
    ["1Rnd_SmokeOrange_Grenade_shell", 25],

    // Flares (Grenade Launcher)
    ["UGL_FlareWhite_F", 5],
    ["UGL_FlareGreen_F", 5],
    ["UGL_FlareRed_F", 5],
    ["UGL_FlareYellow_F", 5],

    // Explosive
    ["1Rnd_HE_Grenade_shell", 10],
    ["CUP_1Rnd_HEDP_M203", 0],

    // HuntIR
    ["ACE_HuntIR_M203", 20],
    ["ACE_HuntIR_monitor", 1],

    // Throwables
    ["HandGrenade", 20],
    ["ACE_M84", 20],
    ["ACE_M14", 20],

    // Smokes (throwable)
    ["SmokeShell", 5],
    ["SmokeShellRed", 5],
    ["SmokeShellGreen", 5],
    ["SmokeShellPurple", 5],
    ["SmokeShellBlue", 5],
    ["SmokeShellYellow", 5],
    ["SmokeShellOrange", 5],

    // Medical
    ["ACE_salineIV_250", 10],
    ["ACE_salineIV_500", 10],
    ["ACE_salineIV", 10],
    ["ACE_tourniquet", 10],
    ["ACE_quikclot", 20],
    ["ACE_packingBandage", 40],
    ["ACE_fieldDressing", 20],
    ["ACE_elasticBandage", 40],
    ["ACE_morphine", 20],
    ["ACE_epinephrine", 20]
];

clearWeaponCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

{
    _x params ["_className", "_count"];
    if (_count > 0) then {
        _vehicle addItemCargoGlobal _x;
    };
} forEach _equipmentList;
