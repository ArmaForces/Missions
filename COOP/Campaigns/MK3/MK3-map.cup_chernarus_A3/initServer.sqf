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
