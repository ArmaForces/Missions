#define MARKER_LINK(MARKER_NAME, LINK_TEXT)		+ "<marker name='"+MARKER_NAME+"'>"+LINK_TEXT+"</marker>" +

private _t_main = [
	't_main',
	"Operacja Rootback",
	"Amerykańskie siły szybkiego reagowania otrzymały informację, od jednego z informatorów, o możliwej broni nuklearnej w prowincji Lythium. 
	Dowództwo NATO zarządziło natychmiastową reakcję i podjęcie działań mających na celu przechwycenie głowicy oraz urządzenia zdolnego ją zdetonować.
	<br/><br/>
	Minęło 70 minut od otrzymania informacji od informatora, próby ponownego nawiązania kontaktu zakończyły się niepowodzeniem. 
	Mamy jedynie kilka niewyraźnych zdjęć, na podstawie których powinniśmy ustalić jego ostatnią pozycję i wyruszyć na poszukiwanie głowicy.",
	""
];


private _t_nuke = [
	't_nuke',
	"Zabezpiecz broń nuklearną",
	"Gdzieś w prowincji znajduje się głowica nuklearna oraz urządzenie zdolne ją zdetonować. 
	Naszym zadaniem jest odnaleźć ją nim zostanie wywieziona lub zdetonowana.",
	""
];

private _t_spy = [
	't_spy',
	"Uratuj informatora",
	"Nasz informator, który prowadzi swoją misję od września 2017 roku, może być w niebezpieczeństwie. 
	Transmisja danych została przerwana bez ostrzeżenia ze strony informatora, być może ktoś znalazł urządzenie transmisyjne i przerwał transfer. 
	Niestety nasz informator nie odezwał się od tamtej pory. 
	W związku z tym musimy założyć, iż został on zdekonspirowany i w każdej chwili może stracić życie. 
	Nie możemy na to pozwolić.",
	""
];

private _t_idap = [
	't_idap',
	"Znajdź i uwolnij wolontariuszy IDAP",
	"Kilka dni temu IDAP zgłaszał, iż trzech wolontariuszy zaginęło podczas transportu wody i żywności do "MARKER_LINK('sys_marker_amir', 'wioski Amir')". 
	Oddział ratunkowy nie znalazł żadnych śladów poza rozbitą cysterną niedaleko wioski i telefonem komórkowym jednego z wolontariuszy.",
	""
];

private _t_officer_gue = [
	't_officer_gue',
	"Ujmij przywódcę lokalnych rebeliantów",
	"Lokalni rebelianci byli przez nas bardzo długo ignorowani i obserwowani, ale koniec z tym. 
	Nie pozwolimy im na zdobycie broni masowego rażenia, a dodatkowo pozbawimy ich przywódcy, co powinno spowodować, iż przestaną stanowić jakiekolwiek zagrożenie dla nas i ludności cywilnej.
	<br/><br/>
	ONZ pragnie dostać go żywcem by móc osądzić go za jego zbrodnie, ale nie sugerujcie się tym zbytnio. 
	Głównym celem jest unieszkodliwienie bojówki i przywrócenie spokoju w prowincji.",
	""
];

private _t_officer_tak = [
	't_officer_tak',
	"Ujmij przywódcę armii takistańskiej",
	"Na zdjęciach dostarczonych przez informatora przewija się takistański oficer, prawdopodobnie maczający palce w handlu bronią nuklearną. 
	Możemy się spodziewać uderzenia takistańskich sił od północnego zachodu w przypadku, gdy poczuje się zagrożony. 
	Ujęcie go mogłoby doprowadzić do rozbicia rynku nielegalnej broni nuklearnej.
	<br/><br/>
	Jego też pragną dostać żywcem, żeby postawić mu zarzuty handlu bronią masowego rażenia oraz innych nieładnych rzeczy. 
	Z nim sprawa nie jest taka prosta, gdyż zabicie go pozbawi nas punktu zaczepienia w pogoni za czarnym rynkiem.
	Oprócz tego jest żołnierzem sąsiadującego państwa i nie powinien zginąć od kuli amerykańskiego żołnierza. 
	W związku z tym nie wolno Wam go zabić bez przyczyny.",
	""
];