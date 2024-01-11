
MDL_PVP_Radio_Presets_Hash = createHashmapFromArray [
    [WEST, "blufor"],
    [EAST, "redfor"]
];

private _l159PylonLoadout = [
    ["Pylons1", "PylonWeapon_300Rnd_20mm_shells"],
    ["Pylons2", "PylonRack_7Rnd_Rocket_04_HE_F"],
    ["Pylons3", "PylonRack_7Rnd_Rocket_04_HE_F"],
    ["Pylons4", "PylonWeapon_300Rnd_20mm_shells"],
    ["Pylons5", "PylonRack_7Rnd_Rocket_04_HE_F"],
    ["Pylons6", "PylonRack_7Rnd_Rocket_04_HE_F"],
    ["Pylons7", "PylonWeapon_300Rnd_20mm_shells"]
];

MDL_PVP_presetsHash = createHashMapFromArray [
    ["L159", createHashMapFromArray [
        ["displayName", "L159"],
        [WEST, createHashMapFromArray [
            ["plane", "I_Plane_Fighter_03_dynamicLoadout_F"],
            ["loadout", _l159PylonLoadout],
            ["textures", [
                [0, "#(rgb,8,8,3)color(0,1,0,0.2)"],
                [1, "#(rgb,8,8,3)color(0,1,0,0.2)"]
            ]]
        ]],
        [EAST, createHashMapFromArray [
            ["plane", "I_Plane_Fighter_03_dynamicLoadout_F"],
            ["loadout", _l159PylonLoadout],
            ["textures", [
                [0, "#(rgb,8,8,3)color(1,0,0,0.2)"],
                [1, "#(rgb,8,8,3)color(1,0,0,0.2)"]
            ]]
        ]]
    ]]
];
