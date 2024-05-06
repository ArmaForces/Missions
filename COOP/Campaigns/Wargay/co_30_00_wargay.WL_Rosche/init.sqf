#include "script_component.hpp"

minviewdistance = 500;
maxviewdistance = 10000;

#define DEV_DEBUG
WestIconColor = getArray (missionConfigFile >> "CfgWargay" >> "westMarkerColor");
EastIconColor = getArray (missionConfigFile >> "CfgWargay" >> "eastMarkerColor");
IconMode = 0;
OnlyReconCanSpot = false;

/* Custom test things */

#ifdef DEV_DEBUG
HitpointHits = [];
PositionHits = [];
SurfaceVectors = [];
VelocityVectors = [];
#endif

// TODO: Consider adding initial projectile position/velocity in Fired EH and base damage on that

// TODO: Add KnowsAboutChanged EH to WEST groups as needed as this thing most likely won't work
{
    _x addEventHandler ["KnowsAboutChanged", FUNC(knowsAboutChanged)];

    _x addEventHandler ["EnemyDetected", {
        params ["_group", "_newTarget"];

        #ifdef DEV_DEBUG
        diag_log format ["WARGAY DEBUG ENEMY DETECTED [%1]: Group %1, Target: %2", diag_tickTime, _group, _newTarget];
        #endif
    }];
} forEach (groups WEST);

AmmoTypes = createHashMapFromArray
    ("true" configClasses (missionConfigFile >> "CfgWargay" >> "Ammo")
    apply {
        private _hashMap = createHashMap;
        _hashMap set ["damage", getNumber (_x >> "damage")];
        _hashMap set ["type", getText (_x >> "type")];
        [toUpper configName _x, _hashMap]
    });
VehicleTypes = createHashMapFromArray
    ("true" configClasses (missionConfigFile >> "CfgWargay" >> "Vehicles")
    apply {
        private _hashMap = createHashMap;
        _hashMap set ["className", toUpper configName _x];
        _hashMap set ["hitpoints", getNumber (_x >> "hitpoints")];
        _hashMap set ["armor", getArray (_x >> "armor")];
        _hashMap set ["isRecon", getNumber (_x >> "isRecon")];
        [toUpper configName _x, _hashMap]
    });

["AllVehicles", "HandleDamage", {
    // Nested call to allow using "exitWith" without leaving Event Handler
    _this call FUNC(handleDamage)
},
true,
["Man"],
true] call CBA_fnc_addClassEventHandler;

// ["AllVehicles", "HitPart", FUNC(hitPart)] call CBA_fnc_addClassEventHandler;

