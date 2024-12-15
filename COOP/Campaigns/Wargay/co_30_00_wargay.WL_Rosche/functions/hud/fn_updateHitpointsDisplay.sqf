#include "..\script_component.hpp"
/*
 * Author: veteran29
 * Updates Wargay-like HP HUD display.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

private _ctrlContainer = uiNamespace getVariable ["MDL_hitpointsContainer", controlNull];
if (isNull _ctrlContainer) exitWith {};

private _display = ctrlParent _ctrlContainer;


{ctrlDelete _x} forEach (_ctrlContainer getVariable ["MDL_hitpointsContainer_indicators", []]);

private _totalHitPoints = vehicle cameraOn getVariable ["MDL_maxHp", MAX_HP];
private _exactHitPoints = vehicle cameraOn getVariable ["MDL_currentHp", MAX_HP];
private _hitPoints = ceil _exactHitPoints;
// calculate size of the hitzone squares
ctrlPosition _ctrlContainer params ["", "", "_w"];
private _hpW = _w / _totalHitPoints;
private _gutterW = _hpW / 4;

// render hitpoint squares
private _indicators = [];
for "_i" from 0 to (_totalHitPoints-1) do {
    private _hpCtrl = _display ctrlCreate ["RscText", -1, _ctrlContainer];
	_hpCtrl ctrlSetBackgroundColor ([
        GVAR(missingHpColor),
    	GVAR(filledHpColor)
    ] select (_i < _hitPoints));
        
	_hpCtrl ctrlSetPosition [
        _hpW * _i,
        pixelH * 4,
        _hpW - _gutterW,
    	_hpW
    ];
	_hpCtrl ctrlCommit 0;

    _indicators pushBack _hpCtrl;
};

if (_exactHitPoints isNotEqualTo _hitPoints) then {
    private _partialHpCtrl = _indicators select (_hitPoints - 1);
    _partialHpCtrl ctrlSetFade (_hitPoints - _exactHitPoints);
    _partialHpCtrl ctrlCommit 0;
};

_ctrlContainer setVariable ["MDL_hitpointsContainer_indicators", _indicators];