#include "..\script_component.hpp"
/*
 * Author: veteran29
 * Initializes Wargay-like HP HUD display in vehicle.
 *
 * Arguments:
 * 0: Vehicle HUD display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#define IDC_HITZONES 111

params ["_display"];

private _hitZonesCtrl = _display displayCtrl IDC_HITZONES;
// ignore HUDs without HitZones
if (isNull _hitZonesCtrl) exitWith {
    // systemChat "Unable to init custom HUD";
};

#ifdef DEV_DEBUG
systemChat "Initializing custom HUD";
#endif

// create container for hit points squares
private _ctrlContainer = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
_ctrlContainer ctrlSetPosition ctrlPosition _hitZonesCtrl;
_ctrlContainer ctrlCommit 0;
// hide original hitzones ctrl
_hitZonesCtrl ctrlShow false;

uiNamespace setVariable ["MDL_hitpointsContainer", _ctrlContainer];

/*
    cameraOn setVariable ["my_hitpoints", 2];
    [] call fnc_renderHitpoints;
 */
call FUNC(updateHitpointsDisplay);
