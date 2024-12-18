#include "script_component.hpp"

if (!isNil QUOTE(RESPAWN_HELPER_VR)) then {
    createMarker ["respawn", position RESPAWN_HELPER_VR];
};

private _spawnableVehicles = [
    // LOG
    ["gm_ge_army_iltis_cargo", 2], // 1 deployed
    ["gm_ge_army_m113a1g_command", 1],
    ["cwr3_b_m577_hq", 1],
    ["gm_ge_army_fuchsa0_command", 1],
    ["gm_ge_army_bpz2a0", 2],
    ["gm_ge_army_kat1_451_reammo", 4], // 2 deployed
    ["B_Truck_01_fuel_F", 2],

    // SUP
    ["gm_ge_army_gepard1a1", 1], // 1 deployed
    ["gm_ge_army_m109g", 2],
    ["cwr3_b_m163", 4],
    ["gm_ge_army_kat1_463_mlrs", 1],

    // TNK
    ["gm_ge_army_Leopard1a1", 1],
    ["gm_ge_army_Leopard1a3", 2], // 2 deployed
    ["gm_ge_army_marder1a1a", 4],
    ["cwr3_b_m60a3", 2], // 2 deployed
    ["amx30", 2], // 2 deployed

    // REC
    ["gm_ge_army_iltis_milan", 4],
    ["gm_ge_army_bo105m_vbh", 0],
    ["gm_ge_army_fuchsa0_reconnaissance", 0], // 1 deployed
    ["gm_ge_army_luchsa1", 0], // 1 deployed
    ["amx10rc", 0], // 2 deployed

    // VEH
    ["cwr3_b_m901_itv", 2],
    ["cwr3_b_hmmwv_tow", 4],
    ["mephisto", 4],

    // HEL
    ["cwr3_b_ah1f", 2]
];

{
    _x call afwg_deployment_fnc_addDeployableVehicle;
} forEach _spawnableVehicles;
