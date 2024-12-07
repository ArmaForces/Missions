isNil {
	ACRE_Loaded = !isNil "acre_main";

	call compileScript ["MDL\initFunctions.sqf"];
	call compileScript ["MDL\initRadios.sqf"];
	call compileScript ["MDN\initFunctions.sqf"];

	[] spawn MDL_PvPJets_fnc_initGameMode;
};
