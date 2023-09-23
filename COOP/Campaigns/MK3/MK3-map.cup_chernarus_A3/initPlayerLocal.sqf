#include "script_component.hpp"

GVAR(isZeus) = zeus isEqualTo player;

// Disable CUP street lights based on lighting levels (bad performance script)
CUP_stopLampCheck = true;

[{alive player}, {
    // Dodanie akcji do zmiany odległości widzenia oraz nazw drużyn
    call FUNC(playerActions);
}, [], -1] call CBA_fnc_waitUntilAndExecute;

// [{
//     private _roleDescription = roleDescription player;
//     private _monkeyIndex = _roleDescription find "@";
//     private _playerRole = if (_monkeyIndex isEqualTo -1) then {
//         _roleDescription
//     } else {
//         if (_monkeyIndex isEqualTo 0) then {
//             // Localize name
//             private _localizedRoleDescription = localize _roleDescription;
//             // Check again for CBA lobby group name
//             _monkeyIndex = _localizedRoleDescription find "@";
//             if (_monkeyIndex isEqualTo -1) then {
//                 _localizedRoleDescription
//             } else {
//                 _localizedRoleDescription select [0, _monkeyIndex];
//             };
//         } else {
//             // Remove CBA lobby group name
//             _roleDescription select [0, _monkeyIndex]
//         };
//     };

//     if (_playerRole isEqualTo "") then {
//         _playerRole = getText (configFile >> "CfgVehicles" >> typeOf player >> "displayName");
//     };

//     private _playerGroupName = groupid group player;

//     [{!isNil "diwako_dui_nametags_RankNames"}, {
//         params ["_playerRole", "_playerGroupName"];

//         // TODO: Consider removing rank names for resistance.

//         private _side = switch (side player) do {
//             case WEST: { "Milicja" };
//             case EAST: { "" };
//             case INDEPENDENT: { "Czarnoruski Ruch Oporu" };
//             case CIVILIAN: { "Mieszkaniec Czarnorusi" };
//             default { "JAK TO WIDZISZ TO MYDLARZ COŚ SPIERDOLIŁ" };
//         };

//         private _rankAndName = if (side player isEqualTo WEST) then {
//             format ["%1 %2",
//                 diwako_dui_nametags_RankNames get "default" get rank player,
//                 name player]
//         } else {
//             format ["%1", name player]
//         };

//         private _location = "";
//         // TODO: Determine location via trigger area + fallback to map locations
//         if (side player isEqualTo WEST) then {
//             _location = "Posterunek Milicji w Zelenogorsku";
//         };
//         if (convoyGroup isEqualTo group player) then {
//             _location = "Posterunek Milicji w Chernogorsku";
//         };
//         if (side player isEqualTo INDEPENDENT) then {
//             _location = "W lesie na zachód od Zelenogorska";
//         };
//         if (banditsGroup isEqualTo group player) then {
//             _location = "Areszt w Zelenogorsku";
//         };

//         [
//             LLSTRING(Mission_Title),
//             {format ["%1 %2", LLSTRING(Date), [daytime, "HH:MM:SS"] call BIS_fnc_timeToString]},
//             _rankAndName,
//             format ["%1 - %2", _playerGroupName, _playerRole],
//             _side, // TODO: Change this to apropriate unit based on player side/unit
//             _location // TODO: Change this to apropriate location
//         ] spawn FUNC(infoText);
//     }, [_playerRole, _playerGroupName], 4, {
//         params ["_playerRole", "_playerGroupName"];

//         private _side = switch (side player) do {
//             case WEST: { "Milicja" };
//             case EAST: { "" };
//             case INDEPENDENT: { "Czarnoruski Ruch Oporu" };
//             case CIVILIAN: { "Mieszkaniec Czarnorusi" };
//             default { "JAK TO WIDZISZ TO MYDLARZ COŚ SPIERDOLIŁ" };
//         };

//         private _rankAndName = if (side player isEqualTo WEST) then {
//             format ["%1 %2", rank player, name player]
//         } else {
//             format ["%1", name player]
//         };

//         private _location = "";
//         if (side player isEqualTo WEST) then {
//             _location = "Posterunek Milicji w Zelenogorsku";
//         };
//         if (convoyGroup isEqualTo group player) then {
//             _location = "Posterunek Milicji w Chernogorsku";
//         };
//         if (side player isEqualTo INDEPENDENT) then {
//             _location = "W lesie na zachód od Zelenogorska";
//         };
//         if (banditsGroup isEqualTo group player) then {
//             _location = "Areszt w Zelenogorsku";
//         };
//         if (player isEqualTo busDriver) then { _location = "Pętla w Lopatino"; };
//         if (player isEqualTo busTicketer) then { _location = "Przystanek w Vyborze"; };

