
params ["_spawner", "_player"];

private _plane = [_spawner, side group _player] call MDL_PVPJets_fnc_spawnPlane;
_plane lock 2;
[_player, _plane] remoteExec ["moveInDriver", _player];

if (MDL_PVP_catapult) then {
    [_plane, _player] spawn {
        params ["_plane", "_player"];
        waitUntil {_player in _plane};
        [_plane] remoteExec ["BIS_fnc_aircraftCatapultLaunch", _plane];
    };
};

_plane // return
