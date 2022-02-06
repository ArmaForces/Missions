class ADDON {
    tag = QUOTE(ADDON);
    class functions {
        file = "functions";
        class joinGroup {};
        class randomizePlates {};

        // Locations
        class getAllMapCities {};
        class getNearestCityWithAvailableName {};
        class getNearestLocationWithAvailableName {};
        class getLocationName {};
        class getNearestCityLocation {};
        class getNearestCityName {};
        class getNearestLocation {};
        class getNearestLocationName {};

        // Tasks
        class tasksClientEvents { postInit = 1; };
        class tasksServerEvents { postInit = 1; };

        // Stuff
        class awacsInit { postInit = 1; };
        class awacsLoop {};
        class getHighestRankedPlayers {};
        class mapCleanup { postInit = 1; };
        class markerDecayLoop {};

        // Utility
        class createActions {};
        class createTeleport {};
        class changeSide {};
        class createStartPositionMarker {};
        class deleteStartPositionsMarkers {};
        class initializeBluforSpawn {};
        class initializeRedforSpawn {};
        class deleteAtRandom {};
        class randomizeTeams {};
    };
};

class AF {

        class dialogs {
            class groupRenameGUI {};
            class groupRenameList {};
            class setViewDistance {};
            class viewDistanceGUI {};
        };

        class player {
            class playerActions {};
        };

};