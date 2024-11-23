/*
Removes patient spawning actions from player

Params:
None

Returns:
None

Example:
[] call AL_fnc_medicalTrainingStop

Locality:
Runs local. Effect local.
*/

{
	player removeAction _x;
} forEach medicalActions;
medicalActions = [];