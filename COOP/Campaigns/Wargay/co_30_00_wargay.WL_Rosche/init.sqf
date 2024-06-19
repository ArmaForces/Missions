#include "script_component.hpp"

minviewdistance = 500;
maxviewdistance = 10000;

GVAR(isTest) = true;

// TODO: Add KnowsAboutChanged EH to WEST groups as needed as this thing most likely won't work
{
    _x addEventHandler ["KnowsAboutChanged", FUNC(knowsAboutChanged)];
} forEach (groups WEST);

{
    _x addEventHandler ["CuratorObjectDeleted", FUNC(curatorObjectDeleted)];
} forEach allCurators;

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
        _hashMap set ["iconPath", getText (_x >> "iconPath")];
        _hashMap set ["markerType", getText (_x >> "markerType")];
        _hashMap set ["isCommandVehicle", (_x >> "isCommandVehicle") call BIS_fnc_getCfgDataBool];
        _hashMap set ["isLogistics", (_x >> "isLogistics") call BIS_fnc_getCfgDataBool];
        _hashMap set ["isRecon", (_x >> "isRecon") call BIS_fnc_getCfgDataBool];
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

[
    "Man",
    "Init",
    FUNC(manInit),
    true, // Allow inheritance
    [], // Excluded classes
    true // Apply retroactive
] call CBA_fnc_addClassEventHandler;

GVAR(spawnableVehicles) = createHashMapFromArray [
    // LOG
    ["gm_ge_army_iltis_cargo", 2],
    ["gm_ge_army_m113a1g_command", 1],
    ["cwr3_b_m577_hq", 1],
    ["gm_ge_army_fuchsa0_command", 1],
    ["gm_ge_army_bpz2a0", 2],
    ["gm_ge_army_kat1_451_reammo", 4],
    ["B_Truck_01_fuel_F", 2],

    // SUP
    ["gm_ge_army_gepard1a1", 2], // 3
    ["gm_ge_army_m109g", 2],
    ["cwr3_b_m163", 4],
    ["gm_ge_army_kat1_463_mlrs", 1],

    // TNK
    ["gm_ge_army_Leopard1a1", 1], // 6
    ["gm_ge_army_Leopard1a3", 6],
    ["gm_ge_army_marder1a1a", 4],
    ["cwr3_b_m60a3", 4],

    // REC
    ["gm_ge_army_iltis_milan", 4],
    ["gm_ge_army_bo105m_vbh", 1],
    ["gm_ge_army_fuchsa0_reconnaissance", 1], // 3
    ["gm_ge_army_luchsa1", 2],
    
    // VEH
    ["cwr3_b_m901_itv", 2],
    ["cwr3_b_hmmwv_tow", 4],

    // HEL
    ["cwr3_b_ah1f", 2]
];

// TODO: Add assignable roles within a group so you get teleported to a vehicle on deployment
// TODO: Make only HQ able to spawn new vehicles
// TODO: Rearm/Refuel/Repair supplies
// TODO: Increase XP for repairing vehicles
// TODO: Think about XP for recon?
// TODO: Test LAMBS artillery target module from right panel (skip adjustment rounds)
// TODO: Command zones & capture mechanic
// BUG: Rearm action always visible
// BUG: Artillery firing at units gets spotted
// TODO: Consider display of unit name on hover (ctrlMapMouseOver)
// TODO: Multiply explosion of logistic vehicles
// TODO: Consider Metis Markers https://github.com/Metis-Team/mts_marker/wiki/Mission-Designer-Manuel
// TODO: Add deployment zone(s) with 0 fuel outside of it
// BUG: 1 AP HMGs shred through the helicopters
// BUG: displayNameShort doesn't work for non-GM vehicles
// TODO: XP for assists
// BUG: Vehicles not added to zeus automatically
// TODO: Lock & disable simulation for spawners automatically
// BUG: OCAP reports suicides

if (GVAR(isTest)) then {
    [{
        ["MDL_startGame"] call CBA_fnc_globalEvent;
    }] call CBA_fnc_execNextFrame;
};