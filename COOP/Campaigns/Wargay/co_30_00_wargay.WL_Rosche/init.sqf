#include "script_component.hpp"

minviewdistance = 500;
maxviewdistance = 10000;

// TODO: Add KnowsAboutChanged EH to WEST groups as needed as this thing most likely won't work
{
    _x addEventHandler ["KnowsAboutChanged", FUNC(knowsAboutChanged)];
} forEach (groups WEST);

AmmoTypes = createHashMapFromArray
    ("true" configClasses (missionConfigFile >> "CfgWargay" >> "Ammo")
    apply {
        private _hashMap = createHashMap;
        _hashMap set [CLASS_NAME_PROPERTY, toUpper configName _x];
        _hashMap set [DAMAGE_PROPERTY, getNumber (_x >> DAMAGE_PROPERTY)];
        _hashMap set [TYPE_PROPERTY, getText (_x >> TYPE_PROPERTY)];

        private _child = getText (_x >> "child");
        if (_child isNotEqualTo "") then {
            _hashMap set ["child", _child];
        };

        [toUpper configName _x, _hashMap]
    });

VehicleTypes = createHashMapFromArray
    ("true" configClasses (missionConfigFile >> "CfgWargay" >> "Vehicles")
    apply {
        private _hashMap = createHashMap;
        _hashMap set [CLASS_NAME_PROPERTY, toUpper configName _x];
        _hashMap set ["pointCost", getNumber (_x >> "pointCost")];
        _hashMap set ["hitpoints", getNumber (_x >> "hitpoints")];
        _hashMap set ["armor", getArray (_x >> "armor")];
        _hashMap set ["isRecon", getNumber (_x >> "isRecon")];
        [toUpper configName _x, _hashMap]
    });

private _magazinesForVehicles = VehicleTypes apply {
    private _vehicleClassName = VehicleTypes get _x get CLASS_NAME_PROPERTY;
    private _magazines = getArray (configFile >> "CfgVehicles" >> _vehicleClassName >> "Turrets" >> "MainTurret" >> "magazines");
    _magazines = _magazines arrayIntersect _magazines;

    private _magazinesAndAmmo = _magazines apply {
        [_x, getText (configFile >> "CfgMagazines" >> _x >> "ammo")]
    } apply {
        [_x select 0, AmmoTypes getOrDefault [toUpper (_x select 1), objNull]]
    } select {
        _x select 1 isNotEqualTo objNull
    };

    _magazinesAndAmmo apply {
        private _hashMap = createHashMap;

        _hashMap set [CLASS_NAME_PROPERTY, _x select 0];

        private _ammoInfo = _x select 1;
        private _child = _ammoInfo getOrDefault ["child", ""];
        if (_child isNotEqualTo "") then {
            _ammoInfo = AmmoTypes get toUpper _child;
            // diag_log format ["WARGAY MAGS DEBUG: %1 Has child: %2 Ammo Info: %3", _x select 0, _child, str _ammoInfo];
        };

        _hashMap set [AMMO_PROPERTY, _ammoInfo];
        [toUpper (_x select 0), _hashMap];
    }
};

private _magazineTypes = [];
{
    _magazineTypes append _x;
} forEach _magazinesForVehicles;
MagazineTypes = createHashMapFromArray _magazineTypes;

[
    "AllVehicles",
    "Init",
    FUNC(vehicleInit),
    true, // Allow inheritance
    ["Man"], // Excluded classes
    true // Apply retroactive
] call CBA_fnc_addClassEventHandler;

GVAR(spawnableVehicles) = createHashMapFromArray [
    // LOG
    ["gm_ge_army_m113a1g_command", 2],
    ["gm_ge_army_bpz2a0", 2],

    // SUP
    ["gm_ge_army_gepard1a1", 4],
    ["gm_ge_army_m109g", 2],

    // TNK
    ["gm_ge_army_Leopard1a1", 12],

    // REC
    ["gm_ge_army_bo105m_vbh", 2],
    ["gm_ge_army_fuchsa0_reconnaissance", 4],
    ["gm_ge_army_luchsa1", 2]
];

// BUG: Crews die
// TODO: Refuel
// TODO: Make only HQ able to spawn new vehicles
// TODO: Save XP somewhere for next missions
