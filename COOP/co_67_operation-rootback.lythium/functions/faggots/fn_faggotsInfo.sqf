//[] AF_fnc_faggotsInfo		-	brak parametrów.

//Powoduje wyświetlenie na czacie informacji o aktualnym stanie zmiennej Faggots[], wskazującej kto robi gnój oraz informacji 
//o ostatnim wpisie zmiennej Faggots_full[], wskazującej wszystkie przewinienia graczy. Wybór ten powoduje też zapisanie w logu
//.rpt serwera stanu zmiennej Faggots[] oraz pełnego stanu zmiennej Faggots_full[].


if (isServer) then
{
	if (count faggots_full == 0) then {{[getAssignedCuratorUnit(_x),"Faggots - brak danych"] remoteExec ["sideChat", _x]} foreach allCurators;}
	else
	{
		_faggot_info = "Faggots: " + str(faggots);
		{[getAssignedCuratorUnit(_x),_faggot_info] remoteExec ["sideChat", _x]} foreach allCurators;
		[_faggot_info] remoteExec ["diag_log",2];

		_faggot_full_info = "Faggots_full: " + str(faggots_full);
		[_ares_faggot_full_info] remoteExec ["diag_log",2];
		
		_faggot_last_incident_info = "Faggots, ostatni incydent: " + str(faggots_full select (count faggots_full)-1);
		{[getAssignedCuratorUnit(_x),_faggot_last_incident_info] remoteExec ["sideChat", _x]} foreach allCurators;
	};
};