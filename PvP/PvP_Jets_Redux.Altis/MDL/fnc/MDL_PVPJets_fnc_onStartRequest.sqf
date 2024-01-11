
params ["_player"];

if (!isNull (_player getVariable ["MDL_PVP_handlingSpawner", objNull]) && {!is3DENPreview}) exitWith {
    diag_log text format ["[PVP] ERROR: onStartRequest - player %1 already in queue", name _player];
};

private _spawner = missionNamespace getVariable format ["MDL_PVP_catapult%1", side group _player];
_player setVariable ["MDL_PVP_handlingSpawner", _spawner, true];

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

        //--- check if last spawned plane has pilot / moved from spawn
        private _lastPlane = _spawner getVariable ["MDL_PVP_spawnerLastPlane", objNull];
        if (crew _lastPlane isEqualTo []) then {
            diag_log text format ["[PVP] ERROR: onStartRequest - last spawned plane is empty %1", _spawner];
            deleteVehicle _lastPlane;
        };
        //-------------

        private _player = _queue deleteAt 0;
        ["MDL_PVP_startPosition", [_queue], _queue] call CBA_fnc_targetEvent;

        private _plane = [_spawner, _player] call MDL_PvPJets_fnc_launchPlane;

        _spawner setVariable ["MDL_PVP_spawnerLastPlane", _plane];
        _player setVariable ["MDL_PVP_handlingSpawner", nil, true];

        // handle next queue element
        [_fnc_queue, _this, 5] call CBA_fnc_waitAndExecute;
    };

    [_fnc_queue, [_fnc_queue, _spawner, _queue], 1] call CBA_fnc_waitAndExecute;
};
