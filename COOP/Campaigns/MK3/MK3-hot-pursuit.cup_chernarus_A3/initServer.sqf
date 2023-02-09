#include "script_component.hpp"

{
    if (fuel _x isEqualTo 1) then {
        _x setFuel random 0.8 + 0.2;
    };
} forEach vehicles;

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

["DoorsBreached", {
    [{
        ["ResistanceTimeToRun"] call CBA_fnc_globalEvent;
    }, [], 75] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;
