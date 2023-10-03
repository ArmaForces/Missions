/*
	AF_fnc_playerKilledSpectator

	Description:
		Funkcja tworzy efekty postprocessingowe oraz inicjalizuje obserwatora dla martwych graczy.

	Parameter(s):
		NOTHING

	Returns:
		NOTHING
*/

// Efekty postprocessingowe
_handle = ppEffectCreate ["ColorCorrections", 1500];
_handle ppEffectEnable true;
_handle ppEffectAdjust [0, 1, 0, [0, 0, 0, 0], [1, 1, 1, 1], [0.299, 0.587, 0.114, 0],[-1, -1, 0, 0, 0, 0, 0]];
_handle ppEffectCommit 5;
// Czekaj aż skończą się efekty postprocessingowe
[{ppEffectCommitted _this}, {
	private _handle = _this;
	// Kolejne efekty postprocessingowe
	_handle ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [1, 1, 1, 1], [0.299, 0.587, 0.114, 0],[-1, -1, 0, 0, 0, 0, 0]];
	_handle ppEffectCommit 5;
	// Sprawdź czy strona nie ma ticketów i gracz nie żyje, jeśli tak to włącz normalnego obserwatora
	if ([playerSide] call BIS_fnc_respawnTickets <= 0) then {
		if (!alive player) then {
			["Initialize", [player, [], false, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator;
		};
	} else {
		private _cam = cameraNull;
		if (AF_respawnCamType != 2) then {
			// Default
			// First person spectator
			["Initialize", [player, [], false, false, false, true, true, true, true, true]] call BIS_fnc_EGSpectator;
		} else {
			// Cinematic death cam
			_cam = "camera" camCreate [(position player select 0), (position player select 1) - 1, 1];
			player setVariable ["AF_cam", _cam];
			_cam camSetTarget player;
			_cam cameraEffect ["internal", "BACK"];
			showCinemaBorder false;
			_cam camCommit 0;
			_cam camSetPos [position player select 0, (position player select 1) + 5, (position player select 2) + 7.5];
			_cam camCommit 60;
		};
		// Czekaj na respawn lub brak ticketów
		[{alive player || {([playerSide] call BIS_fnc_respawnTickets) <= 0}}, {
			// Usuń efekty kamery
			if (!isNull _this) then {
				_this cameraEffect ["terminate","back"];
				camDestroy _this;
				player setVariable ["AF_cam",nil];
			};
			// Sprawdź czy strona nie ma ticketów i gracz nie żyje, jeśli tak to włącz normalnego obserwatora
			if (!alive player && ([playerSide] call BIS_fnc_respawnTickets) <= 0) then {
				// Prewencyjny restart
				["Terminate"] call BIS_fnc_EGSpectator;
				["Initialize", [player, [], false, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator;
			};
		}, _cam, -1] call CBA_fnc_waitUntilAndExecute;
	};

	// Czekaj aż zakończy się animacja kamery
	[{ppEffectCommitted _this}, {
		_this ppEffectEnable false;
		ppEffectDestroy _this;
	}, _handle, -1] call CBA_fnc_waitUntilAndExecute;
}, _handle, -1] call CBA_fnc_waitUntilAndExecute;