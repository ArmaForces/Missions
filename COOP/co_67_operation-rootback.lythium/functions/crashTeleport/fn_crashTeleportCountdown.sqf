/*
	AF_fnc_crashTeleportCountdown

	Description:
		Funkcja (pętla) odliczająca czas

	Parameter(s):
		[SCALAR]: _timer - długość odliczania (s)
		[STRING]: _msg - sformatowana wiadomość z %1 jako pozostały czas

	Returns:
		NOTHING
*/

params ["_timer", "_msg"];
[{
	params ["_timer", "_msg"];
	titleText [format [_msg, _timer], "PLAIN", -1, true, true];
	if (_timer > 0) exitWith {
		_timer = _timer - 1;
		[_timer, _msg] call AF_fnc_crashTeleportCountdown;
	};
}, [_timer, _msg], 1] call CBA_fnc_waitAndExecute;