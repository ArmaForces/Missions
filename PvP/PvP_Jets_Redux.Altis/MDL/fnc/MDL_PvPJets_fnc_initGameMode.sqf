waitUntil {
    !hasInterface || (
        (getClientState == "BRIEFING READ" || !isMultiplayer) &&
        {!isNull findDisplay 46} &&
        {!visibleMap}
    )
};

diag_log text "[PVP] INFO: initGameMode";

[] call MDL_PvPJets_fnc_configureDialog;

waitUntil {MDL_PVP_configured};

"MDL_PVP_Wait" cutText ["", "BLACK IN"];
(uiNamespace getVariable ["MDL_PVP_ConfigureDialog", displayNull]) closeDisplay 0;

diag_log text format ["[PVP] INFO: initGameMode - preset %1", MDL_PVP_preset get "displayName"];
diag_log text format ["[PVP] INFO: initGameMode - tickets %1", MDL_PVP_tickets];

if (isServer) then {
    // adjust tickets
    {
        [_x, (MDL_PVP_tickets - ([_x] call BIS_fnc_respawnTickets))] call BIS_fnc_respawnTickets;
    } forEach [WEST, EAST];

    ["MDL_PVP_startRequest", {call MDL_PVPJets_fnc_onStartRequest}] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    [[
        localize "STR_AFSG_PvPJets_ActionStart",
        {
            ["MDL_PVP_startRequest", player] call CBA_fnc_serverEvent;

            [[localize "STR_LOAD_INTRO", 1.5], true] call CBA_fnc_notify;
        },
        nil,
        1e10,
        true,
        true,
        "",
        "_originalTarget in _this"
    ]] call CBA_fnc_addPlayerAction;

    ["MDL_PVP_startPosition", {
        params ["_queue"];

        [
            [format [localize "STR_AFSG_PvPJets_NotificationQueuePosition", (_queue find player) + 1], 1.5],
            true
        ] call CBA_fnc_notify;

    }] call CBA_fnc_addEventHandler;

    ["MDL_PVP_catapultPlane", {
        _this spawn {
            params ["_plane", "_player"];
            waitUntil {_player in _plane};
            sleep 1;
            [_plane] call BIS_fnc_aircraftCatapultLaunch;
        };
    }] call CBA_fnc_addEventHandler;
};
