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
private _isMilitiaPlayer = [_unit] call FUNC(isMilitia);
if (_isMilitiaPlayer || GVAR(isZeus)) then {
    call FUNC(createMilitiaRecord);
    call FUNC(createVehiclesRecord);
};
