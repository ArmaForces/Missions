#include "script_component.hpp"

{
    [_x, "cup_acc_zenit_2ds"] call FUNC(addAndForcePointer);
} forEach (allUnits select {side _x isEqualTo EAST});

{
    _x setFuel random 0.8 + 0.2;
} forEach vehicles;

// EQUIPMENT BOXES

private _pressBox = missionNamespace getVariable "press_box";

_pressBox addItemCargoGlobal ["XZ_CamRecorder_1", 1];
_pressBox addItemCargoGlobal ["XZ_CamRecorder_2", 1];
_pressBox addItemCargoGlobal ["Xnooz_AppareilPhoto", 1];
_pressBox addItemCargoGlobal ["Xnooz_micro1", 1];
_pressBox addItemCargoGlobal ["Xnooz_micro2", 1];

// MARKERS
// This was done in previous mission

// ["SouthendAreaSecured", {
    "marker_southend_area" setMarkerColorLocal "ColorWEST";
    "marker_southend_area" setMarkerBrush "FDiagonal";
// }] call CBA_fnc_addEventHandler;

// ["CampBrunericanBayDestroyed", {
    deleteMarker "marker_camp_brunerican_bay";
// }] call CBA_fnc_addEventHandler;

// Not done

["VillaAreaSecured", {
    "marker_villa_area" setMarkerColorLocal "ColorWEST";
    "marker_villa_area" setMarkerBrush "FDiagonal";
}] call CBA_fnc_addEventHandler;

["RadarTorrMorHacked", {
    "marker_radar_torr_mor" setMarkerColor "ColorWEST";
    "marker_radar_torr_mor" setMarkerType "b_installation";
}] call CBA_fnc_addEventHandler;

["RadarGlenKerranHacked", {
    "marker_radar_glen_kerran" setMarkerColor "ColorWEST";
    "marker_radar_glen_kerran" setMarkerType "b_installation";
}] call CBA_fnc_addEventHandler;
