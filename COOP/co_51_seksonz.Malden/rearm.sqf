/*
this addAction 
[
    "Przebrajanie", 
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        [_target] call AF_fnc_casRearmOpen;
    },
    [],
    10, 
    true, 
    true, 
    "",
    "true",
    2,
    false,
    "",
    ""
];
*/

// cas ammo
private _AF_casAmmo = [
	["rhs_mag_30x113mm_M789_HEDP_1200", 1200],
	["rhs_mag_M151_19", 38],
	["rhsusf_M130_CMFlare_Chaff_Magazine_x2", 672],
	["PylonRack_4Rnd_ACE_Hellfire_AGM114N", 4],
	["PylonRack_4Rnd_ACE_Hellfire_AGM114K", 8]
];
_AF_casAmmo sort true;

private _AF_vehAmmo = [
	["sfp_40mm_apfsds_16rnd", 256],
	["sfp_40mm_hei_8rnd", 256],
	["sfp_100Rnd_762x51_ksp58", 2000],
	// M163 Vulcan ammo
	["CUP_1100Rnd_TE1_Red_Tracer_20mm_M168_M", 40],
	// Smoke
	["SmokeLauncherMag", 10]
];
_AF_vehAmmo sort true;

AF_fnc_setPylon = {
	params ["_controller", "_vehicle", "_pylon", "_newAmmoType", "_setAmmoCount"];
	
	_vehicle setPylonLoadout [_pylon, _newAmmoType];
	_vehicle setAmmoOnPylon [_pylon, _setAmmoCount];

	[_controller] remoteExecCall ["AF_fnc_casRearmRefreshServer", 2, false];
};

AF_fnc_setMagazines = {
	params ["_controller", "_vehicle", "_ammoName", "_newMagazines", "_path"];
	if !(_vehicle turretLocal _path) exitWith {};
	_vehicle removeMagazinesTurret [_ammoName,_path];
	{
		_vehicle addMagazineTurret _x;
	}forEach _newMagazines;

	[_controller] remoteExecCall ["AF_fnc_casRearmRefreshServer", 2, false];
};

AF_fnc_casRearmRefreshServer = {
	params [["_controller", objNull]];
	private _AF_casAmmo = _controller getVariable ["AF_casAmmo", []];
	[_controller, _AF_casAmmo] remoteExecCall ["AF_fnc_casRearmRefresh", 0, false];
};

if (isServer) then {
	terminal setVariable ["AF_casAmmo", _AF_casAmmo];
	[terminal, _AF_casAmmo] remoteExecCall ["AF_fnc_casRearmRefresh", 0, str terminal];
};
if (isServer) then {
	ammoContainer setVariable ["AF_casAmmo", _AF_vehAmmo];
	[ammoContainer, _AF_vehAmmo] remoteExecCall ["AF_fnc_casRearmRefresh", 0, str ammoContainer];
};

AF_fnc_casRearmOpen = {
	params [["_controller", objNull]];
	AF_casRearmController = _controller;
	disableSerialization;
	createDialog "AF_dlg_rearm";
	call AF_fnc_CasRearmInfoUpdate;
};

AF_fnc_casRearmRefresh = {
	params [["_controller", objNull],["_AF_casAmmo",[]]];
	if !(isServer) then {
		_controller setVariable ["AF_casAmmo", _AF_casAmmo];
	};
	if ((findDisplay 20) isEqualTo displayNull) exitWith {};
	[missionNameSpace getVariable ["AF_casRearmController", objNull]] call AF_fnc_CasRearmInfoUpdate;
	[missionNameSpace getVariable ["AF_casRearmController", objNull]] call AF_fnc_casRearmSlotSelect;
};
[terminal, _AF_casAmmo] remoteExecCall ["AF_fnc_casRearmRefresh", 0, false];
[ammoContainer, _AF_casAmmo] remoteExecCall ["AF_fnc_casRearmRefresh", 0, false];

AF_fnc_findVeh = {
	params [["_controller", objNull]];
	private _position = _controller getVariable ["position", (getposATL _controller)];
	private _distance = _controller getVariable ["distance", 15];
	private _vehType = _controller getVariable ["rearmVehType","AIR"];
	private _vehicle = nearestObject [_position, _vehType];
	_vehicle
};

