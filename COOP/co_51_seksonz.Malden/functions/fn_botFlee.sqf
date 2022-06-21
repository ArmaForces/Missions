#include "script_component.hpp"
/*
 * Author: Krystol, 3Mydlo3
 * Does something important
 *
 * Arguments:
 * 0: <OBJECT>
 * 1: <OBJECT>
 *
 * Example:
 * call afp_scripts_fnc_botFlee
 *
 * Public: No
 */

params ["_unit", "_caller"];

if (
    !(_unit getVariable [QGVAR(surrenderDone), false])
    || {_unit getVariable [QGVAR(fleeScript), false]
    || {!alive _unit 
    || {isPlayer _unit
    || {(_unit getVariable ["ace_captives_isHandcuffed", false])}}}
    }) exitWith {};

_unit setVariable [QGVAR(fleeScript), true, true];

private _wh = _unit getVariable QGVAR(whObject);
private _weapon = _unit getVariable QGVAR(whWeapon);

private _cannotFlee = 1;
private _voice = "";

[{
    // TODO: Refactor
    while { _cannotFlee == 1 && alive _unit } do {

        sleep 5;

        _nearestUnits = nearestObjects [position _unit, ["Man","Car","Truck"], 75];

        _nearestBlu = [];
        _nearestBluVis = [];

            if(WEST countSide _nearestUnits > 0) then {
                {
                    if (side _x == WEST) then {
                        {
                            _nearestBlu pushback _x;
                        } forEach (crew _x);
                    };
                } foreach _nearestUnits;
            };

        {
            if ([objNull, "VIEW"] checkVisibility [eyePos _unit, eyePos _x] >= 0.9 && alive _x) then {
                _nearestBluVis pushBack _x
            };
        } forEach _nearestBlu;

        if (count _nearestBluVis == 0) then {
            _cannotFlee = 0;
        };
    };

    if ( !(_unit getVariable ["ace_captives_isHandcuffed", false]) && alive _unit && _cannotFlee != 1) then {

            [_unit, ["courage", ((_unit skill "courage") + 0.5)]] remoteExec ["setskill", 2];

            ["ace_captives_setSurrendered", [_unit, false]] call CBA_fnc_globalEvent;

            if ( !isNil { _wh } ) then {
                if ( !isNull _wh && alive _wh ) then {
                    _unit action ["TakeWeapon", _wh, _weapon];
                };
            };

            sleep 1;

            if (side _unit != CIVILIAN) then {
                _voice = (format ["%1_nocomply_%2", (selectrandom [1,2,3,4]), (selectrandom [1,2,3,4,5])]);
            }
            else {
                _voice = (format ["%1_civ_nocomply_%2", (selectrandom [1,2,3]), (selectrandom [1,2,3,4])]);
            };

            [_unit, _voice] remoteExec ["say3D"];

            _unit stop false;
            [_unit] orderGetIn true;

            _unit setVariable [QGVAR(fleeScript), nil, true];
            _unit setVariable [QGVAR(surrenderDone), nil, true];

    } else {
        [{!alive (_this select 0) || {(_this select 0) getVariable ["ace_captives_isHandcuffed", false]}}, {
            (_this select 0) setVariable [QGVAR(fleeScript), nil, true];
            (_this select 0) setVariable [QGVAR(surrenderDone), nil, true];
        }, [_unit]] call CBA_fnc_waitUntilAndExecute;
    };
}, [], 1] call CBA_fnc_waitAndExecute;