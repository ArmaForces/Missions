#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Handles initialization of radar tablets
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_tablet"];

if (isServer) then {
	private _helper = createVehicle ["Sign_Sphere10cm_F", getPosATL _tablet, [], 0, "CAN_COLLIDE"];
	_helper hideObjectGlobal true;

	private _vectorUp = vectorUp _tablet;
	private _vectorDir = vectorDir _tablet;
	_tablet enableSimulationGlobal true;
	_tablet attachTo [_helper];
	_tablet setVectorDirAndUp [_vectorDir, _vectorUp];

	// _helper enableSimulation false;
};

private _downloadSize = 2; // In GB
private _downloadTime = 300 * _downloadSize; // In seconds
private _result = [_tablet, _downloadTime, _downloadSize] call afmf_task_download_fnc_setupSimple;
