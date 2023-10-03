/*
	AF_fnc_createHitEffect

	Description:
		Tworzy efekt graficzny widoczny po otrzymaniu obrażeń

	Parameter(s):
		NOTHING

	Returns:
		Efekt został utworzony [BOOL]
*/
params [
	["_damage", 0, [0]],
	["_unit", player, [objNull]]
];
// Only players can see hit effect
if (!isPlayer _unit) exitWith {false};
// If unit is remote then remote exec it
if (!local _unit) exitWith {
	_this remoteExec ["AF_fnc_createHitEffect", _unit];
	true
};

// Exit if effect is initializing already to prevent effect duplication in short timeframe
if (missionNamespace getVariable ["AF_painEffect_initializing", false]) exitWith {false};
AF_painEffect_initializing = true;
// Enable to get another pain effect after 1s
[{AF_painEffect_initializing = false}, nil, 1] call CBA_fnc_waitAndExecute;

// Get global layer priority and increase it so newer effects will be on the top
private _layerPriority = AF_painLayer_priority;
AF_painLayer_priority = AF_painLayer_priority + 1;

// Limit damage to 3
_damage = _damage min 3;
private _damagePower = _damage * 10;
// Minimum damage effect is 0.5
private _damageEffect = (3 - 5 * _damage) max 0.5;
// Minimum color intensity
private _painColor = (1 - _damage) max 0.1;

// Limit after hit aim coef to current aim coef so player won't get more accuracy on small hits
private _aimCoef = getCustomAimCoef player max _damagePower;
player setCustomAimCoef _damagePower;

private _blurEffect = ppEffectCreate ["DynamicBlur", _layerPriority];
_blurEffect ppEffectEnable true;
_blurEffect ppEffectAdjust [_damage];
_blurEffect ppEffectCommit 0.05;

private _colorEffect = ppEffectCreate ["ColorCorrections", (_layerPriority + 100)];
_colorEffect ppEffectAdjust [_painColor, 1.1, 0.0, [0.5, 0.5, 0.5, 0], [0.25, 0, 0, 0], [1, 1, 1, 1],[_damageEffect, _damageEffect, 0,0,0,0.25,0.5]];
_colorEffect ppEffectEnable true;
_colorEffect ppEffectCommit 1;

private _redEffect = ppEffectCreate ["ColorCorrections", (_layerPriority + 200)];
_redEffect ppEffectAdjust
[
	0.95,
	1,
	0,
	[0.5, 0, 0, 0],
	[1, _painColor, _painColor, _painColor],
	[0.299, 0.587, 0.114, 0],
	[-1, -1, 0, 0, 0, 0, 0]
];
_redEffect ppEffectEnable true;
_redEffect ppEffectCommit 0.1;

uisleep (2 + _damage);

_maxtime = time + 60;
waitUntil {ppEffectCommitted _colorEffect || time >= _maxtime};

_blurEffect ppEffectAdjust [0];
_blurEffect ppEffectCommit (_damagePower);
{
	_x	ppEffectAdjust [1, 1, 0.0, [0.1, 0, 0, 0], [1, 1, 1, 1], [1, 1, 1, 1], [1,1,0,0,0,1,1]];
	_x ppEffectCommit (_damagePower);
} forEach [_colorEffect, _redEffect];
_maxtime = time + 60;
waitUntil {ppEffectCommitted _blurEffect && ppEffectCommitted _colorEffect || time >= _maxtime};

ppEffectDestroy _blurEffect;
ppEffectDestroy _colorEffect;
ppEffectDestroy _redEffect;

if (_layerPriority > -1000) then
{
AF_painLayer_priority = -10000;
};

true
