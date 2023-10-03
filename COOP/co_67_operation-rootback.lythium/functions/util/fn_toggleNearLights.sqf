/*
	AF_fnc_toggleNearLights

	Description:
		Funkcja przełącza światła promieniu w pobliżu podanej pozycji

	Parameter(s):
		_position 	- Pozycja w pobliżu której przełączyć światła [POSITION, defaults to getPos player]
		_enable		- Czy włączyć czy wyłączyć światłą [BOOL, defaults to true]
		_radius		- Promień w jakim zostaną wyłączone światłą [NUMBER, defaults to 100]

	Returns:
		Array of toggled light objects [ARRAY]

*/
params [
	["_position", getPos player, [[]], 3],
	["_enable", false, [true]],
	["_radius", 100, [0]],
	["_sound", false, [true]]
];

private _fnc_enableLamp = {
	params ["_lamp", "_enable"];

	for "_i" from 0 to (count getAllHitPointsDamage _lamp - 1) do	{
		_lamp setHitIndex [_i, [0, 0.95] select _enable];
	};
};

private _toggledLights = [];
{
	_toggledLights append (_position nearObjects [_x, _radius]);
} forEach AF_LIGHT_CLASSES;

{
	[_x, _enable] call _fnc_enableLamp;
	if (_sound) then {_x say3D "electricity_loop"};
} forEach _toggledLights;

_toggledLights