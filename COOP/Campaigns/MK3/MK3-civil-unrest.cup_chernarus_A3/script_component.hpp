#define PREFIX MKR
#define COMPONENT Scripts

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

// MK:R stuff
#define VEHICLE_LOCKED_CHANCE 0.7
#define VEHICLE_ALARM_CHANCE 0.5

#define CB_RADIO_MODEL "ACRE_PRC117F"
#define MILITIA_CB_PRESET "militiaCb"
#define CHDKZ_CB_PRESET "chedakiCb"
#define CIVILIAN_CB_PRESET "civilianCb"

#include "\x\cba\addons\main\script_macros_mission.hpp"
