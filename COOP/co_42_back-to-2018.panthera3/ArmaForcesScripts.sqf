fnc_disable_drag = {
[(_this select 0), false, [0, 0, 0], 0] call ace_dragging_fnc_setDraggable;
[(_this select 0), false, [0, 0, 0], 0] call ace_dragging_fnc_setCarryable;
};
fnc_surgery = {
	if ((_this select 0) getVariable ["Madin_surgery", true])then
	{
		//[(_this select 0)]  remoteExec ["fnc_disable_drag", 0];
		(_this select 0) setVariable ["Madin_surgery", false];
		(_this select 0) attachTo [(_this select 1), [0,0,0.21] ];
		(_this select 0) setDir 5;
		(_this select 0) setPos getPos (_this select 0);
		[(_this select 0), "Acts_InjuredLyingRifle02_180"]  remoteExec ["SyncSwitchMove", 0];
		sleep random [30,45,60];
		[(_this select 0), "AinjPpneMstpSnonWrflDnon_rolltofront", 0.5]  remoteExec ["SyncSwitchMoveSpeed", 0];
		sleep 3;
		[objNull, (_this select 0)] remoteExec ["ace_medical_fnc_treatmentAdvanced_fullHealLocal"];
		(_this select 0) setVariable ["Madin_surgery", nil];
		detach (_this select 0);
	};
};
SyncSwitchMoveSpeed = {
	if (isDedicated) exitwith {};
	(_this select 0) switchMove (_this select 1);
	(_this select 0) setAnimSpeedCoef (_this select 2);
};
SyncSwitchMove = {
	if (isDedicated) exitwith {};
	(_this select 0) switchMove (_this select 1);
};
fnc_groups = {
disableSerialization;
createDialog "zulu_dialog";
waitUntil {!isNull (findDisplay 9991);};
call fnc_groupsList;
};
fnc_groupsList = {
disableSerialization;
waitUntil {!isNull (findDisplay 9991);};
lbClear 123;
lbClear 126;
_ctrl1 = (findDisplay 9991) displayCtrl 123;
_ctrl2 = (findDisplay 9991) displayCtrl 126;
wgroups = [];
{
wgroups pushBackUnique (group _x);
} forEach allPlayers;
{
	_x;
	_grname = groupId _x;
	_ctrl1 lbAdd _grname;
} forEach wgroups;
if (!isnil "_this" && {(count _this) == 1}) then
{
	_selector = _this select 0;
	if (_selector != -1) then
	{
		_units = units (wgroups select _selector);
		{
			_name = name _x;
			_ctrl2 lbAdd _name;
		}
		 forEach _units;
	};
_selector = nil;
};
};
fnc_setviewgui = {
disableSerialization;
createDialog "view_distance_settings";
waitUntil {!isNull (findDisplay 10);};
ctrlSetText [311, str viewdistance];
};
fnc_setdistance = {
_dist = (_this select 0);
_dist2 = _dist * 0.7;
if (_dist > 500) then
{
	if (_dist < maxviewdistance) then
	{
		setViewDistance _dist;
		if (_dist2 < 500) then
		{
		setobjectviewdistance 500;
		}
		else
		{
		setobjectviewdistance _dist2;
		};
	}
	else {setViewDistance maxviewdistance; setobjectviewdistance maxviewdistance * 0.7;
	};
}
else
{
	setViewDistance 500;
	setobjectviewdistance 500;
};
ctrlSetText [311, str viewdistance];
};
// --------------------------------------------------
adminzeus addEventHandler ["CuratorObjectPlaced",{
	_Ai = [];
	_AllAi = allUnits - PlayableUnits;
	{if (simulationEnabled _x) then {_Ai pushBack _x}}forEach _AllAi;
	_cAi = count (_Ai - allPlayers);
	_cDead = count allDeadMen;
	if (_cAi > 50) then
	{
		_w = format ["AI: %1 / marte AI: %2 O S T R O Ż N I E ! PONAD 50 AI!", _cAi, _cDead];
		systemchat _w;
	}else
	{
		_w = format ["AI: %1 / trupy: %2", _cAi, _cDead];
		systemchat _w;
	};
}];