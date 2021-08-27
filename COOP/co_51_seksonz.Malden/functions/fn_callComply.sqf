#include "script_component.hpp"
/*
 * Author: Krystol, 3Mydlo3
 * Does something important
 *
 * Example:
 * call afp_scripts_fnc_callComply
 *
 * Public: No
 */

GVAR(complienceCall) = player addaction ["Wezwij do poddania się" ,{

    player removeAction GVAR(complienceCall);

    private _nearestCivilians = allUnits select {
        alive _x
        && {side _x isEqualTo CIVILIAN 
        && {vehicle _x distance player <= 75
        && {[position player, getDir player, 70, position vehicle _x] call BIS_fnc_inAngleSector}
        }}
    };

    /*_plr = str player;
    _voice = "";

    if (_plr in ldrs) then {_voice = (format ["1_callcomply_%1", (selectrandom [1,2,3,4,5,6])]);};
    if (_plr in ops1) then {_voice = (format ["2_callcomply_%1", (selectrandom [1,2,3,4])]);};
    if (_plr in ops2 || _plr in ops5) then {_voice = (format ["3_callcomply_%1", (selectrandom [1,2,3,4,5])]);};
    if (_plr in ops3 || _plr in ops6) then {_voice = (format ["4_callcomply_%1", (selectrandom [1,2,3,4])]);};
    if (_plr in ops4 || _plr in ops7) then {_voice = (format ["5_callcomply_%1", (selectrandom [1,2,3,4])]);};

    [player, _voice] remoteExec ["say3D"];*/

    {
        [_x, player] remoteExecCall [QFUNC(botSurrender), _x];
    } foreach _nearestCivilians;

    [{
        GVAR(complienceCall) = nil;
        [player] call FUNC(callComply);
    }, [], 1.25] call CBA_fnc_waitAndExecute;

}, nil, 0, true, true, "", "true", -1, false];

player setUserActionText [GVAR(complienceCall), "<t color='#ffff00'>Wezwij do poddania się</t>","<img size='2' image='\a3\ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa'/>"];
