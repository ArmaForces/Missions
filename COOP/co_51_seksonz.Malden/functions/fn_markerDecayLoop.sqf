#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Loop handles marker decay every 15 seconds.
 *
 * Arguments:
 * 0: Decaying marker <STRING>
 * 1: Decay amount <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["my_marker", 0.1] call afsk_common_fnc_markerDecayLoop
 *
 * Public: No
 */

params ["_marker", "_decayRate", ["_oldAlpha", 0]];

private _currentAlpha = markerAlpha _marker;

// Break loop if something increased alpha, 0 is default so cannot be equal
if (!(_oldAlpha isEqualTo _currentAlpha) && {!(_oldAlpha isEqualTo 0)}) exitWith {};

// If applying decay would result in negative alpha, just delete marker (disappeared)
if (_currentAlpha <= _decayRate) exitWith {deleteMarkerLocal _marker};

// Decrease alpha
_oldAlpha = _currentAlpha - _decayRate;
_marker setMarkerAlphaLocal _oldAlpha;

// Loop
[FUNC(markerDecayLoop), [_marker, _decayRate, _oldAlpha], 15] call CBA_fnc_waitAndExecute;