// nowa wersja spawnu AI, poprzednia zachowana dla kompatybilności
params ["_group","_type","_pos","_dir"];
private _unit = _group createUnit [_type, [0,0,0], [], 0, "CAN_COLLIDE"];
[_unit] call AF_fnc_EventHandlers;
_unit allowDamage false;
_unit setDir _dir;
[_unit,"AmovPsitMstpSrasWrflDnon_AmovPercMstpSlowWrflDnon"] remoteExec ["SyncSwitchMove", 0];
[_unit,_pos] spawn {
	sleep 0.1;
	params ["_unit","_pos"];
	_unit setUnitPos "UP";
	_unit setPosATL _pos;
	_unit allowDamage true;
	sleep 15;
	_unit setUnitPos "AUTO";
};
_unit setVariable ["acex_headless_blacklist", true];
[_unit] call AF_fnc_AI_init;
{[_x,[[_unit],true]] remoteExec ["addCuratorEditableObjects", 0]}forEach allCurators;
_unit