// ustawienia AI

private _unit = _this select 0;
_unit setSkill ["aimingAccuracy",(AF_AimingAccuracy + (random AF_randomSkill))];
_unit setSkill ["aimingShake",(AF_aimingShake + (random AF_randomSkill))];
_unit setSkill ["spotDistance",(AF_spotDistance + (random AF_randomSkill))];
_unit setSkill ["spotTime",(AF_spotTime + (random AF_randomSkill))];
_unit setSkill ["courage",(AF_courage + (random AF_randomSkill))];
_unit setSkill ["commanding",(AF_commanding + (random AF_randomSkill))];
_unit setSkill ["aimingSpeed",(AF_courage + (random AF_randomSkill))];
_unit setSkill ["general",(AF_general + (random AF_randomSkill))];
_unit setSkill ["endurance",(AF_endurance + (random AF_randomSkill))];
_unit setSkill ["reloadSpeed",(AF_reloadSpeed + (random AF_randomSkill))];
_unit allowFleeing 0;
