#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Plays next music from the queue.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

if (!isServer) exitWith {};

if (call FUNC(isMusicQueueEmpty) || FUNC(isMusicPlaying)) exitWith {};

private _nextTrack = GVAR(musicQueue) deleteAt 0;
_nextTrack remoteExec ["playMusic", 0];
