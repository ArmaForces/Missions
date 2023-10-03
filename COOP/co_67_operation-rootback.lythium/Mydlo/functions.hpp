class MDL {
	class Mydlo {
			// Initialize tasks
			class initTasks {
				postInit = 1;
			};
			// Initialize everything else
			class initEverything {
				postInit = 1;
			};
			class initTaskConditions {
				postInit = 1;
			};
			class scudLauncher {
				postInit = 1;
			};
			class cancelUnfinishedTasks {};
			// Nuke
			class nukeCountdown {};
			class nukeDetonate {};
			class nukeHandler {
				postInit = 1;
			};
			class nukeTimer {};
	};
};