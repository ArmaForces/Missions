pain_num = -10000; 
Madin_pp_effect = false;
player addEventHandler ["Hit", {[_this select 2] spawn fnc_hit;}];

fnc_hit = {
_damage = _this select 0;
if (_damage > 3) then {_damage = 3};
_damagePower = _damage * 4;
_damageEffect = (3 - 5*_damage);
if (_damageEffect < 0.5) then {_damageEffect = 0.5};
_painColor = 1 - _damage;
if (_painColor < 0.1) then {_painColor = 0.1};
if (!Madin_pp_effect) then
{
	player setCustomAimCoef _damagePower;
	_blurEffect = ppEffectCreate ["DynamicBlur", pain_num];
	_blurEffect ppEffectEnable true;
	_blurEffect ppEffectAdjust [_damagePower /2];
	_blurEffect ppEffectCommit 0.05;

	_colorEffect = ppEffectCreate ["ColorCorrections", (pain_num + 100)];
	_colorEffect ppEffectAdjust [_painColor, 1.1, 0.0, [0.5, 0.5, 0.5, 0], [0.25, 0, 0, 0], [1, 1, 1, 1],[_damageEffect,_damageEffect,0,0,0,0.25,0.5]]; 
	_colorEffect ppEffectEnable true;  
	_colorEffect ppEffectCommit 1;
	
	_redEffect = ppEffectCreate ["ColorCorrections", (pain_num + 200)];
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
	pain_num = pain_num + 1;
	sleep 0.01;
	Madin_pp_effect = false;
	uisleep (2 + _damage);

	_maxtime = time + 60;
	waitUntil {ppEffectCommitted _colorEffect || time >= _maxtime};
	_blurEffect ppEffectAdjust [0];
	_blurEffect ppEffectCommit (_damagePower);
	{_x	ppEffectAdjust [1, 1, 0.0, [0.1, 0, 0, 0], [1, 1, 1, 1], [1, 1, 1, 1],[1,1,0,0,0,1,1]]; 
	_x ppEffectCommit (_damagePower);}forEach [_colorEffect,_redEffect];
	_maxtime = time + 60;
	waitUntil {ppEffectCommitted _blurEffect && ppEffectCommitted _colorEffect|| time >= _maxtime};

	ppEffectDestroy _blurEffect;
	ppEffectDestroy _colorEffect;
	ppEffectDestroy _redEffect;
}
};