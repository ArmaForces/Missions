/*
	Description:
		Inicjalizacja ustawień CBA dla misji
*/

[
	"AF_side",
	"LIST",
	[
		"Strona",
		"Strona, którą będzie rozgrywana misja."
	],
	["_Ustawienia misji","Respawn"],
	[
		[0,1,2,3],
		["BLUFOR","REDFOR","INDFOR","Cywile"],
		0
	]
] call cba_settings_fnc_init;

[
	// Global var name
	"AF_respawn_tickets",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Ilość respawnów",
		"Ilość respawnów na stronę. -1 dla permadeath."
	],
	// Category, Subcategory
	["_Ustawienia misji", "Respawn"],
	// Extra params, depending on settings type
	[-1, 300, 300, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"AF_respawnTime",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Czas respawnu",
		"Co ile sekund respawn. Respawn w fali, między wartością podaną wyżej a jej dwukrotnością."
	],
	// Category, Subcategory
	["_Ustawienia misji", "Respawn"],
	// Extra params, depending on settings type
	[1, 600, 180, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"AF_ticketsPerPlayer",
	// Setting type
	"CHECKBOX",
	// Title, Tooltip
	[
		"Respawn na osobę (nie działa, nie zaznaczać)",
		"Po zaznaczeniu ilość respawnu będzie przypisana do danej osoby, a nie strony."
	],
	// Category, Subcategory
	["_Ustawienia misji", "Respawn"],
	// Extra params, depending on settings type
	false,
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	"AF_respawnCamType",
	"LIST",
	[
		"Kamera pośmiertna",
		"Wybór kamery pośmiertnej"
	],
	["_Ustawienia misji","Respawn"],
	[
		[0,1,2],
		["Brak","Spectator 1 osoba","Kamera nad ciałem"],
		2
	]
] call cba_settings_fnc_init;

[
	// Global var name
	"AF_preciseRespawn",
	// Setting type
	"CHECKBOX",
	// Title, Tooltip
	[
		"Precyzyjny respawn",
		"Po zaznaczeniu gracze bedą się pojawiać dokładnie tam gdzie jest strzałka ""VR""."
	],
	// Category, Subcategory
	["_Ustawienia misji", "Respawn"],
	// Extra params, depending on settings type
	false,
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"AF_teleportWithItems",
	// Setting type
	"CHECKBOX",
	// Title, Tooltip
	[
		"Teleport z przedmiotami",
		"Po zaznaczeniu gracze bedą teleportować się razem ze sprzętem, który posiadali przed wyrzuceniem."
	],
	// Category, Subcategory
	["_Ustawienia misji", "Respawn"],
	// Extra params, depending on settings type
	true,
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"defaultviewdistance",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Domyślna odległość widzenia",
		"odległość widzenia na start misji."
	],
	// Category, Subcategory
	["_Ustawienia misji", "Odległość widzenia"],
	// Extra params, depending on settings type
	[0, 12000, 1500, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"maxviewdistance",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Maksymalna odległość widzenia",
		"Maksymalna odległość widzenia, którą można ustawić na misji."
	],
	// Category, Subcategory
	["_Ustawienia misji", "Odległość widzenia"],
	// Extra params, depending on settings type
	[0, 12000, 10000, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"minviewdistance",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Minimalna odległość widzenia",
		"Minimalna odległość widzenia, którą można ustawić na misji."
	],
	// Category, Subcategory
	["_Ustawienia misji", "Odległość widzenia"],
	// Extra params, depending on settings type
	[0, 12000, 500, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"AF_DetailDistance",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Trawa i detale terenu",
		"Ustawianie detali trawy i terenu, uniemożliwia wyłączenie trawy na klientach. 0 maksymalne detale, 50 brak trawy. -1 by wyłączyć wymuszanie detali."
	],
	// Category, Subcategory
	["_Ustawienia misji", "Odległość widzenia"],
	// Extra params, depending on settings type
	[-1, 50, 10, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	true
] call CBA_Settings_fnc_init;

[
	"AF_getOutAiStyle",
	"LIST",
	[
		"Sposób wychodzenia AI",
		"Akcja, jaką będzie wykonywać AI po wyjściu z pojazdu (uniemożliwi strzelanie bota od razu po wyjściu)."
	],
	["_Ustawienia misji","Wychodzenie z pojazdów"],
	[
		[0,1,2],
		["Brak","Animacja przeładowania","Ukyrta serbska opcja"],
		1
	]
] call cba_settings_fnc_init;

[
	// Global var name
	"AF_hiddenSerbianOption",
	// Setting type
	"CHECKBOX",
	// Title, Tooltip
	[
		"Ukryta serbska opcja dla graczy",
		"Uaktywnia ukrytą serbską opcję dla graczy."
	],
	// Category, Subcategory
	["_Ustawienia misji","Wychodzenie z pojazdów"],
	// Extra params, depending on settings type
	false,
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;