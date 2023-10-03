class AF {
	/*
		AI

		Funkcje do AI
	*/
	class ai {

	};
	/*
		Ares Modules

		Moduły zeusowe do różnych rzeczy
	*/
	class aresModules {
		class aresModulesEnvironmentLightsBlackout {
			postInit = 1;
		};
		class aresModulesFaggots {};
		class aresModulesSoundSelectAndSpawn {
			postInit = 1;
		};
		class aresModulesZeusMoveAfterCamera {
			postInit = 1;
		};
		class respawnAllDead {
			postInit = 1;
		};
	};

	/*
		Cache

		Funkcje do cache jednostek
	*/
	class cache {
		class cacheInit {};
		class cacheStop {};
	};

	/*
		Damage

		Obsługa obrażen gracza etc.
	*/
	class damage {
		class addDamageHandlers {};
		class checkVitalsLoop {};
		class createHitEffect {};
		class handleDamageHc {};
		class initializeDamage {
			preInit = 1;
		};
	};

	/*
		dialogs

		Funkcje pod GUI
	*/
	class dialogs {
		class groupRenameGUI {};
		class groupRenameList {};
		class setViewDistance {};
		class viewDistanceGUI {};
	};

	/*
		Faggots

		Loguje informacje o incydentach (strzelanie, granaty itd.)
	*/
	class faggots {
		class faggotsInfo {};
		class faggotsLog {};
		class faggotsPunish {};
	};

	/*
		friendlyTracker

		Markery wskazujące sojusznicze jednostki
	*/
	class friendlyTracker {
		class friendlyTrackerInit {};
		class friendlyTrackerLoop {};
		class friendlyTrackerStop {};
	};

	/*
		init

		Funkcje inicjalizujące
	*/
	class init {
		class main {};
		class player {};
		class server {};
	};

	/*
		Player

		Funkcje graczy
	*/

	class player {
		class playerActions {};
		class playerEHs {
			postInit = 1;
		};
		class playerKilledSpectator {};
	};

	/*
		Respawn

		Funkcje respawnu
	*/
	class respawn {
		class playerTicketsCheck {};
		class playerTicketsUpdate {};
		class respawnInit {
			postInit = 1;
		};
	};

	/*
		Server

		Funkcje serwerowe
	*/
	class server {
		class addToZeus {
			postInit = 1;
		};
	};

	/*
		Crash Teleport

		Teleportacja po wyrzuceniu z serwera
	*/
	class crashTeleport {
		class crashTeleportCheck {};
		class crashTeleportCountdown {};
		class crashTeleportDialog {};
		class crashTeleportPlayer {};
		class crashTeleportServer {};
		class crashTeleportServerHandler {
			postInit = 1;
		};
	};

	/*
		Units

		Funkcje jednostek ai/graczy
	*/
	class units {
		class AI_Init {};
		class aimPenalty {};
		class eventHandlers {};
		class killUncons {};
		class newAI {
			postInit = 1;
		};
		class skill {};
	};

	/*
		Util

		Funkcje pomocnicze różnego przeznaczenia
	*/
	class util {
		class anim {};
		class getAllLocalUnits {};
		class getCommandPwd {};
		class getCurrentZoom {};
		class localLog {};
		class restartAfterMissionEnd {};
		class serverLog {};
		class toggleNearLights {};
		class utilGlobals {
			preInit = 1;
		};
	};
};





	/*
		funkcje Madinowe
	*/
class M {
	class Madin {
		class agressive_ai {};
		class aiAskHelp {};
		class aihide {};
		class buildSpawn {};
		class dynamic_spawn {};
		class flank_ai {};
		class hunter_ai {};
		class loop_ai {};
		class M_AirespawnEH {};
		class magScript {};
		class spawn_ai {};
		class spawn_eh {};
		class spawnAI {};
	}
};