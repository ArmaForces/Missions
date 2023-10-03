/*
	AF_fnc_checkVitalsLoop

	Description:
		Uruchamia pętle która obserwuje stan zdrowia gracza.

	Parameter(s):
		NOTHING

	Returns:
		NOTHING
*/
[{
	private _player = player;

	// Reschedule checks if disabled or unit not alive
	if (!AF_hardcoreDamageEnabled || !alive _player) exitWith {_this call AF_fnc_checkVitalsLoop};

	private _bloodVolume = _player getVariable ["ace_medical_bloodvolume", 100];
	private _heartRate = _player getVariable ["ace_medical_heartrate", 80];

	// Units with blood volume below set value will be killed
	if (_bloodVolume < AF_hardcoreDamageMinBloodVol) then {
		[format ["Śmierć poprzez wykrwawienie: %1", _player], "Damage"] call AF_fnc_serverLog;
		_player setDamage 1;
	};

	/*
	// If no heart rate schedule a heart attack that will kill the unit
	if (_heartRate < 5) then {
		if !(_player getVariable ["AF_heartAttack", false]) then {
			[format ["Zatrzymanie akcji serca: %1", _player], "Damage"] call AF_fnc_serverLog;
			_player setVariable ["AF_heartAttack", true, true];
			// Schedule the death
			[{
				params ["_player"];
				private _heartRate = _player getVariable ["ace_medical_heartrate", 80];
				// If player still has no heart rate and he wasn't killed in meantime by something else, kill him
				if (_heartRate < 5 && (_player getVariable ["AF_heartAttack", false])) then {
					[format ["Śmierć na zawał: %1", _player], "Damage"] call AF_fnc_serverLog;
					_player setDamage 1;
				};
				_player setVariable ["AF_heartAttack", false, true];
			}, [_player], AF_hardcoreDamageHeartAttackTime] call CBA_fnc_waitAndExecute;
		};
	};
	*/

	// Loop
	_this call AF_fnc_checkVitalsLoop;

}, nil, 10] call CBA_fnc_waitAndExecute;