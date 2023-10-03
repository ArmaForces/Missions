/*
	AF_fnc_getAllLocalUnits

	Description:
		Funkcja zwraca wszystkie lokalne jednostki nie będące graczami

	Parameter(s):
		NOTHING

	Returns:
		Wszstkie lokalne jednostki [ARRAY]
*/

(allUnits select {local _x}) - allPlayers