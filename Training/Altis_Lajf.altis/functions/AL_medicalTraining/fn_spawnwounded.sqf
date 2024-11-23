/*
Spawns patient based on desired severity.

Params:
None

Returns:
None

Example:
[] spawn AL_fnc_spawnwounded;

Locality:
Runs local. Effect local.
*/


params ["_severity"];
private _Body_parts = ["head", "body", "hand_l", "hand_r", "leg_l", "leg_r"];
//_Limbs = ["hand_l", "hand_r", "leg_l", "leg_r"];
private _Wound_types = ["bullet", "grenade", "explosive"];
private _damage_to_do = 0;
private _parts_damaged = 0;

switch (_severity) do {
case 0: {_damage_to_do = 0};
case 1: {_damage_to_do = 0.1 + random 0.2};
case 2: {_damage_to_do = 0.4 + random 0.2; _parts_damaged = -(floor random 2)};
case 3: {_damage_to_do = 0.7 + random 0.2; _parts_damaged = -(floor random 7)};
};

_Grp = createGroup west;
"C_man_1" createUnit [getPos player, _Grp,"wounded = this"];
wounded disableAI "MOVE";
//wounded addItem "ACE_tourniquet";

sleep 0.1;
//[wounded, 1] call ace_medical_fnc_adjustPainLevel;

[wounded] call ace_medical_fnc_handleDamage_advancedSetDamage;

if (_severity == 0) exitwith {};

while {_parts_damaged <= _severity} do {
	private _damage = random [0.5,0.75,0.9];
	_parts_damaged = _parts_damaged + 1;
	_bodypart = _Body_parts call BIS_fnc_selectRandom;
	private _woundtype = _Wound_types call BIS_fnc_selectRandom;	
	[wounded, _damage, _bodypart, _woundtype] call ace_medical_fnc_addDamageToUnit;
};

wounded setVariable ["ACE_medical_bloodVolume", 100 - _damage_to_do * random 40, true];
[wounded, -(_damage_to_do * random 40), 1] call ace_medical_fnc_addHeartRateAdjustment;
[wounded, true] call ace_medical_fnc_setUnconscious;	
/*if (random 1 >= (0.2 + _damage_to_do * 0.1)) then {
	[xd, wounded, _Limbs call BIS_fnc_selectRandom , "ACE_tourniquet"] call ACE_medical_fnc_treatmentTourniquet
};
if (random 1 > (1.05 - _damage_to_do * 0.05)) then {
	[wounded] call ace_medical_fnc_setCardiacArrest
};*/