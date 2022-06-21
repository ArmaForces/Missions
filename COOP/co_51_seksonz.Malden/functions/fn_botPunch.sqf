#include "script_component.hpp"
/*
 * Author: Krystol, 3Mydlo3
 * Does something important
 *
 * Arguments:
 * 0: Unit to be punched <OBJECT>
 *
 * Example:
 * call afp_scripts_fnc_botPunch
 *
 * Public: No
 */

params ["_unit"];

_unit setVariable [QGVAR(hasActionPunch), 1, true];

// TODO: Refactor whole

if (_unit getVariable [QGVAR(surrenderInProgress), false]
|| {_unit getVariable [QGVAR(surrenderDone), false]
|| {!alive _unit 
|| {isPlayer _unit 
|| {_unit getVariable ["ace_captives_isHandcuffed", false]}}}}) exitWith {};

private _fnc_shit = {

    private _unit = _this;
    private _punch = _unit addaction ["Zmuś do poddania się (uderz)", {
        params ["_unit", "_caller", "_actionId", "_arguments"];

        _voice = "";
        _voice = (format ["punch%1", (selectrandom [1,2,3])]);

        [_unit,_actionId] remoteExec [ "removeAction", 0, false ];

            if (currentWeapon _caller == primaryWeapon _caller) then {
                _caller playAction "gesturePoint";
                [_caller, _voice] remoteExec ["say3D"];
            };

        if (currentWeapon _caller == handgunWeapon _caller) then {
            [_caller] spawn {_caller = _this select 0};
            [_caller, "Acts_Executioner_Forehand"] remoteExec ["switchmove", 0];

            sleep 0.5;

            [_caller, _voice] remoteExec ["say3D"];

            sleep 1;

            [_caller, "Acts_Executioner_ToPistol"] remoteExec ["switchmove", 0]
        };

        _unit playAction "PlayerCrouch";
        [_unit, ["courage", ((_unit skill "courage") - 0.5)]] remoteExec ["setskill", 2];
        _unit setVariable [QGVAR(hasActionPunch), nil, true];
    }, nil, 9999, true, true, "", "true", 3, false];
_unit setUserActionText [_punch , "Zmuś do poddania się (uderz)", "<img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\letters\Z_ca'/>"];
};

[_unit] remoteExecCall []

// TODO: Finish removePrimaryWeaponItem