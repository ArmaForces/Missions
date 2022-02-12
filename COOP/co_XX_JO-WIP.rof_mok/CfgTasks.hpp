class CfgTasks {
    class JO_Unnamed {
        title = CSTRING(Mission_Title);
        description = CSTRING(Mission_Briefing);
        icon = "unknown";
    };

    // Evac
    class Evac {
        title = CSTRING(Task_Evac_Title);
        description = CSTRING(Task_Evac_Description);
        parentTask = "JO_Unnamed";
        icon = "run";
        marker = "sys_marker_base";
        
        conditionEventsShow[] = {"Evac"};
        conditionEventsSuccess[] = {"EvacCompleted"};
    };
};
