#include "script_component.hpp"

if (!isNil QUOTE(RESPAWN_HELPER_VR)) then {
    createMarker ["respawn", position RESPAWN_HELPER_VR];
};

// Teams randomization
GVAR(playersPresent) = playersNumber WEST;
diag_log format ["Players present var %1", GVAR(playersPresent)];
diag_log format ["Players present val %1", playersNumber WEST];
GVAR(serverInitialized) = false;
GVAR(playersConnected) = [];
GVAR(playersOpfor) = [];
GVAR(roles) = call CBA_fnc_createNamespace;
GVAR(availableRoles) = [
    ["HQ", 4],
    ["Medic", 2],
    ["Sapper", 2],
    ["Patrol Leader", 4]
];
publicVariable QGVAR(availableRoles);

// Cities
GVAR(cities) = call FUNC(getAllMapCities);
GVAR(citiesCount) = count GVAR(cities);
GVAR(licensePlates) = call CBA_fnc_createNamespace;

private _civilianVehicles = vehicles select {
    _x isKindOf "AllVehicles"
    && {getNumber (configFile >> "CfgVehicles" >> typeOf _x >> "side") isEqualTo 3}
};

// Randomize plates for all civilian vehicles
if (GVAR(citiesCount) > 0) then {
    {
        [_x] call FUNC(randomizePlates);
    } forEach _civilianVehicles;
};

if (isDedicated) then {
    [QGVAR(showSystemMessage), {
        params ["_message"];
        INFO(_message);
    }] call CBA_fnc_addEventHandler;
};

[QGVAR(assignRole), {
    params ["_unit", "_roleName"];
    private _rolePlayersUIDs = GVAR(roles) getVariable [_roleName, []];
    // If unit has role assigned, just ignore unit
    private _unitRole = _unit getVariable [QGVAR(role), ""];
    if (!(_unitRole isEqualTo "")) exitWith {
        private _msg = format ["You already have %1 role assigned!", _unitRole];
        [QGVAR(showSystemMessage), [_msg], _unit] call CBA_fnc_targetEvent;
    };
    // Reassign the same role for player
    if (getPlayerUID _unit in _rolePlayersUIDs) exitWith {
        _unit setVariable [QGVAR(role), _roleName];
        [QGVAR(assignedRole), [_roleName, false], _unit] call CBA_fnc_targetEvent;
    };
    // Assign new role for player
    private _roleIndex = GVAR(availableRoles) findIf {(_x select 0) isEqualTo _roleName};
    if (_roleIndex isEqualTo -1) exitWith {
        private _msg = format ["Error finding role %1!", _roleName];
        [QGVAR(showSystemMessage), [_msg], _unit] call CBA_fnc_targetEvent;
    };
    private _maxPlayers = GVAR(availableRoles) select _roleIndex select 1;
    if (count _rolePlayersUIDs >= _maxPlayers) exitWith {
        private _msg = format ["Players limit reached for %1 role!", _roleName];
        [QGVAR(showSystemMessage), [_msg], _unit] call CBA_fnc_targetEvent;
    };
    _rolePlayersUIDs pushBack getPlayerUID _unit;
    _unit setVariable [QGVAR(role), _roleName];
    [QGVAR(assignedRole), [_roleName], _unit] call CBA_fnc_targetEvent;
}] call CBA_fnc_addEventHandler;

[QGVAR(teleport), {
    params ["_caller", "_destination"];
    if (_destination isEqualType objNull) then {
        _destination = position _destination;
    };
    _caller setPos _destination;
}] call CBA_fnc_addEventHandler;

[QGVAR(playerConntected), {
    params ["_unit", "_uid"];
    GVAR(playersConnected) pushBackUnique [_uid, _unit];

    private _msg = format ["Players ready %1/%2", count GVAR(playersConnected), playersNumber WEST];
    //private _msg = format ["Players ready %1/%2", count GVAR(playersConnected), 1];
    if (!GVAR(serverInitialized)) then {
        [QGVAR(showSystemMessage), [_msg]] call CBA_fnc_globalEvent;
    };
    if (count GVAR(playersConnected) isEqualTo playersNumber WEST && {!GVAR(serverInitialized)}) then {
        private _msg = format ["Starting initialization with %1/%2 players ready.", count GVAR(playersConnected), playersNumber WEST];
        [QGVAR(showSystemMessage), [_msg]] call CBA_fnc_globalEvent;
        [QGVAR(serverInit)] call CBA_fnc_localEvent;
    } else {
        if (GVAR(serverInitialized)) then {
            private _side = if (_uid in GVAR(playersOpfor)) then {EAST} else {WEST};
            [QGVAR(playerInit), [_side], _unit] call CBA_fnc_targetEvent;
        };
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(initializeTeams), {
    GVAR(playersOpfor) = [REDFOR_COUNT, EAST] call FUNC(randomizeTeams);
    publicVariable QGVAR(playersOpfor);

    [QGVAR(playerInit), [EAST], GVAR(playersOpfor)] call CBA_fnc_targetEvent;
    [QGVAR(playerInit), [WEST], allPlayers - GVAR(playersOpfor)] call CBA_fnc_targetEvent;
}] call CBA_fnc_addEventHandler;

[QGVAR(serverInit), {
    if (GVAR(serverInitialized)) exitWith {};
    [QGVAR(showSystemMessage), ["Starting server initialization"]] call CBA_fnc_localEvent;
    GVAR(serverInitialized) = true; // Prevent next initialization

    [QGVAR(initializeTeams)] call CBA_fnc_localEvent;
    [QGVAR(showSystemMessage), ["Teams initialized"]] call CBA_fnc_localEvent;
    call FUNC(initializeBluforSpawn);
    call FUNC(initializeRedforSpawn);
    [QGVAR(showSystemMessage), ["Spawns initialized"]] call CBA_fnc_localEvent;
    // Wait until all opfor players change their side and show them tasks
    [{count (allPlayers select {side _x isEqualTo EAST}) isEqualTo count GVAR(playersOpfor)}, {
        [QGVAR(showSystemMessage), ["Publishing OPFOR tasks"]] call CBA_fnc_localEvent;
        [QGVAR(showOpforTasks)] call CBA_fnc_localEvent;
    }] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_addEventHandler;

// Force initialization when game starts
[{
    if (GVAR(serverInitialized)) exitWith {};
    [QGVAR(showSystemMessage), ["Forcing initialization"]] call CBA_fnc_localEvent;
    [QGVAR(serverInit)] call CBA_fnc_localEvent;
}, [], 1] call CBA_fnc_waitAndExecute;

["ace_wireCuttingStarted", {
    params ["_unit", "_fence"];
    // 12 s timeout because 11 s is default wirecutting duration
    [{!alive _this}, {deleteVehicle _this}, _fence, 12] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_addEventHandler;