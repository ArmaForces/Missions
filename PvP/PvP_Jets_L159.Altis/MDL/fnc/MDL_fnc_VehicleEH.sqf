/*
Checks if vehicle is destroyed or abandoned and delete it.

Params:
0: <OBJECT> - Vehicle to check

Return value:
None

Example:
[_veh] spawn MDL_fnc_vehicleEH;

Locality:
Runs local. Effect local.
*/

params ["_veh"];
_veh = _this select 0;
while {alive _veh} do {
	waitUntil {!(player in crew _veh) AND player distance _veh > 100 OR !alive _veh};
	_i = 60;
	if (!alive _veh) then {_i = 0; sleep 15;};
	while {!(player in crew _veh) AND player distance _veh > 100 AND _i > 0} do {
		sleep 1;
		_i = _i - 1;
	};
	if (_i == 0) then {
		_className = typeOf _veh;
		_displayName = getText (configFile >>  "CfgVehicles" >>	_className >> "displayName");
		if (!alive _veh) then {
			_reason = "zniszczenia";
		} else {
			_reason = "opuszczenia";
		};
		deleteVehicle _veh;
		systemChat format ["Usunięto %1 z powodu %2.", _displayName, _reason];
	};
};