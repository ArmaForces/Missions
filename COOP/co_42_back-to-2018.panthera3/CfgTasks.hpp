class CfgTasks
{
    tag = "AFP_Tasks";

    // Put your tasks here
    class GreenPanther
    {
        title = CSTRING(Mission_Title);
        description = CSTRING(Mission_Description);
        icon = "whiteboard";

        conditionEventsSuccess[] = { "CargoRetrieved" };
        conditionEventsFailed[] = { "NukeDetonated" };
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

        onSuccessEvents[] = { "CargoRetrieved" };
    };

    class TownTrucks
    {
        parentTask = "SecureCargo";
        icon = "truck";
        marker = "sys_marker_town_trucks";

        conditionEventsFailed[] = { "TownCargoDestroyed" };
        conditionEventsSuccess[] = { "AmmoRetrieved" };
        onSuccessEvents[] = { "afm_respawn_force" };
    };

    class IslandTrucks1 : TownTrucks
    {
        title = ECSTRING(Tasks,Task_SecureCargo_Title);
        description = ECSTRING(Tasks,Task_SecureCargo_Description);
        marker = "transport_island_empty";

        conditionEventsFailed[] = { "ContainerDestroyed" };
        conditionEventsSuccess[] = { "ContainerRetrieved" };
        onSuccessEvents[] = { "afm_respawn_force" };
    };

    class IslandTrucks2 : TownTrucks
    {
        title = ECSTRING(Tasks,Task_SecureCargo_Title);
        description = ECSTRING(Tasks,Task_SecureCargo_Description);
        marker = "sys_marker_island_trucks_2";

        conditionEventsCanceled[] = { "AirportIntelFound" };
        conditionEventsSuccess[] = {};
    };

    /*
        OPTIONAL TASKS
    */

    class OptionalTasks
    {
        parentTask = "GreenPanther";
        icon = "unknown";
        conditionEventsSuccess[] = { "ArmyDepotSecured", "AirportIntelFound", "OfficerCaptured", "CommsJammed", "IslandShutdownPower" };
        conditionEventsSuccessRequired = 5;
    };

    class ArmyDepot
    {
        parentTask = "OptionalTasks";
        icon = "attack";
        marker = "sys_marker_army_depot";

        conditionEventsSuccess[] = { "ArmyDepotSecured" };
        onSuccessEvents[] = { "afm_respawn_force" };
    };

    class AirportIntel
    {
        parentTask = "OptionalTasks";
        icon = "documents";
        marker = "sys_marker_airport";

        conditionEventsSuccess[] = { "AirportIntelFound" };
        conditionEventsFailed[] = { "AirportIntelDestroyed" };
        onSuccessEvents[] = { "afm_respawn_force" };
    };

    class CaptureOfficer
    {
        parentTask = "OptionalTasks";
        icon = "target";
        marker = "sys_marker_research_center";

        conditionEventsSuccess[] = { "OfficerCaptured" };
        onSuccessEvents[] = { "afm_respawn_force" };
    };

    /*
        Comms Jamming
    */
    class JammComms
    {
        parentTask = "OptionalTasks";
        icon = "interact";

        conditionEventsSuccess[] = { "CommsCenterCaptured", "NorthTowerJammerInstalled", "SouthTowerJammerInstalled" };
        conditionEventsSuccessRequired = 3;

        onSuccessEvents[] = { "CommsJammed" };
    };

    class CommsCenter
    {
        parentTask = "JammComms";
        icon = "attack";
        marker = "sys_marker_commsCenter";
        
        // TODO: Handle destruction
        conditionEventsSuccess[] = { "CommsCenterCaptured", "CommsCenterDestroyed" };
        onSuccessEvents[] = { "afm_respawn_force" };
    };

    class InstallJammerOnNorthTower
    {
        parentTask = "JammComms";
        icon = "use";
        marker = "sys_marker_comms_north";
        
        conditionEventsFailed[] = { "NorthTowerJammerBroken" };
        conditionEventsSuccess[] = { "NorthTowerJammerInstalled" };
        onSuccessEvents[] = { "afm_respawn_force" };
    };

    class InstallJammerOnSouthTower : InstallJammerOnNorthTower
    {
        title = ECSTRING(Tasks,Task_InstallJammerOnNorthTower_Title);
        description = ECSTRING(Tasks,Task_InstallJammerOnNorthTower_Description);
        marker = "sys_marker_comms_south";

        conditionEventsFailed[] = { "SouthTowerJammerBroken" };
        conditionEventsSuccess[] = { "SouthTowerJammerInstalled" };
        onSuccessEvents[] = { "afm_respawn_force" };
    };

    /*
        Island Power
    */

    class IslandPower
    {
        parentTask = "OptionalTasks";
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
        onSuccessEvents[] = { "afm_respawn_force" };
    };

    class IslandPowerDestroy
    {
        parentTask = "IslandPower";
        icon = "destroy";
        marker = "sys_marker_island_powerplant";

        conditionEventsCanceled[] = { "PowerRelayHacked" };
        conditionEventsSuccess[] = { "PowerplantDestroyed" };
        onSuccessEvents[] = { "afm_respawn_force" };
    };
};
