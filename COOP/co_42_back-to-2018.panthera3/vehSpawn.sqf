/*
TO WKLEIĆ DO SAMEGO POJAZDU!

do poprawnego działania wymagany Headless Client, JEDEN!
// ==========

if (!hasInterface && !isServer || hasInterface && isServer) then {[this, "marker_0", "warunek"]execVM "vehSpawn.sqf"}else
{if (isServer) then {{_x disableAI "PATH";}forEach crew this}};

// ==========
nie wiesz czy i jak edytować? TO NIE DOTYKAJ! SKOPIUJ JAK JEST.
*/
params ["_vehicle", "_marker", "_trigger"];
_vehType = typeOf _vehicle;
_Vehiclepos = getPos _vehicle;
_vehicleDir = getDir _vehicle;
_fullCrew = fullCrew _vehicle;
_side = side ((_fullCrew select 0) select 0);
{
	_type = typeOf (_x select 0);
	_x set [0, _type];
}forEach _fullCrew;
{_grDel = group _x; deleteVehicle _x; deleteGroup _grDel;}forEach (crew _vehicle);
deleteVehicle _vehicle;
_markerPos = getMarkerPos _marker;
waitUntil {sleep 1;missionNamespace getVariable [_trigger, false]};
_veh = createVehicle [_vehType, _Vehiclepos, [], 0, "NONE"];
_veh setDir _vehicleDir;
_GroupVeh = createGroup [_side, false];
_GroupCargo = createGroup [_side, false];
_GroupVeh setVariable ["MadinEnableAi", false, true];
{
	if (_x select 1 != "cargo" && _x select 1 != "Turret") then
	{
		_unit = _GroupVeh createUnit [_x select 0, _Vehiclepos, [], 5, "NONE"];
		_unit setVariable ["acex_headless_blacklist", true];
		_unit setSkill ["aimingAccuracy",(0.05 + (random 0.05))];
		_unit setSkill ["aimingShake",(0.05 + (random 0.05))];
		_unit setSkill ["spotDistance",(0.75 + (random 0.15))];
		_unit setSkill ["spotTime",(0.6 + (random 0.1))];
		_unit setSkill ["courage",(0.7 + (random 0.3))];
		_unit setSkill ["commanding",1.0];
		_unit setSkill ["aimingSpeed",(0.6 + (random 0.15))];
		_unit setSkill ["general",1.0];
		_unit setSkill ["endurance",1.0];
		_unit setSkill ["reloadSpeed",(0.7 + (random 0.3))];
		_unit addEventHandler ["killed", "(units _GroupCargo) allowGetIn false;{_x removeEventHandler ['killed', 0]}forEach (units group (_this select 0))"];
		if (_x select 1 == "driver")exitWith
			{
				_unit moveInDriver _veh;
				_unit assignAsDriver _veh;
			};
		if (_x select 1 == "commander")exitWith
			{
				_unit moveInCommander _veh;
				_unit assignAsCommander _veh;
			};
		if (_x select 1 == "gunner")exitWith
			{
				_unit moveInGunner _veh;
				_unit assignAsGunner _veh;
			};
		_unit moveInCargo _veh;
	}else
	{
		_unit = _GroupCargo createUnit [_x select 0, _Vehiclepos, [], 5, "NONE"];
		_unit setVariable ["acex_headless_blacklist", true];
		_unit setSkill ["aimingAccuracy",(0.05 + (random 0.05))];
		_unit setSkill ["aimingShake",(0.05 + (random 0.05))];
		_unit setSkill ["spotDistance",(0.75 + (random 0.15))];
		_unit setSkill ["spotTime",(0.6 + (random 0.1))];
		_unit setSkill ["courage",(0.7 + (random 0.3))];
		_unit setSkill ["commanding",1.0];
		_unit setSkill ["aimingSpeed",(0.6 + (random 0.15))];
		_unit setSkill ["general",1.0];
		_unit setSkill ["endurance",1.0];
		_unit setSkill ["reloadSpeed",(0.7 + (random 0.3))];
	if (_x select 1 == "Turret")then
	{
		_unit moveInTurret [_veh, _x select 3];
		_unit assignAsTurret [_veh, _x select 3];
	}else
	{
		_unit moveInCargo _veh;
	};
	_unit addEventHandler ["killed", "(units group (_this select 0)) allowGetIn false;{_x removeEventHandler ['killed', 0]}forEach (units group (_this select 0))"];
	};
}forEach _fullCrew;
sleep 0.5;
_waypointdriver = _GroupVeh addWaypoint [_markerPos, 0];
_waypointdriver setWaypointType "TR UNLOAD";
_waypointdriver setWaypointCompletionRadius 500;
if ((count units _GroupCargo) != 0) then
{
	_waypointGroup = _GroupCargo addWaypoint [_markerPos, 25];
	_waypointGroup setWaypointCompletionRadius 5;
	_GroupCargo setCombatMode "RED";
	[_markerPos,_waypointdriver,_veh,_GroupVeh,_GroupCargo]spawn
	{
		params ["_markerPos","_waypointdriver", "_veh","_GroupVeh","_GroupCargo"];
		sleep 10;
		_randomDist = random [100,125,150];
		waitUntil {sleep 1; (_markerPos distance _veh) < 250};
		_veh forceSpeed 10;
		waitUntil {sleep random [1,2,3]; (_markerPos distance _veh) < _randomDist || (speed _veh < 5 && {(_markerPos distance _veh) < _randomDist + 75})};
		_veh forceSpeed 0;
		waitUntil {speed _veh < 1};
		_waypointdriver setWaypointPosition [getPos (driver _veh), 0];
		(units _GroupCargo) allowGetIn false;
		sleep 10;
		_veh forceSpeed -1;
		if ((count units _GroupVeh) == 1)then
		{
			(units _GroupVeh) joinSilent _GroupCargo;
			(units _GroupCargo) allowGetIn false;
		};
		[_GroupCargo]spawn
		{
			sleep 10;
			waitUntil {sleep 10; (count units (_this select 0)) == 0};
			deleteGroup (_this select 0);
		};
	};
}else
{
	deleteGroup _GroupCargo;
};
[_GroupVeh]spawn
{
	sleep 10;
	waitUntil {sleep 10; (count units (_this select 0)) == 0};
	deleteGroup (_this select 0);
};