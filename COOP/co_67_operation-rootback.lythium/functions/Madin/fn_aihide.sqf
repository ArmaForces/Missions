_leader = _this select 0;
_buildings = (nearestObjects [_leader, ["House", "Building"], 50]);
if ((count _buildings) > 0) then
{
	_wi = [];
	{
		if ((count (_x buildingPos -1)) > 0) then
		{
			_wi pushBack _x;
		};
	}forEach _buildings;
	if ((count _wi) > 0) then
	{
		{
			_building = selectRandom _wi;
			_pos = selectRandom (_building buildingPos -1);
			_x doMove _pos;
			_x setSpeedMode "FULL";
		}forEach (units group _leader);
	};
};