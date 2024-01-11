
if (player getVariable ["MDL_PVP_Admin", false]) exitWith {
    player // return
};

allPlayers select {_x call BIS_fnc_admin > 0} param [0, allPlayers select 0] // return