["AllVehicles", "Init", {
    // TODO: Check if waitAndExecute is needed
    params ["_entity"];

    #ifdef DEV_DEBUG
    diag_log format ["WARGAY DEBUG Init [%1]: Entity: %2, Type: %3", diag_tickTime, _entity, typeOf _entity];
    #endif

    private _vehicleHitpoints = [_entity, "hitpoints"] call FUNC(getVehicleInfo);
    if (_vehicleHitpoints isEqualTo objNull) then {
        private _defaultHitpoints = 10;
        _vehicleHitpoints = _defaultHitpoints;
        diag_log format ["WARGAY WARNING Hitpoints not defined for %1. Setting default hitpoints %2", typeof _entity, _defaultHitpoints];
    } else {
        diag_log format ["WARGAY DEBUG Hitpoints %1", str _vehicleHitpoints];
    };
    
    _entity setVariable ["MDL_currentHp", _vehicleHitpoints];
    _entity setVariable ["MDL_maxHp", _vehicleHitpoints];

    _entity addEventHandler ["HitPart", FUNC(hitPart)];

    // Increase fuel consumption;
    _entity setFuelConsumptionCoef 10;

    if (hasInterface) then {
        // TODO: Repair/rearm/refuel action handling
        [
            _entity,
            localize "str_state_repair",
            "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa",
            "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa",
            "_target getVariable ['MDL_currentHp', 0] < _target getVariable ['MDL_maxHp', 0]", // Condition show
            "true", // Condition progress
            {
                params ["_target"];

                // TODO: Stop action if unit shoots or gets damaged

                private _currentHp = _target getVariable ["MDL_currentHp", 0];
                private _maxHp = _target getVariable ["MDL_maxHp", MAX_HP];
                private _actualDuration = (_maxHp - _currentHp) * 5;
                // TODO: Shorten duration based on unit skill

                // Please forgive me for magically changing variable from unknown outer scope
                _duration = _actualDuration;

                // Determine at which steps we want to repair
                #define MAX_FRAME 24
                private _stepsToHeal = ceil ((_maxHp - _currentHp)/0.5);
                private _healEvery = MAX_FRAME / _stepsToHeal;
                private _lastHeal = MAX_FRAME;
                private _stepsWithRepair = [];
                while {(_stepsToHeal - 1) > count _stepsWithRepair} do {
                    _lastHeal = _lastHeal - _healEvery;
                    _stepsWithRepair pushBack (_lastHeal);
                };

                _target setVariable ["MDL_repairAtSteps", _stepsWithRepair];
            }, // Code start
            {
                params ["_target", "_caller", "_actionId", "_arguments", "_frame", "_maxFrame"];

                private _stepsWithRepair = _target getVariable ["MDL_repairAtSteps", []];
                if (_stepsWithRepair isEqualTo []) exitWith {};

                private _nextRepairStep = _stepsWithRepair select (count _stepsWithRepair - 1);
                
                if (_frame > _nextRepairStep) then {
                    private _maxHp = _target getVariable ["MDL_maxHp", MAX_HP];
                    private _currentHp = _target getVariable ["MDL_currentHp", MAX_HP];
                    private _newHp = (_currentHp + 0.5) min 10;
                    _target setVariable ["MDL_currentHp", _newHp, true];
                    _target setDamage ((_newHp/_maxHp) min 0.8);
                    systemChat format [LLSTRING(RepairProgress), _newHp, _maxHp];

                    _stepsWithRepair deleteAt (count _stepsWithRepair - 1);
                };
            }, // Code progress
            {
                params ["_target"];
                // TODO: Consider extracting healing to a separate function
                private _maxHp = _target getVariable ["MDL_maxHp", MAX_HP];
                _target setVariable ["MDL_currentHp", _maxHp, true];
                _target setDamage 0;
                systemChat LLSTRING(RepairFinished);
            }, // Code completed
            {
                params ["_target"];
                private _maxHp = _target getVariable ["MDL_maxHp", MAX_HP];
                private _currentHp = _target getVariable ["MDL_currentHp", MAX_HP];
                systemChat format [LLSTRING(RepairInterrupted), _currentHp, _maxHp];
            }, // Code interrupted,
            [], // Arguments
            1, // Duration (will be changed by codeStart)
            300, // Priority
            false // Remove completed
        ] call BIS_fnc_holdActionAdd;
    };
},
true, // Allow inheritance
["Man"], // Excluded classes
true /* Apply retroactive */] call CBA_fnc_addClassEventHandler;

addMissionEventHandler ["Draw3D", FUNC(draw3D)];

// addMissionEventHandler ["Draw3D", {
//     private _veh = cursorObject;

//     private _selectionNames = selectionNames _veh;

//     private _selectionNamesAndPos = _selectionNames apply {
//         [_x, _veh selectionPosition _x]
//     } select { _x select 1 isNotEqualTo [0, 0, 0]};

//     {
//         _x params ["_selectionName", "_selectionRelPos"];

//         private _worldPos = _veh modelToWorld _selectionRelPos;
//         drawIcon3D ["#(argb,8,8,3)color(1,1,1,1)", [1,1,1,1], _worldPos, 0.25, 0.25, 0, _selectionName, 0, 0.03];

//     } forEach _selectionNamesAndPos;
// }];

["CSLA_T72", [11, 6, 3, 2]];
["CSLA_T72M", [12, 7, 3, 2]];
["CSLA_T72M1", [14, 7, 3, 2]];
["CSLA_BVP1", [3, 1, 1, 1]];
["CSLA_BPzV", [3, 1, 1, 1]];
["CSLA_DTP90", [3, 1, 1, 1]];
["CSLA_MU90", [3, 1, 1, 1]];
["CSLA_OZV90", [3, 1, 1, 1]];
["CSLA_OT62", [2, 1, 1, 1]];
["CSLA_OT64C", [1, 1, 1, 1]];
["CSLA_OT64C_VB", [1, 1, 1, 1]];
["CSLA_OT65A", [1, 1, 1, 1]];
["AFMC_M1IP", [17, 7, 3, 3]];
["AFMC_M1A1", [17, 7, 4, 3]];
["AFMC_LAV25", [1, 1, 1, 1]];
["AFMC_M113_AMB", [1, 1, 1, 1]];
["AFMC_M113_DTP", [1, 1, 1, 1]];
["AFMC_M113", [1, 1, 1, 1]];
["AFMC_M163", [1, 1, 1, 1]];
["AFMC_M270", [1, 0, 0, 0]];

["MDL_showCurrentHp", {
    params ["_vehicle"];
    if (vehicle player isNotEqualTo _vehicle) exitWith {};

    private _string = [_vehicle, "_"] call FUNC(currentHpString);
    titleText ["\n\n\n\n\n" + _string, "PLAIN", 0.3, true];
}] call CBA_fnc_addEventHandler;
