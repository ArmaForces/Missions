setViewDistance defaultviewdistance;
setObjectViewDistance defaultviewdistance * 0.7;

// Dodanie inicjalizacji Madinowego AI do botów zespawnowanych przez Zeusa
{
	_x addEventHandler ["CuratorObjectPlaced", {
		params ["_curator", "_entity"];
		{[_x] call AF_fnc_AI_init} forEach (crew _entity);
	}];
} forEach allCurators;