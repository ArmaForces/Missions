#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Adds given music to the queue.
 * Allows forcing to play it immediately.
 *
 * Arguments:
 * 0: Class(es) of the music to add <STRING/ARRAY<STRING>>
 * 1: Force playing now <BOOL> (Default: false)
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_music", ["_forceNow", false]];

if (!isServer) exitWith {};

if (_forceNow) exitWith {
	_music remoteExec ["playMusic", 0];
};

if (_music isEqualType "") then {
	GVAR(musicQueue) pushBack _music;
} else {
	GVAR(musicQueue) append _music;
};

[FUNC(playNextMusic)] call CBA_fnc_execNextFrame;
