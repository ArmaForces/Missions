#include "script_component.hpp"

GVAR(allDocuments) = createHashMap;
GVAR(cbRadioPresetInitialized) = false;
GVAR(customLocations) = call FUNC(initCustomLocations);
publicVariable QGVAR(customLocations);

private _channelName = "EmergencyNet";
GVAR(emergencyNetId) = radioChannelCreate [[0.96, 0.3, 0.1, 1], _channelName, "112: %UNIT_NAME", []];
[GVAR(emergencyNetId), {_this radioChannelAdd [player]}] remoteExec ["call", [0, -2] select isDedicated, _channelName];
publicVariable QGVAR(emergencyNetId);

private _channelName = "ZeusNet";
GVAR(zeusNetId) = radioChannelCreate [[1.0, 0.8, 0.8, 1], _channelName, "ZEUS: %UNIT_NAME", []];
[GVAR(zeusNetId), {_this radioChannelAdd [player]}] remoteExec ["call", [0, -2] select isDedicated, _channelName];
publicVariable QGVAR(zeusNetId);

{
    if (fuel _x isEqualTo 1) then {
        _x setFuel random 0.8 + 0.2;
    };

    if (typeOf _x isEqualTo "RDS_Ikarus_Civ_01") then {
        _x setObjectTextureGlobal [0, "z\aftm\addons\cup_vehicles\data\bus_exterior_co_no_plate.paa"];
    };

    _x addItemCargoGlobal ["ACE_fieldDressing", ceil random 2 + 4];
    _x addItemCargoGlobal ["ACE_tourniquet", round random 1 + 1];

    if (random 1 > (1 - VEHICLE_LOCKED_CHANCE)) then {
        [_x, true] call ACE_vehiclelock_fnc_setVehicleLockEH;
    };

    private _isMilitiaVehicle = typeOf _x in ["CUP_LADA_LM_CIV", "CUP_C_S1203_Militia_CIV"];
    if (_isMilitiaVehicle) then {
        _x setVariable ["ace_vehiclelock_lockSide", WEST];
    };
} forEach vehicles;

call FUNC(initDocuments);

[QGVAR(addDocument), {
    _this call FUNC(addDocument);
}] call CBA_fnc_addEventHandler;

[QGVAR(carAlarm), FUNC(carAlarm)] call CBA_fnc_addEventHandler;

// 0 setFog 0.2;
// 0 setOvercast 1;
// 0 setRain 1;
// setHumidity 0.95;
// enableEnvironment [false, true];
// forceWeatherChange;

// [
//  "a3\data_f\snowflake4_ca.paa", // rainDropTexture
//  4, // texDropCount
//  0.01, // minRainDensity
//  50, // effectRadius
//  100, // windCoef
//  1.5, // dropSpeed
//  0.5, // rndSpeed
//  0.5, // rndDir
//  0.07, // dropWidth
//  0.07, // dropHeight
//  [1, 1, 1, 0.5], // dropColor
//  1, // lumSunFront
//  1, // lumSunBack
//  1, // refractCoef
//  1, // refractSaturation
//  true, // snow
//  false // dropColorStrong
// ]
// call BIS_fnc_setRain;

// PP_colorC = ppEffectCreate ["ColorCorrections",1500];
// PP_colorC ppEffectEnable true;
// PP_colorC ppEffectAdjust [1,1,0,[0,0,0,0],[1,1,1.5,0.78],[0.33,0.33,0.57,0],[0,0,0,0,0,0,4]];
// PP_colorC ppEffectCommit 0;

// Date YYYY-MM-DD-HH-MM: [2035,6,24,8,0]. Overcast: 0.3. Fog: 0.0842137. Fog params: [0.0800008,0.013,0]
// GF PostProcess Editor parameters: Copy the following line to clipboard and click Import in the editor.
//[[false,100,[0.05,0.05,0.3,0.3]],[false,200,[0.05,0.05,true]],[false,300,[1,0.2,0.2,1,1,1,1,0.05,0.01,0.05,0.01,0.1,0.1,0.2,0.2]],[true,1500,[1,1,0,[0,0,0,0],[1,1,1.5,0.78],[0.33,0.33,0.57,0],[0,0,0,0,0,0,4]]],[false,500,[1]],[false,2000,[0.2,1,1,0.5,0.5,true]],[false,2500,[1,1,1]]]

