
// call compileScript ["MDL\initFunctions.sqf"];

#define QUOTE(VAR) #VAR
#define DFUNC(VAR) VAR = compileScript ['MDL\fnc\VAR.sqf']

MDL_fncsInitialized = false;

#include "config.sqf";

if (isNil "MDL_PVP_configured") then {
    MDL_PVP_preset = createHashMap;
    MDL_PVP_tickets = 500;
	MDL_PVP_catapult = true;

	MDL_PVP_configured = false;
};

DFUNC(MDL_PvPJets_fnc_getAdmin);
DFUNC(MDL_PvPJets_fnc_initGameMode);
DFUNC(MDL_PvPJets_fnc_configureDialog);

DFUNC(MDL_PvPJets_fnc_launchPlane);
DFUNC(MDL_PVPJets_fnc_spawnPlane);
DFUNC(MDL_PvPJets_fnc_onPlaneKilled);
DFUNC(MDL_PvPJets_fnc_onPlaneGetOut);

DFUNC(MDL_PVPJets_fnc_onStartRequest);

MDL_fncsInitialized = true;
