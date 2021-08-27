#include "script_component.hpp"
/*
 * Author: Krystol, 3Mydlo3
 * Adds custom init EH for civilians for behaviour initialization.
 *
 * Example:
 * call afp_scripts_fnc_botComplyInit
 *
 * Public: No
 */

/* // For civilians handling with sound but useless for me
ldrs = ["atl", "btl", "ctl", "dtl", "rtl", "stl", "ttl", "ztl"];
ops1 = ["a1", "b1", "c1", "d1", "r1", "s1", "t1", "z1"];
ops2 = ["a2", "b2", "c2", "d2", "r2", "s2", "t2", "z2"];
ops3 = ["a3", "b3", "c3", "d3", "r3", "s3", "t3", "z3"];
ops4 = ["a4", "b4", "c4", "d4", "r4", "s4", "t4", "z4"];
ops5 = ["a5", "b5", "c5", "d5", "r5", "s5", "t5", "z5"];
ops6 = ["a6", "b6", "c6", "d6", "r6", "s6", "t6", "z6"];
ops7 = ["a7", "b7", "c7", "d7", "r7", "s7", "t7", "z7"];*/

if (hasInterface && {!isServer}) exitWith {};

["CAManBase", "init", {
    [{
        params ["_unit"];

        if (!local _unit) exitWith {};

        if (!isPlayer _unit && {side _unit isEqualTo CIVILIAN}) then {
            _unit addEventHandler ["Killed", {
                removeAllActions (_this select 0);
            }];
            _unit addEventHandler ["FiredNear", {
                params ["_unit"];
                private _courage = (_unit skill "courage") - 0.6;
                [_unit, ["courage", _courage]] remoteExec ["setskill", _unit];
                _unit removeEventHandler ["FiredNear", 0];
            }];
        };
    }, _this, 3] call CBA_fnc_waitAndExecute;
},
true, // allow inheritance
[],  // excluded clases
true // retroactive
] call CBA_fnc_addClassEventHandler;