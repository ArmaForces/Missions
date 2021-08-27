params ["_unit", "_caller"];

if (!isNil {_unit getVariable "surrenderInProgress"} or !isNil {_unit getVariable "surrenderDone"} or !alive _unit or isPlayer _unit or (_unit getVariable ["ace_captives_isHandcuffed", false])) exitWith {};

if ([objNull, "VIEW"] checkVisibility [eyePos _unit, eyePos _caller] >= 0.9 && alive _unit && !isPlayer _unit) then {

    _unit setVariable ["surrenderInProgress", 1, true];

    _courage = (_unit skill "courage") - (random 0.1);
    [_unit, ["courage", _courage]] remoteExec ["setskill", 2];

    _voice = "";

    if (random _courage <= 0.1 && alive _unit) then {

        removeAllActions _unit;

        [_unit] joinSilent grpNull;

        if (side _unit == CIVILIAN) then {
            _voice = (format ["%1_civ_comply_%2", (selectrandom [1,2,3]), (selectrandom [1,2,3,4])]);
        }
        else {
            _voice = (format ["%1_comply_%2", (selectrandom [1,2,3,4]), (selectrandom [1,2,3,4])]);
        };

        _unit stop true;
        waitUntil { speed vehicle _unit == 0 };

        [_unit] orderGetIn false;
        waitUntil { isNull objectParent _unit };

        _whWeapon = "";
        _whObject = objNull;

        if !(currentWeapon _unit isEqualTo "") then {

            _whWeapon = currentWeapon _unit;
            _whObject = _unit call ace_hitreactions_fnc_throwWeapon;
            _unit setVariable ["whWeapon", _whWeapon, true];
            _unit setVariable ["whObject", _whObject, true];

            _unit removeWeaponGlobal _whWeapon;

            [_whObject, ["<t color='#ff0000'>Zabezpiecz broń</t>", { player playActionNow "PutDown"; _whObject = _this select 0; deleteVehicle _whObject; }, nil, 50, true, true, "", "true", 3]] remoteExec ["addAction", 0];
        };

        [_unit, _voice] remoteExec ["say3D"];
        ["ace_captives_setSurrendered", [_unit, true]] call CBA_fnc_globalEvent;

        _unit setVariable ["surrenderDone", 1, true];
        _unit setVariable ["surrenderInProgress", nil, true];

        if (isNil {_unit getVariable "fleeScript"}) then {
        [_unit, _caller] execVM "botFlee.sqf" };

    }
    else {

        _unit setVariable ["surrenderDone", nil, true];

        if (side _unit == CIVILIAN && alive _unit) then {
            _voice = (format ["%1_civ_nocomply_%2", (selectrandom [1,2,3]), (selectrandom [1,2,3,4])]);
        }
        else {
            _voice = (format ["%1_nocomply_%2", (selectrandom [1,2,3,4]), (selectrandom [1,2,3,4,5])]);
        };

        [_unit, _voice] remoteExec ["say3D"];

        _unit setVariable ["surrenderInProgress", nil, true];

        if (isnil {_unit getVariable "hasActionPunch"} && !isPlayer _unit) then {[_unit] execVM "botPunch.sqf";};
    };

    sleep 1;

    _unit reveal _caller;

};
