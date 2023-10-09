class CfgTasks
{
    tag = "AFP_Tasks";

    // Put your tasks here
    class GreenPanther
    {
        title = CSTING(Mission_Title);
        description = CSTRING(Mission_Description);
        icon = "whiteboard";
    };
    
    class ArmyDepot
    {
        parentTask = "GreenPanther";
        icon = "attack";
        marker = "sys_marker_army_depot";

        conitionEventsSuccess[] = { "ArmyDepotSecured" };
    };

    class AirportIntel
    {
        parentTask = "GreenPanther";
        icon = "documents";
        marker = "sys_marker_airport";

        conditionEventsSuccess[] = { "AirportIntelFound" };
        conditionEventsFailed[] = { "AirportIntelDestroyed" };
    };

    class CaptureOfficer
    {
        parentTask = "GreenPanther";
        icon = "target";
        conditionEventsSuccess[] = { "OfficerCaptured" };
    };

    class CommsCenter
    {
        parentTask = "GreenPanther";
        icon = "attack";
        marker = "sys_marker_commsCenter";
        
        // TODO: Handle destruction
        conditionEventsSuccess[] = { "CommsCenterCaptured", "CommsCenterDestroyed" };
    };

    /*
        Cargo
    */
    class SecureCargo
    {
        parentTask = "GreenPanther";
        icon = "container";

        conditionEventsSuccess[] = { "AmmoRetrieved", "ContainerRetrieved" };
        conditionEventsSuccessRequired = 2;
    };

    class TownTrucks
    {
        parentTask = "SecureCargo";
        icon = "truck";
        marker = "sys_marker_town_trucks";

        conditionEventsSuccess[] = { "AmmoRetrieved" };
    };

    class IslandTrucks1 : TownTrucks
    {
        marker = "transport_island_empty";
        conditionEventsSuccess[] = { "ContainerRetrieved" };
    };

    class IslandTrucks2 : TownTrucks
    {
        marker = "sys_marker_island_trucks_2";

        conditionEventsCanceled[] = { "AirportIntelFound" };
        conditionEventsSuccess[] = {};
    };
};
