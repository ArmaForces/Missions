//[] AF_fnc_faggotsLog		-	[1] - włącz log faggotsów, [0] - wyłącz log faggotsów, [brak parametru] lub [-1] - switchuje działanie funkcji.

//Włącz powoduje włączenie loga Faggotsów, domyślnie odpala się przy inicie misji.

//Wyłącz powoduje wyłączenie loga Faggotsów, należy użyć gdy gracze skończyli robić gnój na starcie i realizują cel misji
//oraz gdy chcemy odwołać karanie Faggotsów i umożliwić normalną rozgrywkę.

if (isServer) then
{
	_modeonoff = param [0, -1, [0,""] ];

	if (typename _modeonoff == "STRING") then {	if (_modeonoff == "postInit") then {_modeonoff = 1;}; };

	if (_modeonoff == -1)
	then
	{
		if (isNil {eh_faggots}) then {_modeonoff = 1;} else {_modeonoff = 0;};
	};

	if (_modeonoff == 1 && !(isNil {eh_faggots})) then {{"Faggots - chcesz włączyć włączony skrypt, nu nu" remoteExec ["systemChat", _x]} foreach allCurators;};

	if (_modeonoff == 0 && (isNil {eh_faggots})) then {{"Faggots - chcesz wyłączyć wyłączony skrypt, nu nu" remoteExec ["systemChat", _x]} foreach allCurators;};

	if (_modeonoff == 1 && isNil {eh_faggots})
	then
	{
		faggots = [];
		faggots_full = [];
		faggots_punish = false;

		eh_faggots = ["ace_firedPlayerNonLocal",
		{
			params ["_faggot", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

			_faggot_factor_local=0;
			_faggot_incident = "";
			_faggot_time = 0;
			_faggot_info = "";

			if (isNil{_faggot getvariable "faggot_factor"})then{_faggot_factor_local=0;}
			else {_faggot_factor_local=_faggot getvariable "faggot_factor";};

			if (_faggot_factor_local == 0) then	{_faggot_factor_local = 1;}
			else {_faggot_factor_local = _faggot_factor_local + 1;};

			_faggot setvariable ["faggot_factor", _faggot_factor_local];

			if (_weapon == "Throw") then {_faggot_incident = "rzucil "+_ammo;} else {_faggot_incident = "strzelil z "+_muzzle;};

			_faggot_time = str(floor(time/60))+" m "+str(floor(time)-(floor(time/60)*60))+" s";
			_faggot_info = _faggot_time + " - " + (name _faggot) + " " + (_faggot_incident)+" (factor "+str(_faggot_factor_local)+")";

			{[getAssignedCuratorUnit(_x),_faggot_info] remoteExec ["sideChat", _x]} foreach allCurators;

			_faggots_local = faggots;
			_faggots_local pushBackUnique (name _faggot);
			faggots = [] + _faggots_local;

			_faggots_full_local = faggots_full;
			_faggots_full_local pushBack (_faggot_info);
			faggots_full = [] + _faggots_full_local;

			if (faggots_punish isEqualTo true) then {[_faggot] call AF_fnc_faggotsPunish;};
		}
		] call CBA_fnc_addEventHandler;

		if (!(isNil {eh_text})) then {["Faggots log zostało włączone (ON)."] remoteExec ["systemChat", 0];} else {eh_text = addMissionEventHandler ["PreloadFinished", {["Faggots log zostało włączone (ON)."] remoteExec ["systemChat", 0];}]};
	};

	if (_modeonoff == 0 && !(isNil {eh_faggots}))
	then
	{
		//_AF_players = allPlayers - entities "HeadlessClient_F";
		_AF_faggots = [] call CBA_fnc_players;
		{
			if (_x getvariable "faggot_factor" != 0)
			then
			{
				[_x,false] remoteExecCall ["ace_medical_fnc_setUnconscious",_x];
				[_x,-100] remoteExecCall ["ace_medical_fnc_adjustPainLevel",_x];
				[_x,""] RemoteExecCall ["AF_fnc_anim",0];
				_x setvariable ["faggot_factor", 0];
			};
		}
		foreach _AF_players;

		["ace_firedPlayerNonLocal", eh_faggots] call CBA_fnc_removeEventHandler;
		eh_faggots = nil;
		faggots_punish = false;

		["Faggots log zostało wyłączone (OFF)."] remoteExec ["systemChat", 0];
	};
};