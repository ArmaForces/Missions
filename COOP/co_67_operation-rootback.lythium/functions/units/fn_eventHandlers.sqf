// Event Handlery dla jednostek AI ze wsparciem zmiany lokalności.
params ["_unit"];

_fnc_handleGetOut = {
	params ["_unit"];

	switch (AF_getOutAiStyle) do {
		case 1: {
			_unit playActionNow "ReloadMagazine";
		};
		// Serbian option
		case 2: {
			[_unit] spawn {
				private _unit = _this select 0;
				sleep 0.3;
				[_unit, true, 2, true] call ace_medical_fnc_setUnconscious;
			};
		};
		default {};
	};
};

private _id = _unit addEventHandler ["GetOutMan", _fnc_handleGetOut];
private _localEH = _unit getVariable ["AF_localEH", []];
_localEH pushBack ["GetOutMan", _id];


private _idPenalty = _unit addEventHandler ["HitPart", {
	(_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];
	if (isPlayer _target) then {[_shooter] call AF_AIaimPenaltyHandler}
}];
private _localEH = _unit getVariable ["AF_localEH", []];
_localEH pushBack ["HitPart", _idPenalty];



// Dodanie handlera który poprawnie obsłuży zmiane lokalności
private _idL = _unit addEventHandler ["Local", {
	params ["_entity", "_isLocal"];
	// Jeżeli obiekt już nie jest lokalny to usuwamy nasze lokalne handlery i dodajemy wszystko tam gdzie został przeniesiony
	if (!_isLocal) then {
		private _localEH = _entity getVariable ["AF_localEH", []];
		{
			_x params ["_event", "_id"];
			_entity removeEventHandler [_event, _id];
		} forEach _localEH;

		_entity setVariable ["AF_localEH", nil];
		[_entity] remoteExec ["AF_fnc_eventHandlers", _entity, false];
	};
}];

private _localEH = _unit getVariable ["AF_localEH", []];
_localEH pushBack ["Local", _idL];

_unit setVariable ["AF_localEH",_localEH];
