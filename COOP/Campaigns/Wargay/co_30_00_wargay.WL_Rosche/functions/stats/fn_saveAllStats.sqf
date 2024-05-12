
#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Saves all stats to profile namespace.
 * Runs on server only.
 *
 * Arguments:
 * 0: Player unit <OBJECT>
 *
 * Public: No
 */

if (GVAR(isTest) || {!isServer}) exitWith {};

saveProfileNamespace
