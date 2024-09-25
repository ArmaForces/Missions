#include "..\script_component.hpp"
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
	dude getVariable ["ace_captives_isHandcuffed", false]
}, "DudeArrested"] call FUNC(taskConditionsAdd);

[{
	!alive dude
}, "DudeDeadge"] call FUNC(taskConditionsAdd);

// OLD

[] call FUNC(taskConditionsLoop);
