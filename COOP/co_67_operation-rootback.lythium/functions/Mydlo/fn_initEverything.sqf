if (!isServer) exitWith {};

//[_x, true, [0, 2, 0], 45] call ace_dragging_fnc_setDraggable;

//factory_notepad
//factory_pen

//temple_laptop
//temple_files
//temple_phone
//temple_money
//temple_sheet

//\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa

[temple_sheet,"Przeczytaj kartkę", "", "", "true", "true", {}, {}, {
	private _msg = "<ARABIC DATE>2019.06.27 14:26</ARABIC DATE>
	<br/><br/>
	<ARABIC TEXT>Kupimy głowicę, zwabimy amerykanów do Arobster i tam ich wykończymy. Za 3 dni, o 16:00.</ARABIC TEXT>";
	titleText [_msg, "PLAIN DOWN", 1];
}, {}, [], 2, nil, false, false] remoteExec ["BIS_fnc_holdActionAdd", 0, true];

[factory_notepad, "Przeczytaj notatkę", "", "", "true", "true", {}, {}, {
	private _msg = "14:43
	<br/><br/>
	Ładują urządzenie na ciężarówkę, pewnie teraz po głowicę jedziemy. Coś mówili o jakimś miasteczku i rzece.";
	titleText [_msg, "PLAIN DOWN", 1];
}, {}, [], 2, 10, false, false] remoteExec ["BIS_fnc_holdActionAdd", 0, true];

// arobster_tunnel_start
// arobster_tunnel_end
[arobster_tunnel_start, "Użyj tunelu", "", "", "true", "true", {}, {}, {
	private _caller = _this select 1;
	_caller setPos (getPos arobster_tunnel_end);
	if (isNil 'arobster_tunnel_used') exitWith {
		arobster_tunnel_used = true;
		publicVariable "arobster_tunnel_used";
		[arobster_tunnel_end, "Użyj tunelu", "", "", "true", "true", {}, {}, {
			private _caller = _this select 1;
			_caller setPos (getPos arobster_tunnel_start);
		}, {}, [], 2, 10, false, false] remoteExec ["BIS_fnc_holdActionAdd", 0, true];
	};
}, {}, [], 2, 10, false, false] remoteExec ["BIS_fnc_holdActionAdd", 0, true];


//suv_armored
suv_armored animateSource ["CloseCover1", 1];
suv_armored animateSource ["CloseCover2", 1];
suv_armored animateSource ["HideGun_01", 1];
suv_armored animateSource ["HideGun_02", 1];
suv_armored animateSource ["HideGun_03", 1];
suv_armored animateSource ["HideGun_04", 1];

//nuclear_device
//[[(getPos nuclear_device)], "Mydlo\nuke5kt.sqf"] remoteExec ["execVM", 0];