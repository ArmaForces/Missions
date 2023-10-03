/*
	Description:
		Inicjalizacja ustawień CBA dla cache
*/

// Default: true
[
	// Global var name
	"Madin_cache_enabled",
	// Setting type
	"CHECKBOX",
	// Title, Tooltip
	[
		"Lokalne cache jednostek włączone",
		"Właczenie tej opcji powoduje uruchomienie skrypu który ukrywa/wyłacza jednostki które znajdują się dalej od gracza.\nSkrypt działa lokalnie."
	],
	// Category, Subcategory
	["_Zaawansowane ustawienia misji", "Cache"],
	// Extra params, depending on settings type
	true,
	// Is global
	true,
	// Init/Change script
	{
		if(_this) then {
			[] call AF_fnc_cacheInit;
		} else {
			[] call AF_fnc_cacheStop;
		};
	},
	// Needs mission restart
	false
] call CBA_Settings_fnc_init;