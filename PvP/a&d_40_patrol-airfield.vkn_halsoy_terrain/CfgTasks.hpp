class CfgTasks {
    tag = QUOTE(DOUBLES(PREFIX,COMPONENT));

    class PatrolPvP {
        title = CSTRING(DisplayName);
        description = CSTRING(Mission_ShortDescription);
        icon = "defend";
        initialState = "CREATED";
    };

    class Laptop {
        owners[] = { "EAST" };
        parentTask = "PatrolPvP";

        object = "laptop";
        icon = "download";

        conditionEventsShow[] = { QGVAR(showOpforTasks) };

        conditionEventsSuccess[] = { "LaptopSuccessful" };
    };

    class SUV : Laptop {
        object = "suv";
        icon = "car";

        conditionEventsShow[] += { QGVAR(suvSpawned) };
        conditionEventsShowRequired = 2;

        conditionEventsSuccess[] = { "SUVSuccessful" };
    };

    class Jets : Laptop {
        owners[] = { "EAST" };
        object = "";
        marker = "sys_marker_radar_station_bravo";
        icon = "plane";

        conditionEventsSuccess[] = { "JetsSuccessful" };
    };
};