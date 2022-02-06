class CfgTasks {
    tag = QUOTE(DOUBLES(PREFIX,COMPONENT));

    class PatrolPvP {
        title = CSTRING(DisplayName);
        description = CSTRING(Mission_Description);
        icon = "defend";
        initialState = "CREATED";
    };

    class Laptop {
        owners[] = { "EAST" };
        object = "laptop";
        icon = "download";

        conditionEventsShow[] = { QGVAR(showOpforTasks) };

        conditionEventsSuccess[] = { "LaptopSuccessful" };
    };

    class SUV : Laptop {
        object = "suv";
        icon = "car";

        conditionEventsSuccess[] = { "SUVSuccessful" };
    };

    class Jets : Laptop {
        owners[] = { "EAST" };
        icon = "plane";

        conditionEventsSuccess[] = { "JetsSuccessful" };
    };
};