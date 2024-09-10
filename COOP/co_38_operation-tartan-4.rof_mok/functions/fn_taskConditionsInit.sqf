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
	!alive radar_macharioch_bay || {!alive tablet_macharioch_bay}
}, "RadarMachariochBayDestroyed"] call FUNC(taskConditionsAdd);

[{
	!alive radar_torr_mor || {!alive tablet_torr_mor}
}, "RadarTorrMorDestroyed"] call FUNC(taskConditionsAdd);

[{
	!alive radar_glen_kerran || {!alive tablet_glen_kerran}
}, "RadarGlenKerranDestroyed"] call FUNC(taskConditionsAdd);

// [{
//     !alive west_sam;
// }, "WestSAMSiteDestroyed"] call FUNC(taskConditionsAdd);

// [{
//     !alive east_sam;
// }, "EastSAMSiteDestroyed"] call FUNC(taskConditionsAdd);

// OLD

[] call FUNC(taskConditionsLoop);
