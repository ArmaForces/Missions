class AL {
	class AL_main {
		// Initialize tasks
		class preInit {
			preInit = 1;
		};
		class quadAction {
			postInit = 1;
		};
		class firedInBaseEH {
			postInit = 1;
		};
	};
	class AL_medicalTraining {
		class medicalTrainingInit {
			postInit = 1;
		};
		class medicalTrainingStart {};
		class medicalTrainingStop {};
		class morphine_treatment {};
		class spawnWounded {};
	}
	class AL_spawners {
		class deleteVehicle {};
		class getSpawnPoint {};
		class getSpawnerList {};
		class getVehiclesFromConfig {};
		class spawnerAddVehicles {};
		class spawnerInit {};
		class spawnersInit {
			postInit = 1;
		};
		class vehicleActions {};
		class vehicleGC {
			postInit = 1;
		};
		class vehicleSpawn {};
	};
	class AL_teleporters {
		class teleportersInit {
			postInit = 1;
		};
		class teleporterAddDestination {};
	};
};