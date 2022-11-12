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
        _roleDescription select [0, _monkeyIndex]
    };

    private _playerGroupName = groupid group player;

    [{!isNil "diwako_dui_nametags_RankNames"}, {
        params ["_playerRole", "_playerGroupName"];

        [
            LLSTRING(Mission_Title),
            {format ["%1 %2", LLSTRING(Date), [daytime, "HH:MM:SS"] call BIS_fnc_timeToString]},
            format ["%1 %2",
                diwako_dui_nametags_RankNames get "default" get rank player,
                name player],
            format ["%1 %2", _playerGroupName, _playerRole],
            "82nd US Army Rangers",
            LLSTRING(TakistanRasmanAirfield)
        ] spawn FUNC(infoText);
    }, [_playerRole, _playerGroupName], 4, {
        params ["_playerRole", "_playerGroupName"];

        [
            LLSTRING(Mission_Title),
            format ["%1 %2", LLSTRING(Date), [daytime, "HH:MM:SS"] call BIS_fnc_timeToString],
            format ["%1 %2", rank player, name player],
            format ["%1 %2", _playerGroupName, _playerRole],
            "82nd US Army Rangers",
            LLSTRING(TakistanRasmanAirfield)
        ] spawn FUNC(infoText);
    }] call CBA_fnc_waitUntilAndExecute;
}, [], 5] call CBA_fnc_waitAndExecute;
