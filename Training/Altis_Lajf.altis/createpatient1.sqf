{if ((typeOf _x == 'b_g_survivor_F') && (!isPlayer _x)) then {deleteVehicle _x}} forEach allUnits;
[MedicalData1,3] call BIS_fnc_dataTerminalAnimate;
sleep 5;
_group2=createGroup west;
'b_g_survivor_F' createUnit [getmarkerPos 'PatientSpawn2', _group2,'pat=this; dostop pat'];
[pat] call ace_medical_fnc_handleDamage_advancedSetDamage;
sleep 0.2;
pat setUnconscious true;
[pat, selectRandom[0.7,0.9], "leg_r", selectrandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
sleep 0.2;
[pat, selectRandom[0.7,0.9], "leg_l", selectrandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
sleep 0.2;
[pat, selectRandom[0.7,0.9], "body", selectrandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
sleep 0.2;
[pat, selectRandom[0.7,0.9], "head", selectrandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
sleep 0.2;
[pat, selectRandom[0.7,0.9], "hand_r", selectrandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
sleep 0.2;
[pat, selectRandom[0.7,0.9], "hand_l", selectrandom ["stab","bullet","falling"]] call ace_medical_fnc_addDamageToUnit;
sleep 0.2;
[MedicalData1,0] call BIS_fnc_dataTerminalAnimate;
hint 'Zespawnowano pacjenta';