isNil {
	ACRE_Loaded = !isNil "acre_main";

	#include "MDL\initFunctions.sqf";
	#include "MDL\initRadios.sqf";
	[] execVM "MDN\initFunctions.sqf";

	[] spawn MDL_PvPJets_fnc_initGameMode;
};
