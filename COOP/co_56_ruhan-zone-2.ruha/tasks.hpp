class CfgTasks {
    class RuhanZone2 {
        title = LSTRING(Mission_Title);
        description = LSTRING(Mission_Briefing);
        icon = "target";

        conditionEventsSuccess[] = { "OfficerCaptured" };
    };

    // Mission start

    // Task for Bravo platoon
    class Survive {
        title = LSTRING(Task_Survive_Title);
        description = LSTRING(Task_Survive_Description);
        // createdShowNotification = "true";
        owners[] = { "zeus", "bravoHq", "bravo1", "bravo2" };
        marker = "sys_marker_second_line";
        parentTask = "RuhanZone2";
        icon = "wait";

        // conditionEventsShow[] = { "LZMonkeLost" };
        conditionEventsFailed[] = { "BravoDead" };
        conditionEventsSuccess[] = { "ReachedConstructionSite" };
    };

    // Task for Alpha platoon
    class ReachTheConstructionSite : Survive {
        title = LSTRING(Task_ReachTheConstructionSite_Title);
        description = LSTRING(Task_ReachTheConstructionSite_Description);
        owners[] = { "zeus", "alphaHq", "alpha1", "alpha2", "alpha3", "alpha4" };
        icon = "run";

        conditionEventsCanceled[] = { "Evac" };
    };

    // Friendly Tracker Jammed
    class FriendlyTrackerJammed {
        title = LSTRING(Task_FriendlyTrackerJammed_Title);
        description = LSTRING(Task_FriendlyTrackerJammed_Description);
        parentTask = "RuhanZone2";
        icon = "radio";

        conditionEventsCanceled[] = { "EnableFriendlyTracker" };
    };

    // Counterattack in Ruha
    class Counterattack {
        title = LSTRING(Task_Counterattack_Title);
        description = LSTRING(Task_Counterattack_Description);
        createdShowNotification = "true";
        parentTask = "RuhanZone2";
        marker = "sys_marker_ruha_bridge";
        icon = "attack";

        conditionEventsShow[] = { "ReachedConstructionSite", "CounterattackStarted" };
        conditionEventsFailed[] = { "Evac" };
        conditionEventsSuccess[] = { "EstablishedBridgeheadInNorthernRuha" };
    };

    // Capture Officer
    class CaptureOfficer {
        title = LSTRING(Task_CaptureOfficer_Title);
        description = LSTRING(Task_CaptureOfficer_Description);
        createdShowNotification = "true";
        parentTask = "RuhanZone2";
        icon = "kill";

        conditionEventsShow[] = { "EstablishedBridgeheadInNorthernRuha" };
        conditionEventsFailed[] = { "Evac", "OfficerDead" };
        conditionEventsSuccess[] = { "OfficerCaptured" };
    };

    // Evac
    class Evac {
        title = LSTRING(Task_Evac_Title);
        description = LSTRING(Task_Evac_Description);
        createdShowNotification = "true";
        parentTask = "RuhanZone2";
        icon = "run";
        marker = "sys_marker_base";
        
        conditionEventsShow[] = {"Evac"};
        conditionEventsSuccess[] = {"EvacCompleted"};
    };
};