AF_fnc_CasRearmInfoUpdate = {
	params [["_controller", objNull]];
	lbClear 1501;
	lbClear 1502;
	if !(alive _controller) exitWith {
		lbClear 1503;
	};
	private _vehicle = [_controller] call AF_fnc_findVeh;
	if !(alive _vehicle) exitWith {
		lbClear 1503;
	};

	toFixed 0;

	private _ctrlVehInfo = (findDisplay 20) displayCtrl 1501;
	private _vehicleName = getText (configfile >> "CfgVehicles" >> typeOf _vehicle >> "displayName");
	private _row = _ctrlVehInfo lnbAddRow ["Pojazd"];
	_ctrlVehInfo lnbAddRow [_vehicleName];
	_ctrlVehInfo lnbAddRow [""];
	_ctrlVehInfo lnbAddRow ["Stan pojazdu"];
	_ctrlVehInfo lnbAddRow [format ["%1%2",(1 - damage _vehicle) * 100, "%"]];
	_ctrlVehInfo lnbAddRow [""];
	_ctrlVehInfo lnbAddRow ["Ilośc paliwa"];
	_ctrlVehInfo lnbAddRow  [format ["%1%2", fuel _vehicle * 100, "%"]];

	toFixed -1;

	private _ctrlAmmoInfo = (findDisplay 20) displayCtrl 1502;
	private _row = _ctrlAmmoInfo lnbAddRow [
		"",
		"wszystkie dostępne"
	];
	lnbSetValue [1502, [_row, 0], 0];
	lnbSetData [1502, [_row, 0],"pylon"];
	
	private _pylonsAmmo = [];

	{
		_pylonsAmmo pushBackUnique _x;
		private _magName = getText(configFile >> "CfgMagazines" >> _x >> "DisplayName");
		private _currentMagCount = ( _vehicle ammoOnPylon (_forEachIndex + 1)) max 0;
		private _fullMagcount = getNumber(configFile >> "CfgMagazines" >> _x >> "count");

		if (_magName isEqualTo "") then {
			_magName = "< brak >"
		};
		private _row = _ctrlAmmoInfo lnbAddRow [
			str (_forEachIndex + 1),
			_magName select [0,20],
			format ["%1/%2", _currentMagCount, _fullMagcount]
		];
		lnbSetValue [1502, [_row, 0], _forEachIndex + 1];
		lnbSetData [1502, [_row, 0],"pylon"];
	} forEach (getPylonMagazines _vehicle);

	// mags
	{
		_x params ["_ammoName", "_path", "_currentMagCount", "_id", "_creator"];
		// workaround for pylons / magazines duplication
		if !(_ammoName in _pylonsAmmo) then {
			private _magName = getText(configFile >> "CfgMagazines" >> _ammoName >> "DisplayName");
			if (_magName == "") then {
				_magName = _ammoName;
			};
			private _fullMagcount = getNumber(configFile >> "CfgMagazines" >> _ammoName >> "count");
			
			private _row = _ctrlAmmoInfo lnbAddRow [
				"",
				_magName select [0,20],
				format ["%1/%2",_currentMagCount, _fullMagcount max 1]
			];

			lnbSetValue [1502, [_row, 0], _forEachIndex];
			lnbSetData [1502, [_row, 0],"magazine"];
		};
	} forEach magazinesAllTurrets _vehicle;
};

