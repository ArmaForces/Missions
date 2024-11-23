/*
Assigns patient spawning actions to player

Params:
None

Returns:
None

Example:
[] call AL_fnc_medicalTrainingStart

Locality:
Runs local. Effect local.
*/

private _action = player addAction ["Zdrowy",{[0] spawn AL_fnc_spawnwounded;}];
medicalActions pushback _action;
private _action = player addAction ["Lekko ranny",{[1] spawn AL_fnc_spawnwounded;}];
medicalActions pushback _action;
private _action = player addAction ["Ciezko ranny",{[2] spawn AL_fnc_spawnwounded;}];
medicalActions pushback _action;
private _action = player addAction ["Krytyczny",{[3] spawn AL_fnc_spawnwounded;}];
medicalActions pushback _action;