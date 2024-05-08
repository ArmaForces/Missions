#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 * Retrieves vehicle info hashmap for given unit or group (leader vehicle) if available.
 *
 * Arguments:
 * 0: Unit or group to get its vehicle <OBJECT/GROUP>
 * 1: Unit info key <STRING> (Optional, if empty whole hashmap is returned)
 * 2: Default value if key or unit info doesn't exist <ANY>
 *
 * Return Value:
 * Unit info <HASHMAP> or <ANY> retrieved or default value
 *
 * Public: No
 */

params ["_unitOrGroup"/*, ["_key", ""], ["_defaultValue", objNull]*/];

private _vehicle = if (_unitOrGroup isEqualType objNull) then {
    vehicle _unitOrGroup
} else {
    vehicle leader _unitOrGroup
};

private _vehicleInfo = [_vehicle] call FUNC(getVehicleInfo);

private _ammoInfo = _vehicleInfo getOrDefault [AMMO_PROPERTY, objNull];
if (_ammoInfo isEqualTo objNull) then {
	private _vehicleClassName = _vehicleInfo get CLASS_NAME_PROPERTY;

	diag_log format ["DDd %1", _vehicleClassName];

	private _magazines = getArray (configFile >> "CfgVehicles" >> _vehicleClassName >> "Turrets" >> "MainTurret" >> "magazines");
	_magazines = _magazines arrayIntersect _magazines;

	diag_log format ["Ddd mags: %1", str _magazines];

	private _ammo = _magazines apply {
 		[_x, getText (configFile >> "CfgMagazines" >> _x >> "ammo")]
	}
	apply {
  		[_x select 0, AmmoTypes getOrDefault [toUpper (_x select 1), objNull]];
	}
	select {_x select 1 isNotEqualTo objNull}
	apply {
  		(_x select 1) set ["displayNameShort", getText (configFile >> "CfgMagazines" >> (_x select 0) >> "displayNameShort")];
  		_x select 1
	};

	diag_log ["Ddd ammo: %1", str _ammo];

	private _ammoInfo = createHashMap;
	{
		_ammoInfo set [_x get CLASS_NAME_PROPERTY, _x];
	} forEach _ammo;

	diag_log ["Ddd ammo info: %1", str _ammoInfo];
	
	_vehicleInfo set [AMMO_PROPERTY, _ammoInfo];
	diag_log ["Ddd vehicle info: %1", str _vehicleInfo];
};

_ammoInfo


/*

private _unitClassName = toUpper typeOf _unit;

private _ammoInfo = AmmoTypes getOrDefault [_unitClassName, objNull];

// Handle classes that have a parent configured
if (_ammoInfo isEqualTo objNull) then {

    private _parentClassNames = [configOf _unit, true] call BIS_fnc_returnParents;

    LOG_3("Not found info for '%1'. Found %2 parents: %3",_unitClassName,count _parentClassNames,str _parentClassNames);

    while {_ammoInfo isEqualTo objNull && {count _parentClassNames > 0}} do {
        private _parent = _parentClassNames deleteAt 0;
        _ammoInfo = VehicleTypes getOrDefault [toUpper _parent, objNull];
    };

    if (_ammoInfo isNotEqualTo objNull) then {
        LOG_3("Found matching parent '%1' for '%2' with vehicle info: %3",_ammoInfo get CLASS_NAME_PROPERTY,_unitClassName,str _ammoInfo);
        
        _ammoInfo set [CLASS_NAME_PROPERTY, _unitClassName];
        _ammoInfo set [DISPLAY_NAME_PROPERTY, getText (configFile >> "CfgVehicles" >> _unitClassName >> DISPLAY_NAME_PROPERTY)];
        VehicleTypes set [_unitClassName, _ammoInfo];

        LOG_1("Saved vehicle info: '%1'",str _ammoInfo);
    } else {
        _ammoInfo = [_unit] call FUNC(createVehicleInfoForNonConfiguredVehicle);
        LOG_2("Parent not found for '%1', created dummy info: %2",_unitClassName,str _ammoInfo);
    };
};

LOG_2("Found vehicle info for '%1': %2",_unitClassName,str _ammoInfo);

/*if (_key isEqualTo "") exitWith { _ammoInfo };

_ammoInfo getOrDefault [_key, _defaultValue]*/


// _hashMap set [DISPLAY_NAME_PROPERTY, getText (configFile >> "CfgAmmo" >> configName _x >> DISPLAY_NAME_PROPERTY)];

/*
	private _vehicle = get3DENSelected "Object" select 0;
_vehicle = vehicle player;

private _magazines = getArray (configOf _vehicle >> "Turrets" >> "MainTurret" >> "magazines");
_magazines = _magazines arrayIntersect _magazines;

private _ammo = _magazines apply {
 [_x, getText (configFile >> "CfgMagazines" >> _x >> "ammo")]
};

_ammo apply {
  [_x select 0, AmmoTypes getOrDefault [toUpper (_x select 1), objNull]];
} select {_x select 1 isNotEqualTo objNull}
apply {
  (_x select 1) set ["displayNameShort", getText (configFile >> "CfgMagazines" >> (_x select 0) >> "displayNameShort")];
  _x select 1
}

 */