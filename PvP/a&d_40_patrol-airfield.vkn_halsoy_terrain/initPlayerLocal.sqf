#include "script_component.hpp"

// Disable CUP street lights based on lighting levels (bad performance script)
CUP_stopLampCheck = true;

[] spawn {
    while { alive player } do {
        waitUntil { getTerrainGrid > 25 };
        setTerrainGrid 25;
    };
};

GVAR(startPositionsMarkers) = [];
GVAR(playerInitialized) = false;

[QGVAR(playerInit), {
    params ["_side"];

    if (GVAR(playerInitialized)) exitWith {};
    GVAR(playerInitialized) = true;

    player addItem "ACE_EarPlugs";
    {player removeItem _x} forEach ([] call acre_api_fnc_getCurrentRadioList);
    if (_side isEqualTo WEST) then {
        // Do stuff for WEST if any
    } else {
        [player, EAST] call FUNC(changeSide);
        player setPos (getMarkerPos REDFOR_SPAWN_MARKER);
        player setUnitLoadout REDFOR_LOADOUT;
        private _otherOpforPlayers = (GVAR(playersOpfor) - [player]) apply {name _x};
        private _msg = format ["You have been assigned as OPFOR together with %1. Good luck!", _otherOpforPlayers joinString ", "];
        [QGVAR(showSystemMessage), [_msg]] call CBA_fnc_localEvent;
    };
    [QGVAR(showSystemMessage), ["Finished player initialization"]] call CBA_fnc_localEvent;
}] call CBA_fnc_addEventHandler;

[QGVAR(showSystemMessage), {
    params ["_message"];
    systemChat _message;
    INFO(_message);
}] call CBA_fnc_addEventHandler;

[QGVAR(createActions), {
    if !(side player isEqualTo WEST) exitWith {};
    _this call FUNC(createActions);
}] call CBA_fnc_addEventHandler;

[QGVAR(createTeleport), {
    if !(side player isEqualTo EAST) exitWith {};
    _this call FUNC(createTeleport);
}] call CBA_fnc_addEventHandler;

[QGVAR(assignedRole), {
    // First assign is used for any reconnected handling, it should be false then to prevent items duplication
    params ["_roleName", ["_firstAssign", true]];
    switch (_roleName) do {
        case "HQ": {
            player setRank "LIEUTENANT";
            player addAction ["<t color='#c8c8ff'>Zmień nazwy drużyn</t>", {call AF_fnc_groupRenameGUI}, nil, -10, false, true, "", "", 50];
            if (_firstAssign) then {
                player addItemToUniform "ACRE_PRC152";
                private _radioIndex = items player findIf {["PRC152", _x] call BIS_fnc_inString};
                if (_radioIndex isEqualTo -1) then {
                    // Put radio in box
                    GVAR(bluforBox) addItemCargoGlobal ["ACRE_PRC152", 1];
                    [QGVAR(showSystemMessage), ["Radio did not fit into your inventory. Check in weapons box."]] call CBA_fnc_localEvent;
                };
            };
        };
        case "Sapper": {
            player setRank "CORPORAL";
            player setUnitTrait ["engineer", true];
            player setVariable ["ACE_isEngineer", 2];
            player setUnitTrait ["explosiveSpecialist", true];
            player setVariable ["ACE_isEOD", true];
            if (_firstAssign) then {
                player addBackpack "CUP_B_AlicePack_OD";
                player addItemToBackpack "ToolKit";
                player addItem "ACE_DefusalKit";
                player addItem "MineDetector";
                player addItem "ACE_EntrenchingTool";
            };
        };
        case "Medic": {
            player setRank "CORPORAL";
            player setUnitTrait ["Medic", true];
            player setVariable ["ace_medical_medicClass", 2];
        };
        case "Patrol Leader": {
            player setRank "SERGEANT";
            private _group = createGroup WEST;
            [player] join _group;
            if (_firstAssign) then {
                player addItemToUniform "ACRE_PRC152";
                private _radioIndex = items player findIf {["PRC152", _x] call BIS_fnc_inString};
                if (_radioIndex isEqualTo -1) then {
                    // Put radio in box
                    GVAR(bluforBox) addItemCargoGlobal ["ACRE_PRC152", 1];
                    [QGVAR(showSystemMessage), ["Radio did not fit into your inventory. Check in weapons box."]] call CBA_fnc_localEvent;
                };
            };
        };
        default {
            player setRank "PRIVATE";
        };
    };
    [QGVAR(showSystemMessage), [format ["Successfully assigned %1 role", _roleName]]] call CBA_fnc_localEvent;
    [QGVAR(showSideChatMessage), [WEST, format ["Successfully assigned %1 as %2", name player, _roleName]]] call CBA_fnc_globalEvent;
}] call CBA_fnc_addEventHandler;

[QGVAR(showSideChatMessage), {
    params ["_side", "_msg"];
    if (!(_side isEqualTo side player)) exitWith {};
    [_side, "HQ"] sideChat _msg;
}] call CBA_fnc_addEventHandler;

[QGVAR(showSystemMessage), ["Player ready"]] call CBA_fnc_localEvent;
[QGVAR(playerConntected), [player, getPlayerUID player]] call CBA_fnc_serverEvent;
