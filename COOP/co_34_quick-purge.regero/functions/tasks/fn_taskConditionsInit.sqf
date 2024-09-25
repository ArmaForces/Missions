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
    !alive takistani_officer
}, "OfficerKilled"] call FUNC(taskConditionsAdd);

[{
    !alive factory_manager
}, "ManagerKilled"] call FUNC(taskConditionsAdd);

[{
    alive factory_manager && factory_manager getVariable ["ACE_isUnconscious", false]
}, "ManagerBeaten"] call FUNC(taskConditionsAdd);

[{
	dude getVariable ["ace_captives_isHandcuffed", false]
}, "DudeArrested"] call FUNC(taskConditionsAdd);

[{
	!alive dude
}, "DudeDeadge"] call FUNC(taskConditionsAdd);

// OLD

[] call FUNC(taskConditionsLoop);
