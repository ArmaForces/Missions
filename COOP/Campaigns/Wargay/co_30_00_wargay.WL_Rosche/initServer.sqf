#include "script_component.hpp"

GVAR(loadedPlayers) = [];
GVAR(allPlayersStats) = call FUNC(loadAllStats);
GVAR(musicQueue) = [];
GVAR(gameStarted) = false;

private _respawnMarker = createMarker ["respawn", getPosATL respawn];

call FUNC(visibilityCheckLoop);

["MDL_applyDamage", FUNC(applyDamage)] call CBA_fnc_addEventHandler;
["MDL_healDamage", FUNC(healDamage)] call CBA_fnc_addEventHandler;
["MDL_deployVehicle", FUNC(deployVehicle)] call CBA_fnc_addEventHandler;

addMissionEventHandler ["Ended", FUNC(saveAllStats)];
addMissionEventHandler ["MPEnded", FUNC(saveAllStats)];

["MDL_playerKilled", FUNC(playerKilled)] call CBA_fnc_addEventHandler;

["MDL_loadPlayerStats", FUNC(loadPlayerStats)] call CBA_fnc_addEventHandler;

["MDL_startGame", {
	if (GVAR(gameStarted)) exitWith {};
	
	private _allWargayTracks = ["WARGAME_EE_Preparation","WARGAME_EE_Campaign_Brief","WARGAME_EE_Tension","WARGAME_EE_The_Lost_Rites","WARGAME_RD_Keep_it_Cool","WARGAME_RD_Sweeping_Bass","WARGAME_RD_Cryptoplanets","WARGAME_RD_Mission_Omega","WARGAME_RD_The_Infiltrator","WARNO_Dark_City_Beats","WARNO_Lap_Time","WARNO_Mysteries","WARNO_Raging_Burn"];
	[(_allWargayTracks call BIS_fnc_arrayShuffle)] call FUNC(addToMusicQueue);
	
	GVAR(gameStarted) = true;
}] call CBA_fnc_addEventHandler;

// {
//     [_x] call FUNC(hideAllMarkersInLayer);
// } forEach [
//     "1-RuhanperaSecured",
//     "2-HietalaSecured",
//     "3-KaracostamSecured",
//     "4-CounterattackSuccessfull",
//     "5-CounterattackKaracostam",
//     "6-CounterattackHietala",
//     "7-LZMonkeLost"
// ];

// ["RuhanperaSecured", {
//     ["0-Starting markers"] call FUNC(deleteAllMarkersInLayer);
//     ["1-RuhanperaSecured"] call FUNC(showAllMarkersInLayer);
// }] call CBA_fnc_addEventHandler;

// ["HietalaSecured", {
//     ["1-RuhanperaSecured"] call FUNC(deleteAllMarkersInLayer);
//     ["2-HietalaSecured"] call FUNC(showAllMarkersInLayer);
// }] call CBA_fnc_addEventHandler;

// ["KaracostamSecured", {
//     ["2-HietalaSecured"] call FUNC(deleteAllMarkersInLayer);
//     ["3-KaracostamSecured"] call FUNC(showAllMarkersInLayer);
// }] call CBA_fnc_addEventHandler;

// ["CounterattackSuccessfull", {
//     ["3-KaracostamSecured"] call FUNC(deleteAllMarkersInLayer);
//     ["4-CounterattackSuccessfull"] call FUNC(showAllMarkersInLayer);

//     // Build Hietala fortifications
//     private _areaId = hietala_buildable_module getVariable ["afmf_buildables_area", ""];
//     ["afmf_buildables_deliverSupply", [_areaId]] call CBA_fnc_serverEvent;
// }] call CBA_fnc_addEventHandler;

// ["CounterattackKaracostam", {
//     ["4-CounterattackSuccessfull"] call FUNC(deleteAllMarkersInLayer);
//     ["5-CounterattackKaracostam"] call FUNC(showAllMarkersInLayer);
// }] call CBA_fnc_addEventHandler;

// ["CounterattackHietala", {
//     ["5-CounterattackKaracostam"] call FUNC(deleteAllMarkersInLayer);
//     ["6-CounterattackHietala"] call FUNC(showAllMarkersInLayer);
// }] call CBA_fnc_addEventHandler;

// ["LZMonkeLost", {
//     ["6-CounterattackHietala"] call FUNC(deleteAllMarkersInLayer);
//     ["7-LZMonkeLost"] call FUNC(showAllMarkersInLayer);
// }] call CBA_fnc_addEventHandler;

// ["BangingComplete", {
//     "Surrounded" call BIS_fnc_endMissionServer;
// }] call CBA_fnc_addEventHandler;
