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
        class airThreatsLoop {};
        class awacsLoop {};
        class getHighestRankedPlayers {};
        class mapCleanup { postInit = 1; };
        class markerDecayLoop {};

        // Civilians handling
        class botComplyInit { postInit = 1; };
        //class botFlee {};
        //class botPunch {};
        class botSurrender {};
        class callComply {};
        class preInit { preInit = 1; };
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