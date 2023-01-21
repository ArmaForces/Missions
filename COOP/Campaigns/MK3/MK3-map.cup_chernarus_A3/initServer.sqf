// Classes or models of objects to remove
private _rm = [

    // Containers
    "cargo20_military_green_f.p3d",
    "misc_cargo1a.p3d",
    "misc_cargo1b.p3d",
    "misc_cargo1c.p3d",
    "misc_cargo1d.p3d",
    "misc_cargo1e.p3d",
    "misc_cargo1f.p3d",
    "misc_cargo2a.p3d",
    "misc_cargo2b.p3d",
    "misc_cargo2c.p3d",
    "misc_cargo2d.p3d",
    "misc_cargo2e.p3d",

    // Train
    "loco_742_blue.p3d",
    "wagon_box.p3d",
    "wagon_flat.p3d",

    // Wrecks
    "wreck_brdm2_f.p3d",
    "v3s_wreck_f.p3d",
    "wreck_ural_f.p3d",
    "wreck_uaz_f.p3d",
    "wreck_skodovka_f.p3d",
    "datsun01t.p3d",
    "datsun02t.p3d",
    "hiluxt.p3d",
    "wreck_van_f.p3d",
    "wreck_car_f.p3d",

    // Trash
    "garbagebags_f.p3d",
    "garbage_square1_f.p3d",
    "garbage_square2_f.p3d",
    "garbage_square3_f.p3d",
    "garbage_square4_f.p3d",
    "garbage_square5_f.p3d",
    "ground_garbage_long.p3d",
    "ground_garbage_square1.p3d",
    "ground_garbage_square2.p3d",
    "ground_garbage_square3.p3d",
    "ground_garbage_square4.p3d",
    "ground_garbage_square5.p3d",
    "garbagepallet_f.p3d",
    "garbage_paleta.p3d",
    "garbagewashingmachine_f.p3d",
    "garbage_misc.p3d",
    "junkpile_f.p3d",
    "junkpile.p3d",
    "pallet_f.p3d",
    "pallets_f.p3d",
    "paletyc.p3d"
];

private _pos = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
private _toHide = nearestObjects [_pos, [], worldSize, false];
private _toHideFiltered = _toHide select {typeOf _x in _rm || {((getModelInfo _x)#0) in _rm}};

{
    _x hideObjectGlobal true;
} forEach _toHideFiltered;



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