#include "script_component.hpp"

// Disable CUP street lights based on lighting levels (bad performance script)
CUP_stopLampCheck = true;

[{alive player}, {
    // Dodanie akcji do zmiany odległości widzenia oraz nazw drużyn
    call FUNC(playerActions);
}, [], -1] call CBA_fnc_waitUntilAndExecute;

[{
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

    [{!isNil "diwako_dui_nametags_RankNames"}, {
        params ["_playerRole", "_playerGroupName"];

        // TODO: Consider removing rank names for resistance.

        private _side = switch (side player) do {
            case WEST: { "Czedacka Armia" };
            case EAST: { "Czedacka Armia" };
            case INDEPENDENT: { "Czarnoruski Ruch Oporu" };
            case CIVILIAN: { "Czarnoruskie Koleje Samochodowe" };
            default { "JAK TO WIDZISZ TO MYDLARZ COŚ SPIERDOLIŁ" };
        };

        private _rankAndName = if (side player isEqualTo WEST) then {
            format ["%1 %2",
                diwako_dui_nametags_RankNames get "default" get rank player,
                name player]
        } else {
            format ["%1", name player]
        };

        private _location = "";
        if (ext1Group isEqualTo group player) then {
            _location = "W lesie na zachód od Sosnowki";
        };
        if (ext2Group isEqualTo group player) then {
            _location = "Lotnisko Czarnoruskie";
        };
        if (ext3Group isEqualTo group player) then {
            _location = "Baza pod Pawłowem";
        };
        if (ext4Group isEqualTo group player) then {
            _location = "W lesie na zachód od Sosnowki";
        };
        if (baseGuards isEqualTo group player) then {
            _location = "Baza w Zelenogorsku";
        };
        if (baseGroup isEqualTo group player) then {
            _location = "Baza w Zelenogorsku";
        };
        if (player isEqualTo busDriver) then { _location = "Pętla w Lopatino"; };
        if (player isEqualTo busTicketer) then { _location = "Przystanek w Vyborze"; };

        [
            LLSTRING(Mission_Title),
            {format ["%1 %2", LLSTRING(Date), [daytime, "HH:MM:SS"] call BIS_fnc_timeToString]},
            _rankAndName,
            format ["%1 - %2", _playerGroupName, _playerRole],
            _side, // TODO: Change this to apropriate unit based on player side/unit
            _location // TODO: Change this to apropriate location
        ] spawn FUNC(infoText);
    }, [_playerRole, _playerGroupName], 4, {
        params ["_playerRole", "_playerGroupName"];

        private _side = switch (side player) do {
            case WEST: { "Czedacka Armia" };
            case EAST: { "Czedacka Armia" };
            case INDEPENDENT: { "Czarnoruski Ruch Oporu" };
            case CIVILIAN: { "Czarnoruskie Koleje Samochodowe" };
            default { "JAK TO WIDZISZ TO MYDLARZ COŚ SPIERDOLIŁ" };
        };

        private _rankAndName = if (side player isEqualTo WEST) then {
            format ["%1 %2", rank player, name player]
        } else {
            format ["%1", name player]
        };

        private _location = "";
        if (ext1Group isEqualTo group player) then {
            _location = "W lesie na zachód od Sosnowki";
        };
        if (ext2Group isEqualTo group player) then {
            _location = "Lotnisko Czarnoruskie";
        };
        if (ext3Group isEqualTo group player) then {
            _location = "Baza pod Pawłowem";
        };
        if (ext4Group isEqualTo group player) then {
            _location = "W lesie na zachód od Sosnowki";
        };
        if (baseGuards isEqualTo group player) then {
            _location = "Baza w Zelenogorsku";
        };
        if (baseGroup isEqualTo group player) then {
            _location = "Baza w Zelenogorsku";
        };
        if (player isEqualTo busDriver) then { _location = "Pętla w Lopatino"; };
        if (player isEqualTo busTicketer) then { _location = "Przystanek w Vyborze"; };

        [
            LLSTRING(Mission_Title),
            format ["%1 %2", LLSTRING(Date), [daytime, "HH:MM:SS"] call BIS_fnc_timeToString],
            _rankAndName,
            format ["%1 - %2", _playerGroupName, _playerRole],
            _side, // TODO: Change this to apropriate unit based on player side/unit
            _location // TODO: Change this to apropriate location
        ] spawn FUNC(infoText);
    }] call CBA_fnc_waitUntilAndExecute;
}, [], 5] call CBA_fnc_waitAndExecute;
