/*
	AF_fnc_handleDamageHc

	Description:
		Obsługuje obrażenia gracza gdy hardcorowe dmg włączone

	Parameter(s):
		NOTHING

	Returns:
		Jednostka została zabita [BOOL]
*/
params [
	["_unit", objNull, [objNull]]
];

// Do not handle damage if hc damage mode disabled
if (!AF_hardcoreDamageEnabled || !alive _unit) exitWith {false};

private _aceHitpoints = _unit getVariable ["ace_medical_bodypartstatus",[0,0,0,0,0,0]];
// Extract single hitpoints
_aceHitpoints params ["_head", "_body", "_hand_l", "_hand_r", "_leg_l", "_leg_r"];
// Init with body damage so it's counted twice
private _damage = _body;
{_damage = _damage + _x} forEach _aceHitpoints;

// Kill the unit if it suffered enough damage
if (_head > AF_hardcoreDamageHead) exitWith {
	private _msg = "Krytyczne obrażenia głowy!";
	systemChat _msg;
	[_msg, _unit] call AF_fnc_serverLog;
	_unit setDamage 1;
	true
};
if (_body > AF_hardcoreDamageBody) exitWith {
	private _msg = "Krytyczne obrażenia klatki piersiowej!";
	systemChat _msg;
	[_msg, _unit] call AF_fnc_serverLog;
	_unit setDamage 1;
	true
};
if (_damage > AF_hardcoreDamageAll) exitWith {
	private _msg = "Krytyczne obrażenia ciała!";
	systemChat _msg;
	[_msg, _unit] call AF_fnc_serverLog;
	_unit setDamage 1;
	true
};

false