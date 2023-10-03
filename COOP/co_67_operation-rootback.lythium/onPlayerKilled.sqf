if (AF_ticketsPerPlayer) then {
    [player] remoteExecCall ["AF_fnc_playerTicketsUpdate", 2, false];
};
player setVariable ["AF_crashTeleport_Ready", nil, 2];
call AF_fnc_playerKilledSpectator;