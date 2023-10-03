_vehicle = _this select 0;
_ammo = _this select 1;
_ammocount = _this select 2;
_maxammo = _this select 3;
_ammobox =  _this select 4;
_list = _ammobox nearEntities ["Tank", 8];
_type = [];
{
	_type pushBack (typeOf _x);
}forEach _list;
if ((count _list) == 0) exitWith
{
	systemChat "Nic tu nie ma";
	[player,""] remoteExec ["SyncSwitchMove", 0];
	player playAction "PlayerCrouch";
};
_find = _type find _vehicle;
if (_find != -1) then
{
	_veh = (_list select _find);
	_count = {_x == _ammo} count (magazines _veh);
	if (_count < _maxammo) then
	{
		[_veh, [_ammo,_ammocount]] remoteExec ["addMagazine",_veh];
		systemChat "Amunicja załadowana";
		[player,""] remoteExec ["SyncSwitchMove", 0];
		deleteVehicle _ammobox;
	}else
	{
		systemChat "Pojazd pełen!";
		[player,""] remoteExec ["SyncSwitchMove", 0];
	};
}else 
{
	systemChat "Zły pojazd!";
	[player,""] remoteExec ["SyncSwitchMove", 0];
};
player playAction "PlayerCrouch";