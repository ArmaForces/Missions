#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Initializes briefings.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit"];

[_unit] call FUNC(createGeneralBriefing);

// Show militia records for militia players only
private _isCivilianPlayer = side player isEqualTo CIVILIAN;
private _isMilitiaPlayer = [_unit] call FUNC(isMilitia);
private _isOpforPlayer = side player isEqualTo WEST && {!_isMilitiaPlayer};
private _isResistancePlayer = [player] call FUNC(isResistance);

if (_isCivilianPlayer || GVAR(isZeus)) then {
    [_unit] call FUNC(createCivilianBriefing);
};

if (_isMilitiaPlayer || GVAR(isZeus)) then {
    [_unit] call FUNC(createMilitiaBriefing);
    [_unit] call FUNC(createMilitiaRecord);
    [_unit] call FUNC(createVehiclesRecord);
};

if (_isOpforPlayer || GVAR(isZeus)) then {
    [_unit] call FUNC(createOpforBriefing);
};

if (_isResistancePlayer || GVAR(isZeus)) then {
    [_unit] call FUNC(createResistanceBriefing);
};
