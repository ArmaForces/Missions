#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * 
 *
 * Example:
 * call afsg_patrol_fnc_initializeRedforSpawn
 *
 * Public: No
 */

private _spawnPosition = getMarkerPos REDFOR_SPAWN_MARKER;

// Create flag teleport as in SK
private _flag = "Flag_Red_F" createVehicle _spawnPosition;

GVAR(startPositions) = [];

private _i = 1;
private _markerName = format ["sys_marker_redfor_start_%1", _i];
while {!(getMarkerPos _markerName isEqualTo [0, 0, 0])} do {
    _markerName setMarkerText str _i;
    GVAR(startPositions) pushBack _markerName;
    _i = _i + 1;
    _markerName = format ["sys_marker_redfor_start_%1", _i];
};

publicVariable QGVAR(startPositions);

[QGVAR(createTeleport), [_flag]] call CBA_fnc_globalEventJIP;

// Create and fill equipment box
private _weaponsBox = "CUP_RUBasicWeaponsBox" createVehicle _spawnPosition;
clearItemCargoGlobal _weaponsBox;
clearWeaponCargoGlobal _weaponsBox;
clearMagazineCargoGlobal _weaponsBox;
clearBackpackCargoGlobal _weaponsBox;

_weaponsBox addItemCargoGlobal ["DemoCharge_Remote_Mag", 3];
_weaponsBox addItemCargoGlobal ["ACE_Clacker", 1];
_weaponsBox addItemCargoGlobal ["MineDetector", 1];
_weaponsBox addItemCargoGlobal ["ACE_wirecutter", 1];

GVAR(opforBox) = _weaponsBox;

