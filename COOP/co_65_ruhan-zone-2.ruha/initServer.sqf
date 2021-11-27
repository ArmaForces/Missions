#include "script_component.hpp"

// Disable AF Friendly Tracker
["CBA_settingsInitialized", {
    [QAFFTGVAR(enabled), false, 0, "server"] call CBA_settings_fnc_set;
}] call CBA_fnc_addEventHandler;

{
    [_x] call FUNC(hideAllMarkersInLayer);
} forEach [
    "1-ConstructionSiteEmpty",
    "2-RuhaCounterattackSuccess"
];

["EnableFriendlyTracker", {
    [QAFFTGVAR(enabled), true, 0, "server"] call CBA_settings_fnc_set;
}] call CBA_fnc_addEventHandler;

["BravoDead", {
    ["ReachedConstructionSite"] call CBA_fnc_localEvent;
}] call CBA_fnc_addEventHandler;

["ReachedConstructionSite", {
    ["0-Starting markers"] call FUNC(deleteAllMarkersInLayer);
    ["1-ConstructionSiteEmpty"] call FUNC(showAllMarkersInLayer);
}] call CBA_fnc_addEventHandler;

["EstablishedBridgeheadInNorthernRuha", {
    ["1-ConstructionSiteEmpty"] call FUNC(deleteAllMarkersInLayer);
    ["2-RuhaCounterattackSuccess"] call FUNC(showAllMarkersInLayer);
}] call CBA_fnc_addEventHandler;


// FROM PREVIOUS MISSION BELOW

["HietalaSecured", {
    ["1-RuhanperaSecured"] call FUNC(deleteAllMarkersInLayer);
    ["2-HietalaSecured"] call FUNC(showAllMarkersInLayer);
}] call CBA_fnc_addEventHandler;

["KaracostamSecured", {
    ["2-HietalaSecured"] call FUNC(deleteAllMarkersInLayer);
    ["3-KaracostamSecured"] call FUNC(showAllMarkersInLayer);
}] call CBA_fnc_addEventHandler;

["CounterattackSuccessfull", {
    ["3-KaracostamSecured"] call FUNC(deleteAllMarkersInLayer);
    ["4-CounterattackSuccessfull"] call FUNC(showAllMarkersInLayer);

    // Build Hietala fortifications
    private _areaId = hietala_buildable_module getVariable ["afmf_buildables_area", ""];
    ["afmf_buildables_deliverSupply", [_areaId]] call CBA_fnc_serverEvent;
}] call CBA_fnc_addEventHandler;

["CounterattackKaracostam", {
    ["4-CounterattackSuccessfull"] call FUNC(deleteAllMarkersInLayer);
    ["5-CounterattackKaracostam"] call FUNC(showAllMarkersInLayer);
}] call CBA_fnc_addEventHandler;

["CounterattackHietala", {
    ["5-CounterattackKaracostam"] call FUNC(deleteAllMarkersInLayer);
    ["6-CounterattackHietala"] call FUNC(showAllMarkersInLayer);
}] call CBA_fnc_addEventHandler;

["LZMonkeLost", {
    ["6-CounterattackHietala"] call FUNC(deleteAllMarkersInLayer);
    ["7-LZMonkeLost"] call FUNC(showAllMarkersInLayer);
}] call CBA_fnc_addEventHandler;

["BangingComplete", {
    "Surrounded" call BIS_fnc_endMissionServer;
}] call CBA_fnc_addEventHandler;
