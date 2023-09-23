#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Handles showing fancy info text to player on startup
 *
 * Arguments:
 * None
 *
 * Return Value:
 * True if no duplicated plates <BOOL>
 *
 * Public: No
 */

private _playerName = name player;

private _sideName = switch (side player) do {
    case WEST: { "Milicja" };
    case EAST: { "" };
    case INDEPENDENT: { "Czarnoruski Ruch Oporu" };
    case CIVILIAN: { "Mieszkaniec Czarnorusi" };
    default { "JAK TO WIDZISZ TO MYDLARZ COŚ SPIERDOLIŁ" };
};

private _location = "";

// Check custom locations first
if (!isNil QGVAR(customLocations)) then {
    private _areasContainingPlayer = GVAR(customLocations) select {player inArea (_x select 1)};
    if (count _areasContainingPlayer isEqualTo 0) exitWith {};

    if (count _areasContainingPlayer isNotEqualTo 1) then {
        // TODO: Consider sorting by area size (smaller => more specific)[_areasContainingPlayer, [], {player distance _x}] call BIS_fnc_sortBy;
        [_areasContainingPlayer, [], {player distance (_x select 1 select 0)}] call BIS_fnc_sortBy;
    };

    _location = localize (_areasContainingPlayer select 0 select 0);
};

// If unsuccessful, try other ways
if (_location isEqualTo "") then {
    private _nearestLocation = [player] call FUNC(getNearestLocationWithAvailableName);
    _location = [_nearestLocation] call FUNC(getLocationName);
    // if (convoyGroup isEqualTo group player) then {
    //     _location = "Posterunek Milicji w Chernogorsku";
    // };
    // if (side player isEqualTo INDEPENDENT) then {
    //     _location = "W lesie na zachód od Zelenogorska";
    // };
    // if (banditsGroup isEqualTo group player) then {
    //     _location = "Areszt w Zelenogorsku";
    // };
    // if (player isEqualTo busDriver) then { _location = "Pętla w Lopatino"; };
    // if (player isEqualTo busTicketer) then { _location = "Przystanek w Vyborze"; };
};

private _roleDescription = roleDescription player;
private _monkeyIndex = _roleDescription find "@";
private _playerRole = if (_monkeyIndex isEqualTo -1) then {
    _roleDescription
} else {
    if (_monkeyIndex isEqualTo 0) then {
        // Localize name
        private _localizedRoleDescription = localize _roleDescription;
        // Check again for CBA lobby group name
        _monkeyIndex = _localizedRoleDescription find "@";
        if (_monkeyIndex isEqualTo -1) then {
            _localizedRoleDescription
        } else {
            _localizedRoleDescription select [0, _monkeyIndex];
        };
    } else {
        // Remove CBA lobby group name
        _roleDescription select [0, _monkeyIndex]
    };
};

if (_playerRole isEqualTo "") then {
    _playerRole = getText (configFile >> "CfgVehicles" >> typeOf player >> "displayName");
};

private _playerGroupName = groupid group player;

private _playerRankVanillaFunc = { rank player };
private _playerRankDuiFunc = { diwako_dui_nametags_RankNames get "default" get rank player };
private _playerRankFunc = {
    if (side player isNotEqualTo WEST) exitWith { "" }; // TODO: Consider how to do it better
    if (!isNil "diwako_dui_nametags_RankNames") then { call _playerRankDuiFunc } else { call _playerRankVanillaFunc };
};

private _prepareAndShowInfoText = {
    params ["_playerName", "_playerRole", "_playerGroupName", "_sideName", "_location", "_playerRankFunc"];

    private _playerRank = call _playerRankFunc;
    private _rankAndName = if (_playerRank isEqualTo "") then {
        _playerName
    } else {
        format ["%1 %2", _playerRank, _playerName]
    };

    [
        LLSTRING(Mission_Title),
        {format ["%1 %2", LLSTRING(Date), [daytime, "HH:MM:SS"] call BIS_fnc_timeToString]},
        _rankAndName,
        format ["%1 - %2", _playerGroupName, _playerRole],
        _sideName, // TODO: Change this to apropriate unit based on player side/unit
        _location // TODO: Change this to apropriate location
    ] spawn FUNC(infoText);
};

[{!isNil "diwako_dui_nametags_RankNames"},
    _prepareAndShowInfoText,
    [_playerName, _playerRole, _playerGroupName, _sideName, _location, _playerRankFunc],
    4,
    _prepareAndShowInfoText
] call CBA_fnc_waitUntilAndExecute;
