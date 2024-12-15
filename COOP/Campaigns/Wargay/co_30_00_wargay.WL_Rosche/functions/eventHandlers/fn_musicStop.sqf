#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * 
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

addMusicEventHandler ["MusicStop", {
	[FUNC(playNextMusic), [], random 15] call CBA_fnc_waitAndExecute;
}];
