#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * 
 *
 * Example:
 * call afsg_patrol_fnc_initializeBluforSpawn
 *
 * Public: No
 */

private _spawnPosition = getMarkerPos BLUFOR_SPAWN_MARKER;

// Create flag teleport as in SK
private _flag = "Flag_Red_F" createVehicle _spawnPosition;

[QGVAR(createActions), [_flag]] call CBA_fnc_globalEventJIP;

// Create and fill equipment box
private _weaponsBox = "CUP_USBasicWeaponsBox" createVehicle _spawnPosition;
clearItemCargoGlobal _weaponsBox;
clearWeaponCargoGlobal _weaponsBox;
clearMagazineCargoGlobal _weaponsBox;
clearBackpackCargoGlobal _weaponsBox;

_weaponsBox addItemCargoGlobal ["CUP_arifle_M16A2_GL", 4];
_weaponsBox addItemCargoGlobal ["UGL_FlareWhite_F", 8];
_weaponsBox addItemCargoGlobal ["UGL_FlareRed_F", 8];
_weaponsBox addItemCargoGlobal ["UGL_FlareGreen_F", 8];
_weaponsBox addItemCargoGlobal ["UGL_FlareYellow_F", 8];

GVAR(bluforBox) = _weaponsBox;
