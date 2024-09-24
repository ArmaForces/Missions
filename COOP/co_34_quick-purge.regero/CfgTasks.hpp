class CfgTasks
{
    tag = "AFP_Tasks";

    // Put your tasks here
    class DropZone
    {
        marker = "marker_drop_zone";
        icon = "land";
    };

    class Airfield
    {
        marker = "marker_morabin_airfield";
        icon = "plane";
    };

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
};
