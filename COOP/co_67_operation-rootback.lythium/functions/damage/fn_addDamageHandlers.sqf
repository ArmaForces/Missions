/*
	AF_fnc_addDamageHandlers

	Description:
		Inicjalizuje handlery obsługujące obrażenia otrzymywane przez jednostkę

	Parameter(s):
		_unit - Jednostka do której zostaną dodane handlery obsługujące obrażenia [OBJECT]

	Returns:
		Handlery obsługujące obrażenia zostały dodane [BOOL]
*/
params [
	["_unit", objNull, [objNull]]
];

[format ["Dodawanie systemu obrażeń do %1", _unit]] call AF_fnc_serverLog;

// Make sure we're not duplicating EHs
_unit removeEventHandler ["Hit", _unit getVariable ["AF_hitEh", -1]];
_unit removeEventHandler ["Explosion", _unit getVariable ["AF_explEh", -1]];

private _hitEh = _unit addEventHandler ["Hit", {
	params ["_unit", "", "_damage"];

	[_damage, _unit] spawn AF_fnc_createHitEffect;
	[{
			[AF_fnc_handleDamageHc, _this] call CBA_fnc_execNextFrame;
	}, _unit] call CBA_fnc_execNextFrame;
}];

private _explEh = _unit addEventHandler ["Explosion", {
	params ["_unit"];

	[{
			[AF_fnc_handleDamageHc, _this] call CBA_fnc_execNextFrame;
	}, _unit] call CBA_fnc_execNextFrame;
}];

_unit setVariable ["AF_hitEh", _hitEh];
_unit setVariable ["AF_explEh", _explEh];

true
