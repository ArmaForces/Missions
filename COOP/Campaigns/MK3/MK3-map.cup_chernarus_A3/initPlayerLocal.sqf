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

// Enable medical menu for medics only
private _isMedic = [player] call ACEFUNC(medical_treatment,isMedic);
if (!_isMedic) then {
    [QACEGVAR(medical_gui,enableMedicalMenu), 0, 999999, "client", false] call CBA_settings_fnc_set;
};



















private _insertDocumentChildren = {
    params ["_target", "_player", "_params"];

    private _documents = [player] call FUNC(getDocuments);

    private _documentsForActions = _documents apply {
        _x params ["_documentName", "_documentContent"];
        [_documentName, _documentName, FUNC(showDocumentStatement), _x]
    };

    [_documentsForActions] call FUNC(createChildActions);
};

private _condition = {[player] call FUNC(hasAnyDocument)};
private _action = [QGVAR(documents), LLSTRING(ShowDocuments), "", {}, _condition, _insertDocumentChildren, [], "", 4, [false, false, false, false, false], {}] call ace_interact_menu_fnc_createAction;

// External action
[
    "CAManBase",
    0,
    ["ACE_MainActions"],
    _action,
    true
] call ACEFUNC(interact_menu,addActionToClass);

// Self action
[
    typeOf (player),
    1,
    ["ACE_SelfActions", "ACE_Equipment"],
    _action,
    false
] call ACEFUNC(interact_menu,addActionToClass);





[QGVAR(showZeusRollMessage), {
    params ["_unit", "_skillName", "_skillBonusScore", "_rollResult"];

    // TODO: Change to ACE function after release
    // if (call ACEFUNC(common,hasZeusAccess)) exitWith {
    if (!isNull getAssignedCuratorLogic player) exitWith {
        private _rollMessage = format [LLSTRING(Skills_RolledMessage), localize _skillName, _skillBonusScore, _rollResult];
        _unit commandChat _rollMessage;
    };
}] call CBA_fnc_addEventHandler;


private _insertSkillsChildren = {
    params ["_target", "_player", "_params"];

    private _skills = [player] call FUNC(getSkills);

    // Prepare skills for actions creation
    private _skillsForActions = _skills apply {
        _x params ["_skillName", "_skillBonusScore"];

        [_skillName, format ["%1 (%2)", localize _skillName, _skillBonusScore], FUNC(rollSkill), _x]
    };

    [_skillsForActions] call FUNC(createChildActions);
};

private _skillsAction = [QGVAR(skills), LLSTRING(Skills), "", {}, {true}, _insertSkillsChildren, [], "", 4, [false, false, false, false, false], {}] call ace_interact_menu_fnc_createAction;

[
    typeOf (player),
    1,
    ["ACE_SelfActions"],
    _skillsAction,
    false
] call ACEFUNC(interact_menu,addActionToClass);





[QGVAR(emergencyServicesNotification), {
    if (!(player call FUNC(hasPhone))) exitWith {};

    if (player call FUNC(isCop)
    || {player call FUNC(isMedicalService)
    || {!isNull getAssignedCuratorLogic player}}) then {
        params ["_unit", "_time", "_position", "_nearestLocationName", "_emergencyTypeName", ["_needsAmbulance", false]];

        private _localizedEmergencyTypeName = localize _emergencyTypeName;

        private _emergencyMessage = format [LLSTRING(EmergencyMessage), _localizedEmergencyTypeName, _nearestLocationName, _time];
        if (_needsAmbulance) then {
            _emergencyMessage = format ["%1 %2", _emergencyMessage, LLSTRING(Emergency_AmbulanceNeeded)];
        };

        _unit commandChat _emergencyMessage;

        private _markerText = format [LLSTRING(EmergencyMarker), _localizedEmergencyTypeName, _time];
        [_position, _markerText] call FUNC(createEmergencyMarker);
    };

}] call CBA_fnc_addEventHandler;


private _insertPhoneChildren = {
    params ["_target", "_player", "_params"];

    // Create child actions for 112 call with different report types
    private _emergencyChildActions = {
        params ["_target", "_player", "_params"];

        private _types = [
            ["emergency:accident", LLSTRING(Emergency_Accident), FUNC(callEmergency), [LSTRING(Emergency_Accident), true]],
            ["emergency:violence", LLSTRING(Emergency_Violence), FUNC(callEmergency), [LSTRING(Emergency_Violence), true]],
            ["emergency:tip", LLSTRING(Emergency_Tip), FUNC(callEmergency), [LSTRING(Emergency_Tip)]],
            ["emergency:other", LLSTRING(Emergency_Other), FUNC(callEmergency), [LSTRING(Emergency_Other)]]
        ];

        [_types] call FUNC(createChildActions);
    };

    private _contacts = [
        ["number:112", "112", {}, [], _emergencyChildActions]
    ];

    [_contacts] call FUNC(createChildActions);
};



private _phoneAction = [QGVAR(phone), localize "$STR_ace_explosives_cellphone_displayName", "", {}, {player call FUNC(hasPhone)}, _insertPhoneChildren, [], "", 4, [false, false, false, false, false], {}] call ace_interact_menu_fnc_createAction;


[
    typeOf (player),
    1,
    ["ACE_SelfActions", "ACE_Equipment"],
    _phoneAction,
    false
] call ACEFUNC(interact_menu,addActionToClass);








[QGVAR(showIntroText), FUNC(initIntroText)] call CBA_fnc_addEventHandler;




















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
