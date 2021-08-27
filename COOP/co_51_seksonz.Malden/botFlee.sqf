params ["_unit", "_caller"];

if (isNil {_unit getVariable "surrenderDone"} or !isNil {_unit getVariable "fleeScript"} or !alive _unit or isPlayer _unit or (_unit getVariable ["ace_captives_isHandcuffed", false])) exitWith {};

_unit setVariable ["fleeScript", 1, true];

_wh = _unit getVariable "whObject";
_weapon = _unit getVariable "whWeapon";

_cannotFlee = 1;
_voice = "";

sleep 1;

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

        _unit setVariable ["fleeScript", nil, true];
        _unit setVariable ["surrenderDone", nil, true];

}
else {
        waitUntil { (_unit getVariable ["ace_captives_isHandcuffed", false]) or !alive _unit };
        _unit setVariable ["fleeScript", nil, true];
        _unit setVariable ["surrenderDone", nil, true];
};
