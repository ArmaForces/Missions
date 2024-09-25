class CfgTasks
{
    tag = "AFP_Tasks";

    // Main task
    class CaptureVeryImportantDude
    {
        icon = "search";

        conditionEventsSuccess[] = { "DudeArrested" };
        conditionEventsFailed[] = { "DudeDeadge" };
    };

    class DropZone
    {
        marker = "marker_drop_zone";
        icon = "land";

        conditionEventsSuccess[] = { "PlayersInDropZone" };
    };

    class Airfield
    {
        marker = "marker_morabin_airfield";
        icon = "plane";

        conditionEventsSuccessRequired = 2;
        conditionEventsSuccess[] = { "AirfieldClear", "FOBBuilt" };
    };

    // "Secondary" tasks
    class BurnWeed
    {
        marker = "marker_weed_zone";
        icon = "mine";

        conditionEventsSuccessRequired = 8;
        conditionEventsSuccess[] = {
            "WeedFieldBurns_1",
            "WeedFieldBurns_2",
            "WeedFieldBurns_3",
            "WeedFieldBurns_4",
            "WeedFieldBurns_5",
            "WeedFieldBurns_6",
            "WeedFieldBurns_7",
            "WeedFieldBurns_8"
        };
    };

    class StealRadarData
    {
        marker = "marker_radar_base";
        icon = "download";

        conditionEventsSuccess[] = { "afmf_task_download_successful" };
        conditionEventsFailed[] = { "afmf_task_download_failed" };
    };

    class InterrogatePriest
    {
        marker = "sys_marker_church";
        icon = "meet";

        conditionEventsCanceled[] = { "PriestIsGone" };
    };

    class TankFactory
    {
        marker = "marker_tank_factory";
        icon = "kill";

        conditionEventsSuccess[] = { "ManagerBeaten" };
        conditionEventsFailed[] = { "ManagerKilled" };
    };

    class Taks5
    {

    };
};