AF_fnc_casRearmSlotSelect = {
	params [["_controller", objNull]];

	private _pylon = lnbValue [1502, [lbCurSel 1502, 0]];
	private _rearmMode = lnbData [1502, [lbCurSel 1502, 0]];
	lbClear 1503;
	private _ctrlAmmoAvaible = (findDisplay 20) displayCtrl 1503;

	private _AF_casAmmo = _controller getVariable ["AF_casAmmo", []];
	if (_pylon <= 0 && _rearmMode isEqualTo "pylon") exitWith {
		// all compatibile magazines
		{
			private _ammoName = _x select 0;
			private _ammoCount = _x select 1;
			private _magName = getText(configFile >> "CfgMagazines" >> _ammoName >> "DisplayName");
			if (_magName isEqualTo "") then {
				_magName = _ammoName;
			};
			private _fullMagcount = getNumber(configFile >> "CfgMagazines" >> _ammoName >> "count");
			private _row = _ctrlAmmoAvaible lnbAddRow [
				_magName select [0,20],
				str _ammoCount,
				format ["(%1)", _fullMagcount max 1]
			];
			lnbSetValue [1503, [_row, 0], _index];
		} forEach _AF_casAmmo;
		if (lbCurSel 1503 isEqualTo -1) then {
			_ctrlAmmoAvaible lbSetCurSel 0;
		};
	};
	private _vehicle = [_controller] call AF_fnc_findVeh;
	if !(alive _vehicle) exitWith {};

	if (_rearmMode isEqualTo "magazine") exitWith {
		private _allMagazines = magazinesAllTurrets _vehicle;
		private _rearmMagazineArray = _allMagazines deleteAt _pylon;
		_rearmMagazineArray params ["_ammoName", "_path", "_currentMagCount", "_id", "_creator"];
		{
			_x params ["_xAmmoName", "_xAmmoCount"];
			if (_ammoName isEqualTo _xAmmoName) then {
				private _magName = getText(configFile >> "CfgMagazines" >> _ammoName >> "DisplayName");
				if (_magName isEqualTo "") then {
					_magName = _ammoName;
				};
				private _fullMagcount = getNumber(configFile >> "CfgMagazines" >> _ammoName >> "count");
				private _row = _ctrlAmmoAvaible lnbAddRow [
					_magName select [0,20],
					str _xAmmoCount,
					format ["(%1)", _fullMagcount max 1]
				];
				lnbSetValue [1503, [_row, 0], _forEachIndex];
			};
		}forEach _AF_casAmmo;
		if (lbCurSel 1503 isEqualTo -1) then {
			_ctrlAmmoAvaible lbSetCurSel 0;
		};
	};

	private _pylons = (_vehicle getCompatiblePylonMagazines _pylon);
	{
		private _index = _forEachIndex;
		private _ammoName = _x select 0;
		private _ammoCount = _x select 1;
		{
			if (_ammoName == _x) exitWith {
				private _magName = getText(configFile >> "CfgMagazines" >> _ammoName >> "DisplayName");
				if (_magName isEqualTo "") then {
					_magName = _ammoName;
				};
				private _fullMagcount = getNumber(configFile >> "CfgMagazines" >> _ammoName >> "count");
				private _row = _ctrlAmmoAvaible lnbAddRow [
					_magName select [0,20],
					str _ammoCount,
					format ["(%1)", _fullMagcount max 1]
				];
				lnbSetValue [1503, [_row, 0], _index];
			};
		} forEach _pylons;
	} forEach _AF_casAmmo;
	if (lbCurSel 1503 isEqualTo -1) then {
		_ctrlAmmoAvaible lbSetCurSel 0;
	};
};

AF_fnc_casRearmAddMag = {
	params [["_controller",objNull],["_pylon",-1],["_rearmMode",""],["_ammoSelectedIndex",-1],["_rearmFullMag", false]];
	if (_pylon <= 0 && _rearmMode isEqualTo "pylon") exitWith {};
	private _vehicle = [_controller] call AF_fnc_findVeh;
	if !(alive _vehicle) exitWith {};
	private _armCooldown = _vehicle getVariable ["AF_armCooldown", -600];
	if (_armCooldown > time) exitWith {};
	_vehicle setVariable ["AF_armCooldown", time + 1];

	private _AF_casAmmo = _controller getVariable ["AF_casAmmo", []];
	private _newAmmoArray = (_AF_casAmmo select _ammoSelectedIndex);
	private _newAmmoType = _newAmmoArray select 0;
	private _newAmmoCount = _newAmmoArray select 1;
	private _fullMagcount = getNumber(configFile >> "CfgMagazines" >> _newAmmoType >> "count");

	private _addAmmoCount = 1;
	private _setAmmoCount = 1;
	private _changeSuspended = false;

	if (_rearmMode isEqualTo "pylon") exitWith {
		// pylons
		private _currentMagType = (getPylonMagazines _vehicle) select (_pylon - 1);

		private _currentMagCount = 0;

		// selected ammo
		if (_ammoSelectedIndex == -1) exitWith {};

		if (_currentMagType != "") then {
			if (_currentMagType isEqualTo _newAmmoType) then {
				// same mag as current
				_currentMagCount = (_vehicle ammoOnPylon _pylon) max 0;
				private _ammoSpaceleft = _fullMagcount - _currentMagCount;
				if (_ammoSpaceleft <= 0) exitWith {
					// allready full
					_changeSuspended = true;
				};
				if (_rearmFullMag) then {
					_addAmmoCount = _ammoSpaceleft min _newAmmoCount;
				};
				_setAmmoCount = _currentMagCount + _addAmmoCount;
			} else {
				// different ammo than current
				[_controller, _pylon, "pylon", false] call AF_fnc_casRearmRemoveMags;
				if (_rearmFullMag) then {
					_setAmmoCount = _fullMagcount min _newAmmoCount;
				};
			};
		} else {
			if (_rearmFullMag) then {
				_setAmmoCount = _fullMagcount min _newAmmoCount;
			};
		};
		if (_changeSuspended) exitWith {};

		[_controller, _vehicle, _pylon, _newAmmoType, _setAmmoCount] remoteExecCall ["AF_fnc_setPylon", 0, false];
		//_vehicle setPylonLoadout [_pylon, _newAmmoType];
		//_vehicle setAmmoOnPylon [_pylon, _setAmmoCount];

		// workaround for utility pods that have 0 ammo
		if (_fullMagcount <= 0) then {
			_setAmmoCount = 1;
		};
		private _updatedAmmoCount = _newAmmoCount - _setAmmoCount + _currentMagCount;
		if (_updatedAmmoCount <= 0) then {
			_AF_casAmmo deleteAt _ammoSelectedIndex;
		}else {
			_newAmmoArray set [1, _updatedAmmoCount];
		};
		[_controller, _AF_casAmmo] remoteExecCall ["AF_fnc_casRearmRefresh", 0, str _controller];
	};

	if (_rearmMode isEqualTo "magazine") exitWith {
		// magazines
		private _allMagazines = magazinesAllTurrets _vehicle;
		private _rearmMagazineArray = _allMagazines deleteAt _pylon;
		_rearmMagazineArray params ["_ammoName", "_path", "_currentMagCount", "_id", "_creator"];
		private _ammoSpaceleft = _fullMagcount - _currentMagCount;
		if (_ammoSpaceleft <= 0) exitWith {};
		private _setAmmoCount = _currentMagCount + (_ammoSpaceleft min _newAmmoCount);
		_rearmMagazineArray resize 3;
		_rearmMagazineArray set [2, _setAmmoCount];
		private _newMagazines = [_rearmMagazineArray];
		{
			_x params ["_xAmmoName", "_xPath", "_xCurrentMagCount", "_xId", "_xCreator"];
			if (_xAmmoName isEqualTo _ammoName && _xPath isEqualTo _path) then {
				_newMagazines pushBack [_xAmmoName,_xPath, _xCurrentMagCount];
			};
		}forEach _allMagazines;
		_newMagazines sort true;

		private _updatedAmmoCount = _newAmmoCount - _setAmmoCount + _currentMagCount;
		if (_updatedAmmoCount <= 0) then {
			_AF_casAmmo deleteAt _ammoSelectedIndex;
		}else {
			_newAmmoArray set [1, _updatedAmmoCount];
		};

		[_controller, _vehicle, _ammoName, _newMagazines, _path] remoteExecCall ["AF_fnc_setMagazines", 0, false]; 

		[_controller, _AF_casAmmo] remoteExecCall ["AF_fnc_casRearmRefresh", 0, str _controller];
	};
	[_controller, _AF_casAmmo] remoteExecCall ["AF_fnc_casRearmRefresh", 0, str _controller];
};

