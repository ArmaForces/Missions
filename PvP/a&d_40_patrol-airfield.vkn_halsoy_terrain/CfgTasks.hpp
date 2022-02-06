class CfgTasks {
    class PatrolPvP {
        title = CSTRING(DisplayName); // Regular task title
        description = CSTRING(Mission_Description); // Regular description. Cannot use linebreaks (enters), if needed use stringtable.
        /* Task icon location on the map
        First checks for marker with given name, and if doesn't exists, checks for object in mission namespace.
        Alternatively {x, y, z} can be used for supplying position coordinates.
        If all of them are empty then task won't be shown on the map. */
        icon = "defend"; // Icon classname from https://community.bistudio.com/wiki/Arma_3_Tasks_Overhaul#Appendix
        initialState = "CREATED"; // Default value

        //conditionEventsCanceled[] = { "RTBOrdered", "RTBSuccessful" };
        //conditionEventsCanceledRequired = 2;

        //conditionEventsSuccess[] = { "RTBSuccessful" };
    };

    class Laptop {
        title = CSTRING(Task_Laptop_Title);
        description = CSTRING(Task_Laptop_Description);
        owners[] = { "EAST" };
        object = "laptop";
        parentTask = "PatrolPvP";
        icon = "download";

        conditionEventsShow[] = { QGVAR(showOpforTasks) };
        //conditionEventsShowRequired = 1;

        conditionEventsSuccess[] = { "LaptopSuccessful" };
    };

    class SUV {
        title = CSTRING(Task_SUV_Title);
        description = CSTRING(Task_SUV_Description);
        owners[] = { "EAST" };
        object = "suv";
        parentTask = "PatrolPvP";
        icon = "car";

        conditionEventsShow[] = { QGVAR(showOpforTasks) };
        //conditionEventsShowRequired = 1;

        conditionEventsSuccess[] = { "SUVSuccessful" };
    };

    class Jets {
        title = CSTRING(Task_Jets_Title);
        description = CSTRING(Task_Jets_Description);
        owners[] = { "EAST" };
        parentTask = "PatrolPvP";
        icon = "plane";

        conditionEventsShow[] = { QGVAR(showOpforTasks) };
        //conditionEventsShowRequired = 1;

        conditionEventsSuccess[] = { "JetsSuccessful" };
    };
};