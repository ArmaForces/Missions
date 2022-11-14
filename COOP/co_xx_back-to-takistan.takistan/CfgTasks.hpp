class CfgTasks {
    tag = QUOTE(DOUBLES(PREFIX,COMPONENT));

    class BackToTakistan {
        title = CSTRING(Mission_Title);
        description = CSTRING(Mission_Briefing);
        icon = "land";
    };

    // Evac
    class Evac {
        parentTask = "BackToTakistan";
        icon = "run";
        marker = "sys_marker_base";
        
        conditionEventsShow[] = {"Evac"};
        conditionEventsSuccess[] = {"EvacCompleted"};
    };
};
