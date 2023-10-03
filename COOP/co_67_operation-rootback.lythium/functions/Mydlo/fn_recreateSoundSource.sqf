params["_object"];

// Delete current radio play source (to stop current sound)
private _soundSource = _object getVariable ["MDL_soundSource", objNull];
deleteVehicle _soundSource;
// Create new radio play source
private _soundSource = "#particleSource" createVehicle ASLToAGL getPosWorld _object;
_object setVariable ["MDL_soundSource", _soundSource];
_soundSource;