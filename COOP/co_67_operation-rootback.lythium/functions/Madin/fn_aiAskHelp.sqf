_group = _this select 0;
_leader = leader _group;
_side = side _leader;
if (true) then
{
	_group setVariable ["lastAsked",time,true];
	_list = _leader nearEntities ["Man", 750];
	_groups = [];
	{
		if ((side _x) == _side) then
		{
			_groups pushBackUnique (group _x);
		};
	}forEach _list;
	{
		_leadgrp = leader _x;
		_danger = _leadgrp findNearestEnemy _leadgrp;
		if (!isNull _danger)then
		{
			{_x reveal [_danger, 4]}forEach _this;
		};
		_group setVariable ["alerted",time,true];
	}forEach _groups;
};