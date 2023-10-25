#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Adds player to custom channels.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

if (!hasInterface) exitWith {};

[{!isNil QGVAR(emergencyNetId) && {alive player}}, {
    GVAR(emergencyNetId) radioChannelAdd [player];
    player customChat [GVAR(emergencyNetId), "Successfully initialized emergency net chat"];
}] call CBA_fnc_waitUntilAndExecute;

[{!isNil QGVAR(zeusNetId) && {alive player}}, {
    GVAR(zeusNetId) radioChannelAdd [player];
    player customChat [GVAR(zeusNetId), "Successfully initialized Zeus chat"];
}] call CBA_fnc_waitUntilAndExecute;

// Disable writing and speaking on custom channels
6 enableChannel false;
7 enableChannel false;
8 enableChannel false;
9 enableChannel false;
10 enableChannel false;
11 enableChannel false;
12 enableChannel false;
13 enableChannel false;
14 enableChannel false;
15 enableChannel false;
