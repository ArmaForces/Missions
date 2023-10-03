//[] AF_fnc_faggotsPunish	-	[jednostka] - ukaraj konkretnego Faggotsa, [brak parametru] - ukaraj wszystkich Faggotsów i włącz karanie każdego kolejnego przewinienia.

//Powoduje ukaranie Faggotsów za wszystkie dotychczasowe przewinienia oraz powoduje karanie każdego kolejnego przewinienia.
//Ponadto, jeżeli funkcja dostanie jako parametr konkretną jednostce gracza, to ukarany zostanie tylko ten gracz.

if (isServer) then
{
	_faggot = param [0, objNull, [objNull]];
	_AF_faggots = "brak";
	_chat_text = "brak_tekstu";
	_faggot_factor_local = -1;
	
	if (isNil {eh_faggots}) 
	then 
	{
		{[getAssignedCuratorUnit(_x),"Jak tu karać Faggotsów skoro Faggots log jest wyłączone?"] remoteExec ["sideChat", _x];} foreach allCurators;
	}
	else
	{
		if (!isNull _faggot) then 
		{
			if (_faggot in allPlayers) 
			then
			{
				_AF_faggots = [] + [_faggot];
				_chat_text = "No to karzemy jednego Faggotsa - "+name(_faggot)+"!";
			}
			else
			{
				_chat_text = "Obiekt "+name(_faggot)+" ("+str(_faggot)+") nie jest graczem!";
			};
		}
		else
		{
			//_AF_faggots = allPlayers - entities "HeadlessClient_F";
			_AF_faggots = [] call CBA_fnc_players;
			_chat_text = "No to karzemy wszystkich Faggotsow!";
			faggots_punish = true;
		
		};

		{[getAssignedCuratorUnit(_x),_chat_text] remoteExec ["sideChat", _x]} foreach allCurators;
		[_chat_text] remoteExec ["diag_log",2];

		{
			_faggot = _x;
			_chat_text = "";
			_faggot_factor_local=-1;

			if (isNil{_faggot getvariable "faggot_factor"}) then {_faggot_factor_local=0;} else {_faggot_factor_local=(_faggot getvariable "faggot_factor");};
			switch (_faggot_factor_local) do
			{
				case 0: 
				{
					_chat_text = "Faggots - "+name(_faggot)+", 0 szt. przewinien - git gosc";
				};
				case 1: 
				{
					_chat_text = "Faggots - "+name(_faggot)+", 1 szt. przewinien - mały bol";
				};
				case 2: 
				{
					[_faggot,"AmovPercMstpSnonWnonDnon_exercisePushup"] remoteexec ["playmove",0];
					_chat_text = "Faggots - "+name(_faggot)+", 2 szt. przewinien - pompki";
				};
				case 3:
				{
					[_faggot] spawn
					{
						[(_this select 0),"AmovPercMstpSsurWnonDnon"] RemoteExeccall ["AF_fnc_anim",0];
						sleep 60; 
						[(_this select 0),"AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon"] RemoteExeccall ["AF_fnc_anim",0];
					};
					_chat_text = "Faggots - "+name(_faggot)+", 3 szt. przewinien - rece na glowie 1 minute";
				};
				case 4: 
				{
					[_faggot] spawn
					{
						params["_faggot_local"];
						sleep 2;
						[_faggot_local,true,120] remoteExecCall ["ace_medical_fnc_setUnconscious",_faggot_local];
					};
					_chat_text = "Faggots - "+name(_faggot)+", 4 szt. przewinien - nieprzytomny 2 minuty";
				};
				case 5: 
				{
					[_faggot] spawn
					{
						params["_faggot_local"];
						sleep 2;
						[_faggot_local,true,300] remoteExecCall ["ace_medical_fnc_setUnconscious",_faggot_local];
					};
					_chat_text = "Faggots - "+name(_faggot)+", 5 szt. przewinien - nieprzytomny 5 minut";
				};
				default 
				{						
					[ ["<t color='#ffffff'size='10' align='center' valign='top'>"+name(_faggot)+"<br/><br/></t>"
					+"<t color='#ff0000'size='6' valign='top'>Zawiodłeś ArmaForces.<br/></t>"
					+"<t color='#ff0000'size='6' valign='top'>Żegnamy.<br/></t>"
					, "PLAIN", -1, true, true] ] remoteExec ["titleText",_faggot];
				
					[_faggot] spawn
					{
						params["_faggot_local"];			
						sleep 3;
						"haslodokomend1" serverCommand format ["#kick %1",name(_faggot_local)];
					};
					_chat_text = "Faggots - "+name(_faggot)+" - "+str(_faggot_factor_local)+" szt. przewinien - kick raka";
				};
			};
			
			if (_faggot_factor_local>0) 
			then 
			{
				[_chat_text] remoteExec ["diag_log",2];
				{[getAssignedCuratorUnit(_x),_chat_text] remoteExec ["commandChat",_x];} foreach allCurators;
			};
			
			[_faggot,-100] remoteExecCall ["ace_medical_fnc_adjustPainLevel",_faggot];
			for [{_i=0},{_i < _faggot_factor_local},{_i = _i + 1}] do {[_faggot,0.2] remoteExecCall ["ace_medical_fnc_adjustPainLevel",_faggot];};
			
			if (_faggot_factor_local == 0) then {[_faggot,"Faggots - nie został Pan ukarany, gratulujemy Panu RIGCZu."] remoteExec ["groupChat",_faggot];} 
			else {[_faggot,"Faggots - został Pan ukarany za "+str(_faggot_factor_local)+" szt. przewinień wobec ArmaForces."] remoteExec ["groupChat",_faggot];};
			
			if (_faggot_factor_local>5) then {["Faggots - gracz "+name(_faggot)+" nie jest godzien rozgrywki z ArmaForces."] remoteExec ["systemChat",0];};
			
		} foreach _AF_faggots;

		_chat_text = "Koniec karania Faggotsów!";
		{[getAssignedCuratorUnit(_x),_chat_text] remoteExec ["sideChat", _x]} foreach allCurators;
		[_chat_text] remoteExec ["diag_log",2];
	};
};