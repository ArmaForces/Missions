#include "script_component.hpp"

// Disable CUP street lights based on lighting levels (bad performance script)
CUP_stopLampCheck = true;

[{alive player}, {
    // Dodanie akcji do zmiany odległości widzenia oraz nazw drużyn
    call FUNC(playerActions);
}, [], -1] call CBA_fnc_waitUntilAndExecute;

GVAR(isSoundPlaying) = false;

// Register a simple keypress to an action
#include "\a3\ui_f\hpp\defineDIKCodes.inc"

// Handle "Info" button
[
    "MDL Wargay",
    "MDL_WG_UnitInfo",
    ["Unit Info", "Opens info popup of targeted unit"],
    FUNC(keyUnitInfo),
    {},
    [DIK_TAB, [false, false, false]]
] call CBA_fnc_addKeybind;

["MDL_showCurrentHp", {
    if (vehicle player isEqualTo player) exitWith {};
    call FUNC(updateHitpointsDisplay);
}] call CBA_fnc_addEventHandler;

["MDL_rearmVehicle", FUNC(rearmVehicle)] call CBA_fnc_addEventHandler;
["MDL_applyDamage", {
    params ["_unit"];
    
    if (GVAR(damageAlarmEnabled) && {_unit isEqualTo vehicle player} && {!GVAR(isSoundPlaying)}) then {
        GVAR(isSoundPlaying) = true;
        playSound ["MDL_Wargay_Alarm", 2];
        [{
            GVAR(isSoundPlaying) = false;
        }, [], 4] call CBA_fnc_waitAndExecute;
    };
}] call CBA_fnc_addEventHandler;

["MDL_createVehicleFailed", {
    systemChat LLSTRING(DeploymentFailure);
}] call CBA_fnc_addEventHandler;

["MDL_unitLost", {
    params ["_unit"];
    private _vehicleDisplayName = [_unit] call FUNC(getVehicleDisplayName);
    private _crewNames = crew _unit apply {name _x};
    if (_crewNames isEqualTo []) then { _crewNames = ""; };
    [WEST, "HQ"] commandChat format [LLSTRING(UnitLost), _vehicleClassName, str _crewNames];
}] call CBA_fnc_addEventHandler;

["MDL_vehicleDeployment", {
    params ["_vehicleClassName"];
    private _vehicleInfo = VehicleTypes getOrDefault [toUpper _vehicleClassName, ""];
    private _vehicleName = if (_vehicleInfo isNotEqualTo "") then {
        [_vehicleInfo] call FUNC(getVehicleDisplayName)
    } else {
        _vehicleClassName
    };

    [WEST, "HQ"] commandChat format [LLSTRING(DeploymentOfVehicle), _vehicleName];
}] call CBA_fnc_addEventHandler;

["MDL_vehicleDeploymentNoLongerPossible", {
    params ["_vehicleClassName"];
    private _vehicleInfo = VehicleTypes getOrDefault [toUpper _vehicleClassName, ""];
    private _vehicleName = if (_vehicleInfo isNotEqualTo "") then {
        [_vehicleInfo] call FUNC(getVehicleDisplayName)
    } else {
        _vehicleClassName
    };

    [WEST, "HQ"] commandChat format [LLSTRING(DeploymentOfVehicleNoLongerPossible), _vehicleName];
}] call CBA_fnc_addEventHandler;

["MDL_xpReceived", {
    params ["_receivedXp", "_newLifeXp", "_newTotalXp"];

    systemChat format [LLSTRING(XpReceived), _receivedXp, _newTotalXp];
}] call CBA_fnc_addEventHandler;

addMissionEventHandler ["Draw3D", FUNC(draw3D)];
