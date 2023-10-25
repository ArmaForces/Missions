#include "script_component.hpp"

GVAR(allDocuments) = createHashMap;
call FUNC(initDocuments);

GVAR(cbRadioPresetInitialized) = false;
GVAR(customLocations) = call FUNC(initCustomLocations);
publicVariable QGVAR(customLocations);

// Setup weather
ACEGVAR(weather,currentTemperature) = 2;
publicVariable QACEGVAR(weather,currentTemperature);
ACEGVAR(weather,currentHumitidy) = 0.70;
publicVariable QACEGVAR(weather,currentHumitidy);
0 setOvercast 0.1;
0 setFog [0.5, 0.01, 250];

// Setup custom chat channels for scripts
private _channelName = LSTRING(Emergency_Channel);
GVAR(emergencyNetId) = radioChannelCreate [[0.96, 0.3, 0.1, 1], _channelName, "112: %UNIT_NAME", []];
publicVariable QGVAR(emergencyNetId);

private _channelName = LSTRING(Zeus_Channel);
GVAR(zeusNetId) = radioChannelCreate [[1.0, 0.8, 0.8, 1], _channelName, "ZEUS: %UNIT_NAME", []];
publicVariable QGVAR(zeusNetId);

// Setup all vehicles with randomized stuff
{
    if (fuel _x isEqualTo 1) then {
        _x setFuel random 0.8 + 0.2;
    };

    if (random 1 > (1 - VEHICLE_LOCKED_CHANCE)) then {
        [_x, 2] remoteExec ["lock", _x];
        // [QACEGVAR(vehiclelock,setVehicleLock), [_x, true], [_x]] call CBA_fnc_targetEvent;
    };

    if (!(_x isKindOf "LandVehicle")) exitWith {};

    if (typeOf _x isEqualTo "RDS_Ikarus_Civ_01") then {
        _x setObjectTextureGlobal [0, "z\aftm\addons\cup_vehicles\data\bus_exterior_co_no_plate.paa"];
    };

    _x addItemCargoGlobal ["ACE_fieldDressing", ceil random 2 + 4];
    _x addItemCargoGlobal ["ACE_tourniquet", round random 1 + 1];
    _x addItemCargoGlobal ["rds_car_warning_triangle_to11", 1];

    private _isMilitiaVehicle = typeOf _x in ["CUP_LADA_LM_CIV", "CUP_C_S1203_Militia_CIV"];
    if (_isMilitiaVehicle) then {
        [_x, WEST] call FUNC(initCbRadio);
        _x setVariable ["ace_vehiclelock_lockSide", WEST, true];
    } else {
        private _vehicleSide = [_x] call BIS_fnc_objectSide;
        [_x, _vehicleSide] call FUNC(initCbRadio);
    };
} forEach vehicles;

/*
    Register Event Handlers
*/

[QGVAR(addDocument), {
    _this call FUNC(addDocument);
}] call CBA_fnc_addEventHandler;

[QGVAR(carAlarm), FUNC(carAlarm)] call CBA_fnc_addEventHandler;

[QGVAR(assignDocumentsToPlayer), FUNC(assignDocumentsToPlayer)] call CBA_fnc_addEventHandler;

/* MISSION FLOW */

[{dayTime > 7 - (7/60)},{
    ["ProtestStarts"] call CBA_fnc_serverEvent;
    [{
        private _areaId = mkr_buildable_protestPosters getVariable ["afmf_buildables_area", ""];
        ["afmf_buildables_deliverSupply", [_areaId]] call CBA_fnc_serverEvent;

        ["ProtestStarted"] call CBA_fnc_serverEvent;

        private _areaId = mkr_buildable_protestGarbage getVariable ["afmf_buildables_area", ""];
        ["afmf_buildables_deliverSupply", [_areaId]] call CBA_fnc_serverEvent;
    }] call CBA_fnc_waitAndExecute;
}, []] call CBA_fnc_waitUntilAndExecute;