AF_fnc_casRearmRemoveMags = {
	params [["_controller",objNull],["_pylon",-1],["_rearmMode",""],["_setEmpty", true]];
	private _vehicle = [_controller] call AF_fnc_findVeh;
	if !(alive _vehicle) exitWith {};
	private _armCooldown = _vehicle getVariable ["AF_armCooldown", -600];
	if (_setEmpty && _armCooldown > time) exitWith {};
	_vehicle setVariable ["AF_armCooldown", time + 1];
	if (_pylon <= 0 || !(_rearmMode isEqualTo "pylon")) exitWith {};

	private _AF_casAmmo = _controller getVariable ["AF_casAmmo", []];

	if (_rearmMode isEqualTo "pylon") then {
		private _currentMagType = (getPylonMagazines _vehicle) select (_pylon - 1);
		if (_currentMagType isEqualTo "") exitWith {};
		private _currentMagCount = ( _vehicle ammoOnPylon _pylon) max 0;

		private _fullMagcount = getNumber(configFile >> "CfgMagazines" >> _currentMagType >> "count");
		// workaround for utility pods that have 0 ammo
		if (_fullMagcount <= 0) then {
			_currentMagCount = 1;
		};
		
		private _currentMagInArray = false;
		{
			private _newAmmoName = _x select 0;
			if (_newAmmoName isEqualTo _currentMagType) exitWith {
				_currentMagInArray = true;
				private _newAmmoCount = _x select 1;
				_newAmmoCount = _newAmmoCount + _currentMagCount;
				_x set [1, _newAmmoCount];
			};
		} forEach _AF_casAmmo;
		if (_setEmpty) then {
			[_controller, _vehicle, _pylon, _newAmmoType, 0] remoteExecCall ["AF_fnc_setPylon", 0, false];
		};
		//_vehicle setAmmoOnPylon [_pylon, _setAmmoCount];
		if !(_currentMagInArray) then {
			_AF_casAmmo pushBack [_currentMagType, _currentMagCount];
		};
		[_controller, _AF_casAmmo] remoteExecCall ["AF_fnc_casRearmRefresh", 0, str _controller];
	};
	_controller setVariable ["AF_casAmmo", _AF_casAmmo];
};