#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Initializes conditions for tasks
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

if (!isServer) exitWith { nil };

GVAR(conditionsWithEvents) = [];

[{
    !alive west_sam;
}, "WestSAMSiteDestroyed"] call FUNC(taskConditionsAdd);

[{
    !alive east_sam;
}, "EastSAMSiteDestroyed"] call FUNC(taskConditionsAdd);

// OLD

[nil] call FUNC(taskConditionsLoop);
