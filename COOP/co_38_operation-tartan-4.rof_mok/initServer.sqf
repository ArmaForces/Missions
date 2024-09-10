#include "script_component.hpp"

{
    [_x, "cup_acc_zenit_2ds"] call FUNC(addAndForcePointer);
} forEach (allUnits select {side _x isEqualTo EAST});

{
    _x setFuel random 0.8 + 0.2;
} forEach vehicles;

// EQUIPMENT BOXES

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

["RadarMachariochBayHacked", {
    "marker_radar_macharioch_bay" setMarkerColor "ColorWEST";
    "marker_radar_macharioch_bay" setMarkerType "b_installation";

    private _radarPosition = getPosATL radar_macharioch_bay;
    deleteVehicle radar_macharioch_bay;
    private _newRadar = createVehicle ["B_Radar_System_01_F", [0, 0, 0], [], 0, "NONE"];
    createVehicleCrew _newRadar;
    _newRadar setVehicleRadar 1;
    _newRadar hideObjectGlobal true;
    _newRadar setPosATL _radarPosition;
    radar_macharioch_bay = _newRadar;
}] call CBA_fnc_addEventHandler;

["RadarTorrMorHacked", {
    "marker_radar_torr_mor" setMarkerColor "ColorWEST";
    "marker_radar_torr_mor" setMarkerType "b_installation";

    private _radarPosition = getPosATL radar_torr_mor;
    deleteVehicle radar_torr_mor;
    private _newRadar = createVehicle ["B_Radar_System_01_F", [0, 0, 0], [], 0, "NONE"];
    createVehicleCrew _newRadar;
    _newRadar setVehicleRadar 1;
    _newRadar hideObjectGlobal true;
    _newRadar setPosATL _radarPosition;
    radar_torr_mor = _newRadar;
}] call CBA_fnc_addEventHandler;

["RadarGlenKerranHacked", {
    "marker_radar_glen_kerran" setMarkerColor "ColorWEST";
    "marker_radar_glen_kerran" setMarkerType "b_installation";

    private _radarPosition = getPosATL radar_glen_kerran;
    deleteVehicle radar_glen_kerran;
    private _newRadar = createVehicle ["B_Radar_System_01_F", [0, 0, 0], [], 0, "NONE"];
    createVehicleCrew _newRadar;
    _newRadar setVehicleRadar 1;
    _newRadar hideObjectGlobal true;
    _newRadar setPosATL _radarPosition;
    radar_glen_kerran = _newRadar;
}] call CBA_fnc_addEventHandler;

["afmf_task_download_successful", {
    params ["_tablet"];

    if (_tablet isEqualTo tablet_macharioch_bay) exitWith {
        ["RadarMachariochBayHacked"] call CBA_fnc_serverEvent;
    };
    if (_tablet isEqualTo tablet_glen_kerran) exitWith {
        ["RadarGlenKerranHacked"] call CBA_fnc_serverEvent;
    };
    if (_tablet isEqualTo tablet_torr_mor) exitWith {
        ["RadarTorrMorHacked"] call CBA_fnc_serverEvent;
    };

}] call CBA_fnc_addEventHandler;