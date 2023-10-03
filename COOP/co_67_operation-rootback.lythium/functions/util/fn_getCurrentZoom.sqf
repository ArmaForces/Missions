/*
	AF_fnc_getCurrentZoom

	Description:
		Funkcja zwraca aktualne przybliżenie

	Parameter(s):
		NOTHING

	Returns:
		Obecny poziom przybliżenia [NUMBER]
*/

([0.5, 0.5] distance2D worldToScreen positionCameraToWorld [0,3,4]) * (getResolution select 5) / 2
