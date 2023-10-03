/*
	Description:
		Inicjalizacja ustawień CBA dla AI
*/

[
	// Global var name
	"AF_enableAI",
	// Setting type
	"CHECKBOX",
	// Title, Tooltip
	[
		"Madinowe AI",
		"AI jest dynamiczniejsze, agresywniejsze, flankuje, biega i robi fikołki. Czasem może ignorować polecenia zeusa."
	],
	// Category, Subcategory
	["_AI", "Główne"],
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
	"AF_Ai_tracers",
	// Setting type
	"CHECKBOX",
	// Title, Tooltip
	[
		"Tracery dla AI",
		"Podmienia wszystkim botom pociski na tracery, o ile taki magazynek istnieje."
	],
	// Category, Subcategory
	["_AI", "Główne"],
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
	"AF_Hide_distance",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Chowanie AI",
		"powyżej ilu metrów AI zacznie się chować / bronić zamiast atakować (by nie biegały przez pół mapy). Pojedynczym grupom można ustawić własną odległość w init grupy (this setVariable ['hideDistance',100])."
	],
	// Category, Subcategory
	["_AI", "Główne"],
	// Extra params, depending on settings type
	[10, 1000, 150, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

/*
[
	// Global var name
	"AF_AI_voice",
	// Setting type
	"CHECKBOX",
	// Title, Tooltip
	[
		"Odgłosy botów CHWILOWO WYŁĄCZONE",
		"Boty wydają odgłosy, porozumiewają się ze sobą, rzucają obelgi w stronę wroga, krzyczą z bólu itd. Na razie tylko po angielsku."
	],
	// Category, Subcategory
	["_AI", "Główne"],
	// Extra params, depending on settings type
	false,
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;
*/

[
	// Global var name
	"AF_grenadeSpam",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Spam granatami",
		"Co ile sekund bot będzie szukał możliwości rzutu granatem /strzelał z rpg. Im mniej tym więcej :PTSD:."
	],
	// Category, Subcategory
	["_AI", "PTSD"],
	// Extra params, depending on settings type
	[5, 300, 60, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"AF_RPG_spam",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Spam RPG",
		"ile % szans na to, by bot zamiast rzucić granatem strzelił z RPG. Jeśli nie będzie mógł, rzuci granatem (jak będzie taka możliwość)."
	],
	// Category, Subcategory
	["_AI", "PTSD"],
	// Extra params, depending on settings type
	[0, 100, 75, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"AF_aimingAccuracy",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Aiming accuracy",
		"globalne ustawienia AI na start misji / jednostki zeusa."
	],
	// Category, Subcategory
	["_AI", "Globalne ustawienia botów"],
	// Extra params, depending on settings type
	[0, 1, 0.2, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"AF_aimingShake",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Aiming shake",
		"globalne ustawienia AI na start misji / jednostki zeusa."
	],
	// Category, Subcategory
	["_AI", "Globalne ustawienia botów"],
	// Extra params, depending on settings type
	[0, 1, 0.2, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"AF_spotDistance",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Spot distance",
		"globalne ustawienia AI na start misji / jednostki zeusa."
	],
	// Category, Subcategory
	["_AI", "Globalne ustawienia botów"],
	// Extra params, depending on settings type
	[0, 1, 0.8, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"AF_spotTime",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Spot time",
		"globalne ustawienia AI na start misji / jednostki zeusa."
	],
	// Category, Subcategory
	["_AI", "Globalne ustawienia botów"],
	// Extra params, depending on settings type
	[0, 1, 0.8, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"AF_courage",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Courage",
		"globalne ustawienia AI na start misji / jednostki zeusa."
	],
	// Category, Subcategory
	["_AI", "Globalne ustawienia botów"],
	// Extra params, depending on settings type
	[0, 1, 0.8, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"AF_Commanding",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"commanding",
		"globalne ustawienia AI na start misji / jednostki zeusa."
	],
	// Category, Subcategory
	["_AI", "Globalne ustawienia botów"],
	// Extra params, depending on settings type
	[0, 1, 1, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"AF_aimingSpeed",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Aiming speed",
		"globalne ustawienia AI na start misji / jednostki zeusa."
	],
	// Category, Subcategory
	["_AI", "Globalne ustawienia botów"],
	// Extra params, depending on settings type
	[0, 1, 0.7, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"AF_general",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"General",
		"globalne ustawienia AI na start misji / jednostki zeusa."
	],
	// Category, Subcategory
	["_AI", "Globalne ustawienia botów"],
	// Extra params, depending on settings type
	[0, 1, 1, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"AF_endurance",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Endurance",
		"globalne ustawienia AI na start misji / jednostki zeusa."
	],
	// Category, Subcategory
	["_AI", "Globalne ustawienia botów"],
	// Extra params, depending on settings type
	[0, 1, 1, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"AF_reloadSpeed",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Reload speed",
		"globalne ustawienia AI na start misji / jednostki zeusa."
	],
	// Category, Subcategory
	["_AI", "Globalne ustawienia botów"],
	// Extra params, depending on settings type
	[0, 1, 0.8, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"AF_randomSkill",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Random skill",
		"podwyższa każdy skill bota o losową wartość z zakresu 0 do podanej."
	],
	// Category, Subcategory
	["_AI", "Globalne ustawienia botów"],
	// Extra params, depending on settings type
	[0, 1, 0.15, 2],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"AF_AIaimPenalty",
	// Setting type
	"CHECKBOX",
	// Title, Tooltip
	[
		"Kara do celności",
		"AI otrzymuje większe kary do celności."
	],
	// Category, Subcategory
	["_AI", "Globalne ustawienia botów+"],
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
	"AF_aimPenaltyTime",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Czas kary",
		"Ile sekund będzie trwała kara do celności po każdym trafieniu. Kara maleje z czasem."
	],
	// Category, Subcategory
	["_AI", "Globalne ustawienia botów+"],
	// Extra params, depending on settings type
	[1, 120, 30, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"AF_aimPenaltyStrength",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Siła kary",
		"Mnożnik wartości kary do celności."
	],
	// Category, Subcategory
	["_AI", "Globalne ustawienia botów+"],
	// Extra params, depending on settings type
	[0, 5, 1, 1],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"AF_aimPenaltyMax",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Maksymalna siła kary",
		"Kara do celności nie będzie większa od podanej. wartości powyżej 30-50 mogą dać 'nietypowe' efekty."
	],
	// Category, Subcategory
	["_AI", "Globalne ustawienia botów+"],
	// Extra params, depending on settings type
	[0, 100, 30, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;