/*
	AF_fnc_cacheInit

	Description:
		Funkcja inicjalizuje skrypt cache

	Parameter(s):
		NOTHING

	Returns:
		Uchwyt do skryptu cache [Script Handle]
*/

if (!hasInterface) exitWith {scriptNull};
if (!isNull Madin_cache) exitWith {Madin_cache};

Madin_cache = [] spawn {
	scriptName "Madin_cache_loop";

	["Uruchamianie skryptu cache"] call AF_fnc_localLog;

	private _fnc_getZoomFactor = { round (([] call AF_fnc_getCurrentZoom) * 10) };
	private _currentZoomFactor = [] call _fnc_getZoomFactor;

	while {true} do
	{
		waitUntil {alive player};
		for "_i" from 1 to 5 do
		{
			private _lastChecktime = (time + 2);
			waitUntil {
				sleep 0.03;
				// Oczekiwanie na zmiane przybliżenia
				(_currentZoomFactor != ([] call _fnc_getZoomFactor)
				// lub timeout, im szybciej gracz się porusza tym krótszy będzie timeout
				|| (_lastChecktime / (speed player / 10000 + 1)) < time)
			};
			_currentZoomFactor = [] call _fnc_getZoomFactor;

			// Wyliczenie dystansu cache zależnie od obecnej prędkości oraz przybliżenia
			private _cacheDistance = 800 + 100 * _currentZoomFactor + speed player;
			private _near = ((positionCameraToWorld [0,0,0]) nearEntities ["allVehicles", _cacheDistance]) - allPlayers;
			private _far = (allunits - _near) - allPlayers;

			// Ukrycie oraz wyłączenie symulacji na obiektach poza dystansem
			{
				{
					hideObject _x; _x enableSimulation false;
				} forEach crew _x;
			} forEach _far;
			// Pokazanie oraz włączenie symulacji na obiektach które powinny zosta pokazane
			{
				{
					_x hideObject false;  _x enableSimulation true;
				} forEach crew _x;
			} forEach _near;
			sleep 0.1;
		};

		{_x enableSimulation true} forEach (allUnits - allPlayers);
		if (!isNull (getConnectedUAV player)) then
		{
			{_x enableSimulation true; _x hideObject false;} forEach allUnits;
			systemchat "wykryto UAV, skrypt cache wstrzymany.";
			waitUntil {sleep 1; isNull (getConnectedUAV player)};
			systemchat "Odpięto UAV, skrypt cache wznowiony.";
		};
	};
};

Madin_cache