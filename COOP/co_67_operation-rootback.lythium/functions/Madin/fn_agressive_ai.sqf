_unit = (_this select 0); 
_enemy = _unit findNearestEnemy _unit;
if (!isNull _enemy && {!(vehicle _enemy isKindOf "Air")} && {!(vehicle _enemy isKindOf "Ship")})then
{
	_AA = ["rhs_weap_fim92","rhs_weap_igla","rhs_weap_fgm148","launch_NLAW_F"];
	_distance = _unit distance _enemy;
	if ((random 100) < AF_RPG_spam && {(secondaryWeapon _unit) != ""} && {!((secondaryWeapon _unit) in _AA)} && {((secondaryWeaponMagazine _unit)select 0) != ""} && {_distance > 20} && {_distance < 400})exitWith
	{
		_nearVeh = nearestObjects [_enemy, ["AllVehicles","Static"], 10];
		{
			_vehFire = _x;
			if (!(_vehFire isKindOf "Man") && {([_unit, "VIEW", _vehFire] checkVisibility [eyePos _unit, (getPosASL _vehFire) vectorAdd [0,0,1.5]]) > 0.1})exitWith
			{
				if (count crew _vehFire != 0)exitWith
				{
					if ((side (crew _vehFire select 0)) != (side _unit))exitWith
					{
						_unit lookAt _vehFire;
						_unit doWatch _vehFire;
						_ang = _unit getRelDir _vehFire;
						if ((_ang <= 30) || (_ang >= 330)) then
						{
							_unit forceWeaponFire [secondaryWeapon _unit,secondaryWeapon _unit];
							_unit doFire _vehFire;
							_unit fire (secondaryWeapon _unit);
							[_unit,_vehFire] spawn
							{
								sleep 1;
								(_this select 0) fire (secondaryWeapon (_this select 0));
							};
						};
					};
				};
				_unit lookAt _vehFire;
				_unit doWatch _vehFire;
				_ang = _unit getRelDir _vehFire;
				if ((_ang <= 30) || (_ang >= 330)) then
				{
					_unit forceWeaponFire [secondaryWeapon _unit,secondaryWeapon _unit];
					_unit doFire _vehFire;
					_unit fire (secondaryWeapon _unit);
					[_unit,_vehFire] spawn
					{
						sleep 2;
						(_this select 0) fire (secondaryWeapon (_this select 0));
					};
				};
			};
		}forEach _nearVeh;
	};
	if (_distance < 50 && {_distance > 8.5})then
	{
		_visiblity = [_unit, "VIEW"] checkVisibility [eyePos _unit, eyePos _enemy];
		if (_visiblity > 0.5) then 
		{
			_nearFriendly = (_enemy nearEntities [["Man"], 8]);
			if (((side _unit) countSide _nearFriendly) == 0) then
			{
				doStop _unit;
				_unit lookAt _enemy;
				_unit doWatch _enemy;
				_ang = _unit getRelDir _enemy;
				if ((_ang <= 15) || (_ang >= 345)) then
				{
					_unit forceWeaponFire ["HandGrenadeMuzzle","HandGrenadeMuzzle"];
					_unit forceWeaponFire ["MiniGrenadeMuzzle","MiniGrenadeMuzzle"];
					_unit forceWeaponFire ["Rhsusf_Throw_Grenade","Rhsusf_Throw_Grenade"];
					_unit forceWeaponFire ["Rhs_Throw_Grenade","Rhs_Throw_Grenade"];
					_unit forceWeaponFire ["Rhs_Throw_RgnGrenade","Rhs_Throw_RgnGrenade"];
					_unit forceWeaponFire ["rhsgref_Throw_Grenade","rhsgref_Throw_Grenade"];
					//[_unit,AF_voiceGrenade_eng,true] remoteExecCall ["AF_fnc_voiceAI",_unit,false];
					sleep 1;
					//_unit setVariable ["M_AIvoice",nil];
				};
			}
		};
	};
};