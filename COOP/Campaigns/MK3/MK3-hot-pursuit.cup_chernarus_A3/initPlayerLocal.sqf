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

        [
            LLSTRING(Mission_Title),
            {format ["%1 %2", LLSTRING(Date), [daytime, "HH:MM:SS"] call BIS_fnc_timeToString]},
            format ["%1 %2",
                diwako_dui_nametags_RankNames get "default" get rank player,
                name player],
            format ["%1 - %2", _playerGroupName, _playerRole],
            "Czarnoruscy Partyzanci", // TODO: Change this to apropriate unit based on player side/unit
            "W lesie na zachód od Zelenogorska" // TODO: Change this to apropriate location
        ] spawn FUNC(infoText);
    }, [_playerRole, _playerGroupName], 4, {
        params ["_playerRole", "_playerGroupName"];

        [
            LLSTRING(Mission_Title),
            format ["%1 %2", LLSTRING(Date), [daytime, "HH:MM:SS"] call BIS_fnc_timeToString],
            format ["%1 %2", rank player, name player],
            format ["%1 - %2", _playerGroupName, _playerRole],
            "Czarnoruscy Partyzanci", // TODO: Change this to apropriate unit based on player side/unit
            "W lesie na zachód od Zelenogorska" // TODO: Change this to apropriate location
        ] spawn FUNC(infoText);
    }] call CBA_fnc_waitUntilAndExecute;
}, [], 5] call CBA_fnc_waitAndExecute;






player createDiarySubject ["mkr_briefing", LLSTRING(DisplayName)];
player createDiaryRecord ["mkr_briefing", LLSTRING(Rationale)];





private _door2position = [5.3, 6.9, -5];
private _door2positionWorld = militia_station modelToWorldVisual _door2position;

private _action = [
	"DoorBreachingCharge",
	"Plant breaching charge",
	"",
	{
		// systemChat format ["%1", _this];
		if (missionNamespace getVariable [QGVAR(door2_closedNoCharge), true]) then {
			missionNamespace setVariable [QGVAR(door2_closedNoCharge), false, true];

			params ["_object", "_caller", "_arguments"];
			_arguments params ["_doorPosition"];

			private _explosive = [_caller, _doorPosition, 135, "AMP_Breaching_Charge_Mag", "Command", [], objNull] call ace_explosives_fnc_placeExplosive;
			_explosive call bcdw_main_fnc_plantBreachingCharge;

			[{
				daytime > 6.25
			}, {
				_this call ace_explosives_fnc_detonateExplosive;
                ["DoorsBreached"] call CBA_fnc_globalEvent;
			}, [_caller, -1, [_explosive, 0], "ACE_Clacker"]] call CBA_fnc_waitUntilAndExecute;
		};
	},
	{missionNamespace getVariable [QGVAR(door2_closedNoCharge), true]},
	{},
	[_door2positionWorld],
	_door2position,// "door_2",
	50
] call ace_interact_menu_fnc_createAction;

[militia_station, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;

[{daytime > 6.21950}, {
	playMusic "ACTION_PD2_09_Razormind";
}] call CBA_fnc_waitUntilAndExecute;
