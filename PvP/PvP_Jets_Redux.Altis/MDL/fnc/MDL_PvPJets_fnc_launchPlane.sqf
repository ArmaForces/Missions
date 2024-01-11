
params ["_spawner", "_player"];

private _plane = [_spawner, side group _player] call MDL_PVPJets_fnc_spawnPlane;
// _plane lock 2;

[{
    params ["_plane"];
    _plane getVariable ["MDL_PVPJets_Ready", true] // return
}, {
    params ["_plane", "_player"];

    [_player, _plane] remoteExec ["moveInDriver", _player];

    if (MDL_PVP_catapult) then {
        ["MDL_PVP_catapultPlane", [_plane, _player], _player] call CBA_fnc_targetEvent;
    };
}, [_plane, _player]] call CBA_fnc_waitUntilAndExecute;

_plane // return
