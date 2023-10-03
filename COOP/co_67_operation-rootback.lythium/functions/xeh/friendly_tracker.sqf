/*
	Description:
		Inicjalizacja ustawień CBA dla markerów
*/

// Default: true
[
	// Global var name
	"AF_friendlyTrackerEnabled",
	// Setting type
	"CHECKBOX",
	// Title, Tooltip
	[
		"Markery sojuszniczych jednostek",
		"Właczenie tej opcji powoduje uruchomienie skrypu który wskazuje lokalizacje sojuszniczych jednostek na mapie."
	],
	// Category, Subcategory
	["_Zaawansowane ustawienia misji", "Markery"],
	// Extra params, depending on settings type
	true,
	// Is global
	true,
	// Init/Stop script
	{
		if(_this) exitWith {
			[] call AF_fnc_friendlyTrackerInit;
		};
	},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

// Default: false
[
	// Global var name
	"AF_friendlyTrackerShowAllGroups",
	// Setting type
	"CHECKBOX",
	// Title, Tooltip
	[
		"Pokazuj wszystkie grupy",
		"Wyłaczenie tej opcji powoduje że gracz widzi tylko swoją grupe."
	],
	// Category, Subcategory
	["_Zaawansowane ustawienia misji", "Markery"],
	// Extra params, depending on settings type
	true,
	// Is global
	true,
	// Init/Stop script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

// Default: false
[
	// Global var name
	"AF_friendlyTrackerShowUnconc",
	// Setting type
	"CHECKBOX",
	// Title, Tooltip
	[
		"Oznaczaj nieprzytomnych",
		"Właczenie tej opcji powoduje oznaczenie nieprzytomnych jednostek na pomarańczowo."
	],
	// Category, Subcategory
	["_Zaawansowane ustawienia misji", "Markery"],
	// Extra params, depending on settings type
	false,
	// Is global
	true,
	// Init/Stop script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

// Default: 5
[
	// Global var name
	"AF_friendlyTrackerRefreshRate",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Okres odświeżania (s)",
		"Okres odświeżania markerów."
	],
	// Category, Subcategory
	["_Zaawansowane ustawienia misji", "Markery"],
	// Extra params, depending on settings type
	[1, 600, 5, 0],
	// Is global
	true,
	// Init/Stop script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

// Default: true
[
	// Global var name
	"AF_friendlyTrackerGPS",
	// Setting type
	"CHECKBOX",
	// Title, Tooltip
	[
		"Wymagaj GPS",
		"Właczenie tej opcji powoduje wyświetlanie pozycji jedynie jednostek posiadających przypisany GPS w ekwipunku."
	],
	// Category, Subcategory
	["_Zaawansowane ustawienia misji", "Markery"],
	// Extra params, depending on settings type
	false,
	// Is global
	true,
	// Init/Stop script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;