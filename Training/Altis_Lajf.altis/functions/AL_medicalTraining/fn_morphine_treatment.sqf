/*
Adds morphine to patient and makes him inject it.

Params:
None

Returns:
None

Example:
[] call AL_fnc_morphine_treatment;

Locality:
Runs local. Effect local.
*/

_this select 0 addItem "ACE_morphine";
_this select 0 addItem "ACE_morphine";
[_this select 0, _this select 0, "hand_l","morphine"] call ace_medical_fnc_treatment;
[_this select 0, _this select 0, "hand_l","morphine"] call ace_medical_fnc_treatment;
[_this select 0, -30, 1] call ace_medical_fnc_addHeartRateAdjustment;