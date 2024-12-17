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

private _playerRankFunc = {
    private _playerRankVanillaFunc = { rank player };
    private _playerRankDuiFunc = { diwako_dui_nametags_RankNames get "default" get rank player };

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

private _sideName = LLSTRING(USArmyInfantry);
private _location = LLSTRING(CurrentLocation);

[{!isNil "diwako_dui_nametags_RankNames"},
    _prepareAndShowInfoText,
    [_playerName, _playerRole, _playerGroupName, _sideName, _location, _playerRankFunc],
    4,
    _prepareAndShowInfoText
] call CBA_fnc_waitUntilAndExecute;
