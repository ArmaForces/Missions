if (hasInterface) then
{
	Madin_cache = true;
	_fov = round ((([0.5,0.5] distance2D  worldToScreen positionCameraToWorld [0,3,4]) * (getResolution select 5) / 2)*10);
	while {Madin_cache} do
	{
		for "_i" from 1 to 5 do
		{
			_time = (time+2);
			waitUntil {sleep 0.03; round _fov != round ((([0.5,0.5] distance2D  worldToScreen positionCameraToWorld [0,3,4]) * (getResolution select 5) / 2)*10) || (_time /(speed player/10000 + 1)) < time};
			_fov = round ((([0.5,0.5] distance2D  worldToScreen positionCameraToWorld [0,3,4]) * (getResolution select 5) / 2)*10);
			_sickmath = 800 + 100* _fov + speed player;
			_near = (player nearEntities ["allVehicles", _sickmath]) - allPlayers;
			_far = (allunits - _near) - allPlayers;
			{
				{
					hideObject _x; _x enableSimulation false;
				}forEach crew _x;
			}forEach _far;
			{
				{
					_x hideObject false;  _x enableSimulation true;
				}forEach crew _x;
			}forEach _near;
			sleep 0.1;
		};
		{_x enableSimulation true;}forEach allUnits;
		if (!isNull (getConnectedUAV player)) then
		{
			{_x enableSimulation true; _x hideObject false;}forEach allUnits;
			systemchat "wykryto UAV, skrypt cache wstrzymany.";
			waitUntil {sleep 1; isNull (getConnectedUAV player)};
			systemchat "Odpięto UAV, skrypt cache wznowiony.";
		};
	};
	{_x hideObject false} forEach allUnits;
	{_x enableSimulation true} forEach allUnits;
};