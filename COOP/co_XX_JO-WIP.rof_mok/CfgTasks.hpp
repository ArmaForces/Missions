class CfgTasks {
    class OperationTartan {
        title = CSTRING(Mission_Title);
        description = CSTRING(Mission_Briefing);
        icon = "unknown";
    };

    class Recon {
        parentTask = "OperationTartan";
        icon = "scout";
        owner[] = { "reconTeam", "zeus" };
        conditionEventsCancelled[] = { "PlayersDetected" };
        conditionEventsFailed[] = { "PlayersDead" };
        conditionEventsSuccess[] = { "EvacCompleted" };
    }

    // Evac
    class Evac {
        parentTask = "OperationTartan";
        icon = "run";
        marker = "sys_marker_base";
        
        conditionEventsShow[] = {"Evac"};
        conditionEventsSuccess[] = {"EvacCompleted"};
    };
};
