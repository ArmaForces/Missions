_vehicle = (_this select 0) select 0;
_ammo = (_this select 0) select 1;
_ammobox =  _this select 1;
_list = _ammobox nearEntities ["allVehicles", 7];
_find = _list findIf {(typeOf _x) == _vehicle};
if (_find != -1) then
{
	_veh = (_list select _find);
	[_veh, _ammo] remoteExec ["removeMagazineGlobal",_veh];
	[_veh, _ammo] remoteExec ["addMagazine",_veh];
	systemChat "Amunicja załadowana";
	deleteVehicle _ammobox;
}else
{
	systemChat "Nic tu nie ma";
};
[player,"AmovPcrhMstpSrasWpstDnon_AadjPcrhMstpSrasWpstDup"] remoteExec ["SyncSwitchMove", 0];
player playAction "PlayerCrouch";


_vehicle = "rhs_bmp1p_vdv";
_list = _ammobox nearEntities ["allVehicles", 6];
_d = _list findIf {(typeOf _x) == _vehicle};
_d;