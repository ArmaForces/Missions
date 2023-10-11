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

        conditionEventsSuccess[] = { "ArmyDepotSecured" };
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
        marker = "sys_marker_research_center";

        conditionEventsSuccess[] = { "OfficerCaptured" };
    };

    /*
        Comms Jamming
    */
    class JammComms
    {
        parentTask = "GreenPanther";
        icon = "interact";

        conditionEventsSuccess[] = { "CommsCenterCaptured", "NorthTowerJammerInstalled", "SouthTowerJammerInstalled" };
        conditionEventsSuccessRequired = 3;
    };

    class CommsCenter
    {
        parentTask = "JammComms";
        icon = "attack";
        marker = "sys_marker_commsCenter";
        
        // TODO: Handle destruction
        conditionEventsSuccess[] = { "CommsCenterCaptured", "CommsCenterDestroyed" };
    };

    class InstallJammerOnNorthTower
    {
        parentTask = "JammComms";
        icon = "use";
        
        conditionEventsFailed[] = { "NorthTowerJammerBroken" };
        conditionEventsSuccess[] = { "NorthTowerJammerInstalled" };
    };

    class InstallJammerOnSouthTower : InstallJammerOnNorthTower
    {
        conditionEventsFailed[] = { "SouthTowerJammerBroken" };
        conditionEventsSuccess[] = { "SouthTowerJammerInstalled" };
    };

    /*
        Island Power
    */

    class IslandPower
    {
        parentTask = "GreenPanther";
        icon = "interact";

        conditionEventsFailed[] = { "PowerRelayComputerDestroyed", "" };
        conditionEventsFailedRequired = 2;

        conditionEventsSuccess[] = { "PowerRelayHacked", "PowerplantDestroyed" };

        onSuccessEvents[] = { "IslandShutdownPower" };
    };

    class IslandPowerHack
    {
        parentTask = "IslandPower";
        icon = "use";
        marker = "sys_marker_island_powerRelay";

        conditionEventsCanceled[] = { "PowerplantDestroyed" };
        conditionEventsFailed[] = { "PowerRelayComputerDestroyed" };
        conditionEventsSuccess[] = { "PowerRelayHacked" };
    };

    class IslandPowerDestroy
    {
        parentTask = "IslandPower";
        icon = "destroy";
        marker = "sys_marker_island_powerplant";

        conditionEventsCanceled[] = { "PowerRelayHacked" };
        conditionEventsSuccess[] = { "PowerplantDestroyed" };
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
