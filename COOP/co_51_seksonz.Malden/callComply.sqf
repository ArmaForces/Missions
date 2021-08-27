complienceCall = player addaction ["Wezwij do poddania się" ,{

    player removeAction complienceCall;

    _nearestUnits = nearestObjects [position player, ["Man","Car","Truck"], 75];
    _nearestCiv = [];
    _nearestRes = [];

    if (CIVILIAN countSide _nearestUnits > 0) then {
        {
            if (side _x == CIVILIAN AND ([position player, getDir player, 70, position _x] call BIS_fnc_inAngleSector)) then {
                {
                    _nearestCiv pushback _x;
                } forEach (crew _x);
            };
        } foreach _nearestUnits;
    };

    if (RESISTANCE countSide _nearestUnits > 0) then {
        {
            if (side _x == RESISTANCE AND ([position player, getDir player, 70, position _x] call BIS_fnc_inAngleSector)) then {
                {
                    _nearestRes pushback _x;
                } forEach (crew _x);
            };
        } foreach _nearestUnits;
    };

    _plr = str player;
    _voice = "";

    if (_plr in ldrs) then {_voice = (format ["1_callcomply_%1", (selectrandom [1,2,3,4,5,6])]);};
    if (_plr in ops1) then {_voice = (format ["2_callcomply_%1", (selectrandom [1,2,3,4])]);};
    if (_plr in ops2 || _plr in ops5) then {_voice = (format ["3_callcomply_%1", (selectrandom [1,2,3,4,5])]);};
    if (_plr in ops3 || _plr in ops6) then {_voice = (format ["4_callcomply_%1", (selectrandom [1,2,3,4])]);};
    if (_plr in ops4 || _plr in ops7) then {_voice = (format ["5_callcomply_%1", (selectrandom [1,2,3,4])]);};

    [player, _voice] remoteExec ["say3D"];

    { if alive _x then { [[_x, player], "botSurrender.sqf"] remoteExec ["execVM", 2]; } } foreach _nearestCiv;
    { if alive _x then { [[_x, player], "botSurrender.sqf"] remoteExec ["execVM", 2]; } } foreach _nearestRes;

    sleep 1.25;

    complienceCall = nil;
    [player] execVM "callComply.sqf";
    },
    nil,
    0,
    true,
    true,
    "",
    "true",
    -1,
    false
];

player setUserActionText [complienceCall, "<t color='#ffff00'>Wezwij do poddania się</t>","<img size='2' image='\a3\ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca.paa'/>"];
