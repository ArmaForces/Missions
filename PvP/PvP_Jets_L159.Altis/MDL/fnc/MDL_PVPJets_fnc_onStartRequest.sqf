
params ["_player"];

if (!isNull (_player getVariable ["MDL_PVP_spawner", objNull])) exitWith {
    diag_log text format ["[PVP] ERROR: onStartRequest - player %1 already in queue", name _player];
};

private _spawner = missionNamespace getVariable format ["MDL_PVP_catapult%1", playerSide];
_player setVariable ["MDL_PVP_spawner", _spawner, true];

diag_log text format ["[PVP] INFO: onStartRequest - adding player %1 to queue for %2", name _player, _spawner];

private _queue = _spawner getVariable "MDL_PVP_queue";
if (isNil "_queue") then {
    _queue = [];
    _spawner setVariable ["MDL_PVP_queue", _queue];
};

_queue pushBack _player;

if (count _queue == 1) then {
    diag_log text format ["[PVP] INFO: onStartRequest - starting queue for %1", _spawner];

    private _fnc_queue = {
        params ["_fnc_queue", "_spawner", "_queue"];
        if (_queue isEqualTo []) exitWith {
            diag_log text format ["[PVP] INFO: onStartRequest - empty queue for %1", _spawner];
        };

        private _player = _queue deleteAt 0;

        private _plane = [_spawner, side group _player] call MDL_PVPJets_fnc_spawnPlane;
        _plane lock 2;
        [_player, _plane] remoteExec ["moveInDriver", _player];

        if (MDL_PVP_catapult) then {
            [_plane, _player] spawn {
                params ["_plane", "_player"];
                waitUntil {_player in _plane};
                [_plane] call BIS_fnc_AircraftCatapultLaunch;
            };
        };
        _player setVariable ["MDL_PVP_spawner", nil, true];

        // handle next queue element
        [_fnc_queue, _this, 5] call CBA_fnc_waitAndExecute;
    };

    [_fnc_queue, [_fnc_queue, _spawner, _queue], 1] call CBA_fnc_waitAndExecute;
};
