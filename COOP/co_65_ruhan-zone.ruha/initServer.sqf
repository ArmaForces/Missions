#include "script_component.hpp"

{
    [_x] call FUNC(hideAllMarkersInLayer);
} forEach [
    "1-RuhanperaSecured",
    "2-HietalaSecured",
    "3-KaracostamSecured",
    "4-CounterattackSuccessfull",
    "5-CounterattackKaracostam",
    "6-CounterattackHietala",
    "7-LZMonkeLost"
];

["RuhanperaSecured", {
    ["0-Starting markers"] call FUNC(deleteAllMarkersInLayer);
    ["1-RuhanperaSecured"] call FUNC(showAllMarkersInLayer);
}] call CBA_fnc_addEventHandler;

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
