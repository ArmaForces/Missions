#include "script_component.hpp"

GVAR(isZeus) = zeus isEqualTo player;
player assignItem "ItemMap";

// Disable CUP street lights based on lighting levels (bad performance script)
CUP_stopLampCheck = true;

[{alive player}, {
    // Dodanie akcji do zmiany odległości widzenia oraz nazw drużyn
    call FUNC(playerActions);
}, [], -1] call CBA_fnc_waitUntilAndExecute;

[FUNC(initIntroText), [], 5] call CBA_fnc_waitAndExecute;
[FUNC(initPlayerPersonalVehicles), [], 5] call CBA_fnc_waitAndExecute;
[player] call FUNC(initBriefing);

// Add basic items
[{
    player assignItem "ItemMap";
    player addItem "ACE_Cellphone";

    // Chance for cigarettes
    if (random 1 > 0.5) then {
        if (random 1 > 0.9) then {
            player addItem "murshun_cigs_cig0";
        } else {
            player addItem "murshun_cigs_cigpack";
        };
    };
    // Chance for lighter or matches
    if (random 1 > 0.5) then {
        player addItem (selectRandom ["murshun_cigs_lighter", "murshun_cigs_matches"]);
    };

    // Add keys
    if (!isNil "zeus" && {player isEqualTo zeus}) then {
        player addItem "ACE_key_master"
    } else {
        switch (side player) do
        {
            case WEST: {
                // Separate militia from chedaks as they should not share keys
                if (player call FUNC(isMilitia)) then {
                    player addItem "ACE_key_west";
                } else {
                    player addItem "ACE_key_east";
                }
            };
            case EAST: { player addItem "ACE_key_east"; };
            case INDEPENDENT: { player addItem "ACE_key_indp"; };
            default {
                if (player call FUNC(isMedicalService)) then {
                    // Nothing for medics
                } else {
                    player addItem "ACE_key_lockpick";
                };
            };
        };
    };
}, [], 5] call CBA_fnc_waitAndExecute;

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

["ace_vehiclelock_startedLockpick", {
    params ["_lockpickedVehicle"];

    private _hasAlarm = _lockpickedVehicle getVariable [QGVAR(hasAlarm), objNull];
    if (isNull _hasAlarm) then {
        _hasAlarm = random 1 > (1 - VEHICLE_ALARM_CHANCE);
        _lockpickedVehicle setVariable [QGVAR(hasAlarm), _hasAlarm, true];
    };

    if (_hasAlarm) then {
        [QGVAR(carAlarm), [_lockpickedVehicle]] call CBA_fnc_globalEvent;
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(carAlarm), FUNC(carAlarm)] call CBA_fnc_addEventHandler;











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
        // systemChat format ["Sleeping for %1", _minimumUnconsciousTime];
        [_target, _setUnconscious] call ace_medical_status_fnc_setUnconsciousState;
        [{
            // systemChat "Wake up!";
            [_this, false] call ace_medical_status_fnc_setUnconsciousState;
            _this setVariable ["crow_x26_canTase", true];
        }, _target, _minimumUnconsciousTime] call CBA_fnc_waitAndExecute;

    };
}];

/*
GÓWNO OSRANE NIE DZIAŁĄ W DUPIE TO MAM
["ace_firedPlayer", {
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];
    // systemChat format ["FIREEEED! %1", _this];

    #define THROWABLE_OBJECTS ["CANS_ammo", "BOTTLE_ammo", "ROCK_ammo"]
    #define CANS_OBJECTS ["Land_Can_Dented_F", "Land_Can_Rusty_F", "Can_small", "Land_Can_V1_F", "Land_Can_V3_F", "Land_Can_V2_F", "Land_TacticalBacon_F"]
    #define BOTTLE_OBJECTS ["Land_BottlePlastic_V2_F", "Land_BottlePlastic_V1_F"]

    if (!(_ammo in THROWABLE_OBJECTS)) exitWith { nil };
    // systemChat "Can thrown!";

    // systemChat format ["Velocity: %1 | Mass: %2", str _velocity, _mass];

    // private _newProjectile = createVehicle ["Land_Can_Dented_F", getPosATL _projectile, [], 0, "CAN_COLLIDE"];
    private _vehicleType = selectRandom CANS_OBJECTS;
    private _itemType = "CANS_MAG";
    if (_ammo isEqualTo "BOTTLE_ammo") then {
        _vehicleType = selectRandom BOTTLE_OBJECTS;
    };

    private _trackedProjectile = if (!(_ammo isEqualTo "ROCK_ammo")) then {
        private _newProjectile = createVehicle [_vehicleType, getPosATL _projectile, [], 0, "CAN_COLLIDE"];
        // _newProjectile setDir random 360;
        private _velocity = velocity _projectile;
        private _mass = getMass _projectile;
        _newProjectile setMass (_mass * 100);
        _newProjectile setVelocity _velocity;// vectorMultiply 100;
        deleteVehicle _projectile;
        _newProjectile
    } else {
        _itemType = "ROCK_MAG";
        _projectile
    };

    [{
        systemChat "Removing throwable";
        deleteVehicle (_this select 0);
        private _nearestHolders = nearestObjects [getPos (_this select 0), ["WeaponHolderSimulated", "GroundWeaponHolder", "Default"], 4];
        private _holder = if (count _nearestHolders isEqualTo 0) then {
            private _weaponHolder = createVehicle ["GroundWeaponHolder", [0, 0, 0], [], 0, "CAN_COLLIDE"];
            _weaponHolder setPos getPos (_this select 0);
        } else {
            _nearestHolders select 0;
        };

        _holder addItemCargoGlobal [_this select 1, 1];
        _holder addMagazineCargoGlobal [_this select 1, 1];
    }, [_trackedProjectile, _itemType], 15] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;
*/

/*
// Handle cans hitting players
player addEventHandler ["Fired", {
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
    // systemChat format ["Fired ammo: %1 | magazine: %2", _ammo, _magazine];

    #define THROWABLE_OBJECTS ["CANS_ammo", "BOTTLE_ammo", "ROCK_ammo"]
    if (!(_ammo in THROWABLE_OBJECTS)) exitWith { nil };
    // systemChat "Can thrown!";

    private _velocity = velocity _projectile;
    private _mass = getMass _projectile;
    // systemChat format ["Velocity: %1 | Mass: %2", str _velocity, _mass];

    // private _newProjectile = createVehicle ["Land_Can_Dented_F", getPosATL _projectile, [], 0, "CAN_COLLIDE"];
    private _newProjectile = createVehicle ["Land_Can_Rusty_F", getPosATL _projectile, [], 0, "CAN_COLLIDE"];
    // _newProjectile setDir random 360;
    _newProjectile setMass (_mass * 100);
    _newProjectile setVelocity _velocity;// vectorMultiply 100;
    deleteVehicle _projectile;

    [{speed _this < 0.1}, {
        deleteVehicle _this;
        private _nearestHolders = nearestObjects [getPos _this, ["WeaponHolderSimulated", "GroundWeaponHolder", "Default"], 4];
        private _holder = if (count _nearestHolders isEqualTo 0) then {
            private _weaponHolder = createVehicle ["GroundWeaponHolder", [0, 0, 0], [], 0, "CAN_COLLIDE"];
            _weaponHolder setPos getPos _this;
        } else {
            _nearestHolders select 0;
        };

        _holder addItemCargoGlobal "";
    }, _newProjectile, 15, {
        deleteVehicle _this;
    }] call CBA_fnc_waitUntilAndExecute;

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
*/