//         [
//             LLSTRING(Mission_Title),
//             format ["%1 %2", LLSTRING(Date), [daytime, "HH:MM:SS"] call BIS_fnc_timeToString],
//             _rankAndName,
//             format ["%1 - %2", _playerGroupName, _playerRole],
//             _side, // TODO: Change this to apropriate unit based on player side/unit
//             _location // TODO: Change this to apropriate location
//         ] spawn FUNC(infoText);
//     }] call CBA_fnc_waitUntilAndExecute;
// }, [], 5] call CBA_fnc_waitAndExecute;

[FUNC(initIntroText), [], 5] call CBA_fnc_waitAndExecute;
[FUNC(initPlayerPersonalVehicles), [], 5] call CBA_fnc_waitAndExecute;
[player] call FUNC(initBriefing);
player addItem "ACE_Cellphone";

// Init custom actions
call FUNC(initDocumentsActions);
call FUNC(initPhoneActions);
call FUNC(initSkillsActions);

// Enable medical menu for medics only
private _isMedic = [player] call ACEFUNC(medical_treatment,isMedic);
if (!_isMedic) then {
    [QACEGVAR(medical_gui,enableMedicalMenu), 0, 999999, "client", false] call CBA_settings_fnc_set;
};

/*
    Custom CBA Event Handlers
*/

[QGVAR(showEmergencyServicesNotification), FUNC(showEmergencyServicesNotification)] call CBA_fnc_addEventHandler;

[QGVAR(showIntroText), FUNC(initIntroText)] call CBA_fnc_addEventHandler;

[QGVAR(showZeusRollMessage), FUNC(showZeusRollMessage)] call CBA_fnc_addEventHandler;














/*
    SOME UNSORTED CRAP
*/






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

// Handle taser shot
player addEventHandler ["HitPart", {
    (_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];
    _ammo params ["_hitValue", "_indirectHitValue", "_indirectHitRange", "_explosiveDamage", "_ammoClassName"];

    if (_ammoClassName isEqualTo "X26_Prong") exitWith {
        private _setUnconscious = true;
        private _minimumUnconsciousTime = random 15 + 10;
        private _forceWakeupIfStable = true;
        systemChat format ["Sleeping for %1", _minimumUnconsciousTime];
        [_target, _setUnconscious] call ace_medical_status_fnc_setUnconsciousState;
        [{
            systemChat "Wake up!";
            [_this, false] call ace_medical_status_fnc_setUnconsciousState;
            _this setVariable ["crow_x26_canTase", true];
        }, _target, _minimumUnconsciousTime] call CBA_fnc_waitAndExecute;

    };
}];

// Handle cans hitting players
player addEventHandler ["Fired", {
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
    systemChat format ["Fired ammo: %1 | magazine: %2", _ammo, _magazine];
    if (_ammo isNotEqualTo "CANS_ammo") exitWith { nil };
    systemChat "Can thrown!";

    private _velocity = velocity _projectile;
    private _mass = getMass _projectile;
    systemChat format ["Velocity: %1 | Mass: %2", str _velocity, _mass];

    // private _newProjectile = createVehicle ["Land_Can_Dented_F", getPosATL _projectile, [], 0, "CAN_COLLIDE"];
    private _newProjectile = createVehicle ["Land_Can_Rusty_F", getPosATL _projectile, [], 0, "CAN_COLLIDE"];
    // _newProjectile setDir random 360;
    _newProjectile setMass (_mass * 100);
    _newProjectile setVelocity _velocity;// vectorMultiply 100;
    deleteVehicle _projectile;

    // [{
    //     private _projectile = _this;
    //     private _velocity = velocity _projectile;
    //     private _mass = getMass _projectile;
    //     systemChat format ["Velocity: %1 | Mass: %2", str _velocity, _mass];

    //     private _newProjectile = createVehicle ["Land_Can_Dented_F", getPosATL _projectile, [], 0, "CAN_COLLIDE"];
    //     // _newProjectile setDir random 360;
    //     _newProjectile setMass _mass;
    //     _newProjectile setVelocity _velocity vectorMultiply 100;
    //     deleteVehicle _projectile;
    // }, _projectile] call CBA_fnc_execNextFrame;

    // _projectile addEventHandler ["Deflected", {
    //     params ["_projectile", "_pos", "_velocity", "_hitObject"];
    //     systemChat "Projectile deflected!";
    //     [_hitObject, true] call ace_medical_status_fnc_setUnconsciousState;
    // }];

    // _projectile addEventHandler ["HitPart", {
    //     params ["_projectile", "_hitEntity", "_projectileOwner", "_pos", "_velocity", "_normal", "_component", "_radius" ,"_surfaceType"];
    //     systemChat format ["Object hit! Component: %1", _component];
    // }];

    // _projectile addEventHandler ["EpeContactStart", {
    //     params ["_object1", "_object2", "_selection1", "_selection2", "_force", "_reactForce", "_worldPos"];
    //     systemChat format ["Object hit! Object: %1", _object2];
    //     [_object2, true] call ace_medical_status_fnc_setUnconsciousState;
    // }];
}];
