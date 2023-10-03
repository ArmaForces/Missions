/*
	Description:
		Inicjalizacja ustawień CBA dla obrażeń
*/

// Default: true
[
	// Global var name
	"AF_hardcoreDamageEnabled",
	// Setting type
	"CHECKBOX",
	// Title, Tooltip
	[
		"Nowy system obrażeń",
		"Właczenie tej opcji powoduje, że obrażenia otrzymywane przez graczy są obliczane logiczniej."
	],
	// Category, Subcategory
	["_Zaawansowane ustawienia misji", "Damage"],
	// Extra params, depending on settings type
	true,
	// Is global
	true,
	// Init/Change script
	{
		if(isServer) then {
			[format ["Zabójcze obrażenia: %1", _this], "Damage"] call AF_fnc_localLog;
		};
	},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

// Default: 20
[
	// Global var name
	"AF_hardcoreDamageMinBloodVol",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Minimalna ilość krwi (%)",
		"Gracze z ilością krwi poniżej tego progu zostaną zabici."
	],
	// Category, Subcategory
	["_Zaawansowane ustawienia misji", "Damage"],
	// Extra params, depending on settings type
	[5, 50, 20, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

/*
// Default: 250
[
	// Global var name
	"AF_hardcoreDamageHeartAttackTime",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Czas śmierci po zatrzymaniu akcji serca (s)",
		"Czas od zatrzymania akcji serca po jakim gracz ginie."
	],
	// Category, Subcategory
	["_Zaawansowane ustawienia misji", "Damage"],
	// Extra params, depending on settings type
	[10, 1800, 250, 0],
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
	"AF_hardcoreDamageHead",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Obrażenia głowy",
		"Gracze z obrażeniami powyżej tego progu zostaną zabici."
	],
	// Category, Subcategory
	["_Zaawansowane ustawienia misji", "Damage"],
	// Extra params, depending on settings type
	[1, 20, 6, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"AF_hardcoreDamageTorso",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Obrażenia tułowia",
		"Gracze z obrażeniami powyżej tego progu zostaną zabici."
	],
	// Category, Subcategory
	["_Zaawansowane ustawienia misji", "Damage"],
	// Extra params, depending on settings type
	[1, 20, 3, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;

[
	// Global var name
	"AF_hardcoreDamageAll",
	// Setting type
	"SLIDER",
	// Title, Tooltip
	[
		"Obrażenia całego ciała",
		"Gracze z obrażeniami powyżej tego progu zostaną zabici."
	],
	// Category, Subcategory
	["_Zaawansowane ustawienia misji", "Damage"],
	// Extra params, depending on settings type
	[1, 30, 16, 0],
	// Is global
	true,
	// Init/Change script
	{},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;