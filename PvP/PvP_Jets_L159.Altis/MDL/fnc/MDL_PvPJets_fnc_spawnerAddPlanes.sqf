/* VEHICLE SPAWNER
Adds vehicles to vehicle spawn actions list.

Params:
0: <OBJECT> - object which has spawn action assigned
1: <SIDE> - which planes should be available

Return value:
None

Example:
[_spawner, WEST] spawn MDL_PvPJets_fnc_spawnerAddPlanes;;

Locality:
Runs local. Effect local.
*/

params ["_spawner","_side"];

if (_side == WEST) then {
	_planes = PvPJets_Planes_BLU;
} else {
	_planes = PvPJets_Planes_RED;
};

// Loop through _planes array to find and add all vehicles
{
	_vehicle_cost = _x select 0;
	_vehicle_name = _x select 1;
	_vehicle_classname = _x select 2;
	_vehicle_loadouts = _x select 3;
	_vehicle_textures = _x select 4;
	{
		_vehicle_name = format ["[%1] %2 (%3)", _vehicle_cost, _vehicle_name, _x];
		// Add action to _spawner that spawns _vehicle_classname.
		_spawner addAction [_vehicle_name, {
			_spawner = _this select 0;
			// Find nearby helipads and select nearest as vehicle spawn point.
			_helipad = ((nearestObjects [_spawner, [plane_spawn_location],50]) select {typeOf _x == plane_spawn_location}) select 0;
			// Clear spawn point area.
			_clear = nearestObjects [_helipad, ["AllVehicles"], 25];
			if (_clear > 0) exitwith {titleText ["Punkt spawnu jest zajęty","PLAIN"]};
			sleep 0.5;
			// Spawn vehicle and set direction
			_vehicle_classname = _this select 3 select 0;
			_vehicle_loadout = _this select 3 select 1;
			_veh = _vehicle_classname createVehicle (getpos _helipad);
			_veh setDir (getDir _helipad);
			[_veh] spawn MDL_fnc_vehicleEH;
			[side player,-(_vehicle_cost)] call BIS_fnc_respawnTickets;
			sleep 0.5;
			// Clear vehicle cargo
			[_veh] remoteExec ["clearMagazineCargo",0];
			[_veh] remoteExec ["clearWeaponCargo",0];
			clearItemCargoGlobal _veh;
			//Set plane loadout
			[_veh, _vehicle_loadout] call MDL_PvPJets_fnc_planeChangeLoadout;
			//Set texture
			if (_vehicle_textures != []) then {
				_i = 0;
				{
					_veh setObjectTextureGlobal [_i, _x];
					_i = _i + 1;
				} forEach _vehicle_textures;
			};
		}, [_vehicle_classname,_x], 6, true, true, "", "true", 2];
	} forEach _vehicle_loadouts;
} forEach _planes;