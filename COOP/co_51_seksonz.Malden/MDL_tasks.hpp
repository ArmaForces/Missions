class CfgTasks {
    class SEKSONZ {
        title = CSTRING(DisplayName); // Regular task title
        description = CSTRING(Mission_Description); // Regular description. Cannot use linebreaks (enters), if needed use stringtable.
        /* Task icon location on the map
        First checks for marker with given name, and if doesn't exists, checks for object in mission namespace.
        Alternatively {x, y, z} can be used for supplying position coordinates.
        If all of them are empty then task won't be shown on the map. */
        icon = "defend"; // Icon classname from https://community.bistudio.com/wiki/Arma_3_Tasks_Overhaul#Appendix
        initialState = "CREATED"; // Default value

        conditionEventsCanceled[] = { "RTBOrdered", "RTBSuccessful" };
        conditionEventsCanceledRequired = 2;

        conditionEventsSuccess[] = { "RTBSuccessful" };
    };
    class RescueCivilians {
        title = CSTRING(Task_RescueCivilians_Title); // Regular task title
        description = CSTRING(Task_RescueCivilians_Description); // Regular description. Cannot use linebreaks (enters), if needed use stringtable.
        /* Task icon location on the map
        First checks for marker with given name, and if doesn't exists, checks for object in mission namespace.
        Alternatively {x, y, z} can be used for supplying position coordinates.
        If all of them are empty then task won't be shown on the map. */
        parentTask = "SEKSONZ";
        icon = "meet"; // Icon classname from https://community.bistudio.com/wiki/Arma_3_Tasks_Overhaul#Appendix
        initialState = "CREATED"; // Default value

        conditionEventsCanceled[] = { "RTBOrdered" };
        conditionEventsSuccess[] = { "RTBTime" };
    };

    class GravesInvestigation {
        title = CSTRING(Task_GravesInvestigation_Title);
        description = CSTRING(Task_GravesInvestigation_Description);
        parentTask = "SEKSONZ";
        icon = "search";

        conditionEventsCanceled[] = { "RTBOrdered" };
        conditionEventsShow[] = { "GravesFound" };
    };

    class ArrestOfficer {
        title = CSTRING(Task_ArrestOfficer_Title);
        description = CSTRING(Task_ArrestOfficer_Description);
        parentTask = "SEKSONZ";
        icon = "kill";

        conditionEventsShow[] = { "OfficerStart" };
        conditionEventsFailed[] = { "OfficerDied" };
        conditionEventsCanceled[] = { "RTBOrdered" };
        conditionCodeSuccess = "cro_general inArea ""vip_target_area""";
    };

    class RTB {
        title = CSTRING(Task_RTB_Title);
        description = CSTRING(Task_RTB_Description);
        parentTask = "SEKSONZ";
        icon = "exit";

        conditionEventsShow[] = { "RTBOrdered", "RTBTime" };
        conditionEventsShowRequired = 1;

        conditionEventsSuccess[] = { "RTBSuccessful" };
    };
};