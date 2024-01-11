
params [
    ["_spawner", nil, [objNull]],
    ["_side", nil, [sideUnknown]]
];

private _preset = MDL_PVP_preset get _side;
private _class =  _preset get "plane";

diag_log text format ["[PVP] DEBUG: spawnPlane - spawning %1 for %2 at %3", _class, _side, _spawner];

private _plane = createVehicle [_class, [0,0,0], [], 0, "NONE"];
_plane setPosASL getPosASL _spawner;
_plane setDir getDir _spawner;

// handle plane being shot down
_plane setVariable ["MDL_PVPJets_side", _side];
_plane addEventHandler ["Killed", {call MDL_PvPJets_fnc_onPlaneKilled}];
_plane addEventHandler ["GetOut", {call MDL_PvPJets_fnc_onPlaneGetOut}];

if (_preset getOrDefault ["loadout", []] isNotEqualTo []) then {
    diag_log text "[PVP] DEBUG: spawnPlane - adjusting pylon loadout";

    private _turret = [-1];
    private _previousTurretPylonsMagazines = getAllPylonsInfo _plane select {(_x select 2) isEqualTo _turret} apply {_x select 3};
    _previousTurretPylonsMagazines = (_previousTurretPylonsMagazines arrayIntersect _previousTurretPylonsMagazines);

    {
        [_plane, (_x + [true])] remoteExec ["setPylonLoadout", 0];
    } forEach (_preset get "loadout");
    
    private _currentTurretPylonsMagazines = getAllPylonsInfo _plane select {(_x select 2) isEqualTo _turret} apply {_x select 3};
    _currentTurretPylonsMagazines = (_currentTurretPylonsMagazines arrayIntersect _currentTurretPylonsMagazines);
    
    //---- remove pylon weapons without magazines
    private _pylonsWeapons = _currentTurretPylonsMagazines apply {getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon")};
    {
        private _magazine = _x;
        private _magazineWeapon = getText (configFile >> "CfgMagazines" >> _magazine >> "pylonWeapon");
        // remove weapon if none of the loaded pylons use it
        // do not optimize with `in` or `find` as these are case sensitive
        if (_pylonsWeapons findIf {_magazineWeapon == _x} > -1) then {continue};
        [_plane, [_magazineWeapon, _turret]] remoteExec ["removeWeaponTurret", 0];
    } forEach _previousTurretPylonsMagazines;
};

if (_preset getOrDefault ["textures", []] isNotEqualTo []) then {
    diag_log text "[PVP] DEBUG: spawnPlane - adjusting textures";
    {
        _plane setObjectTextureGlobal _x;
    } forEach (_preset get "textures");
};

_plane setVehicleReportOwnPosition true;
_plane setVehicleReportRemoteTargets true;
_plane setVehicleReceiveRemoteTargets true;

_plane allowDamage false;
[{_this allowDamage true}, _plane, 10] call CBA_fnc_waitAndExecute;

if (ACRE_Loaded) then {
    private _radioPreset = MDL_PVP_Radio_Presets_Hash get _side;
    diag_log text format ["[PVP] DEBUG: spawnPlane - radioPreset %1", _radioPreset];
    [_plane, _radioPreset] call acre_api_fnc_setVehicleRacksPreset;
};

_plane // return
