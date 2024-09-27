#define PREFIX AFSG
#define COMPONENT Patrol

// Version
#define MAJOR 1
#define MINOR 0
#define PATCHLVL 0

// Map
#define MAP VR

#define DEBUG_SYNCHRONOUS
//#define DEBUG_MODE_FULL

// ACE3
#define ACE_PREFIX ace

#define ACEGVAR(module,var) TRIPLES(ACE_PREFIX,module,var)
#define QACEGVAR(module,var) QUOTE(ACEGVAR(module,var))

#define ACEFUNC(var1,var2) TRIPLES(DOUBLES(ACE_PREFIX,var1),fnc,var2)
#define QACEFUNC(var1,var2) QUOTE(ACEFUNC(var1,var2))

#define PATHTOACEF(var1,var2) PATHTOF_SYS(\z\ace\addons,var1,var2)
#define QPATHTOACEF(var1,var2) QUOTE(PATHTOACEF(var1,var2))

// AF Mods
#define AFM_PREFIX afm

#define AFMGVAR(module,var) TRIPLES(AFM_PREFIX,module,var)
#define QAFMGVAR(module,var) QUOTE(AFMGVAR(module,var))

#define AFMFUNC(var1,var2) TRIPLES(DOUBLES(AFM_PREFIX,var1),fnc,var2)
#define QAFMFUNC(var1,var2) QUOTE(AFMFUNC(var1,var2))

#define PATHTOAFMF(var1,var2) PATHTOF_SYS(\x\afm\addons,var1,var2)
#define QPATHTOAFMF(var1,var2) QUOTE(PATHTOAFMF(var1,var2))

// Preset stuff
#define RESPAWN_HELPER_VR respawn

#include "\x\cba\addons\main\script_macros_mission.hpp"

// Patrol stuff

#define REDFOR_SPAWN_MARKER "sys_marker_redfor_spawn"
#define REDFOR_LOADOUT [["CUP_smg_Mac10","CUP_muzzle_mfsup_Suppressor_Mac10","","",["CUP_30Rnd_45ACP_MAC10_M",30],[],""],[],["ACE_Flashlight_Maglite_ML300L","","","",[],[],""],["CUP_U_O_CHDKZ_Lopotev",[["ACE_fieldDressing",20],["ACE_epinephrine",3],["ACE_morphine",3],["ACE_tourniquet",2],["ACRE_PRC343",1],["ACE_EarPlugs",1]]],["CUP_V_I_RACS_Carrier_Rig_wdl_2",[["ACE_wirecutter",1],["CUP_30Rnd_45ACP_MAC10_M",6,30],["ACE_M84",4,1],["ACE_HandFlare_Yellow",2,1]]],[],"","G_Balaclava_blk",[],["ItemMap","","","ItemCompass","ItemWatch",""]]

#define BLUFOR_SPAWN_MARKER "sys_marker_blufor_spawn"
#define BLUFOR_LOADOUT [["CUP_arifle_M16A2","","","",["CUP_30Rnd_556x45_Stanag_Tracer_Red",30],[],""],[],["ACE_Flashlight_Maglite_ML300L","","","",[],[],""],["CUP_U_B_BDUv2_M81_US",[["ACE_fieldDressing",20],["ACE_epinephrine",3],["ACE_morphine",3],["ACE_tourniquet",2],["ACRE_PRC343",1],["ACE_EarPlugs",1]]],["CUP_V_B_ALICE",[["CUP_30Rnd_556x45_Stanag_Tracer_Red",6,30],["ACE_HandFlare_White",4,1],["ACE_HandFlare_Red",1,1],["ACE_HandFlare_Green",1,1]]],[],"CUP_H_US_patrol_cap_WDL","",[],["ItemMap","","","ItemCompass","ItemWatch",""]]

#define REDFOR_COUNT 6

#define OPFOR_DIED 0