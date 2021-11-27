class CfgTasks {
    class RuhanZone2 {
        title = CSTRING(Mission_Title);
        description = CSTRING(Mission_Briefing);
        icon = "target";

        conditionEventsSuccess[] = { "BangingComplete" };
    };

    // Mission start

    // Task for Bravo platoon
    class Survive {
        title = CSTRING(Task_Survive_Title);
        description = CSTRING(Task_Survive_Description);
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
        title = CSTRING(Task_ReachTheConstructionSite_Title);
        description = CSTRING(Task_ReachTheConstructionSite_Description);
        owners[] = { "zeus", "alphaHq", "alpha1", "alpha2", "alpha3", "alpha4" };
        icon = "run";

        conditionEventsCanceled[] = { "Evac" };

        onSuccessEvents[] = { "EnableFriendlyTracker" };
        onFailedEvents[] = { "EnableFriendlyTracker" };
    };

    // Friendly Tracker Jammed
    class FriendlyTrackerJammed {
        title = CSTRING(Task_FriendlyTrackerJammed_Title);
        description = CSTRING(Task_FriendlyTrackerJammed_Description);
        parentTask = "RuhanZone2";
        icon = "radio";

        conditionEventsCanceled[] = { "EnableFriendlyTracker" };
    };

    // Counterattack in Ruha
    class Counterattack {
        title = CSTRING(Task_Counterattack_Title);
        description = CSTRING(Task_Counterattack_Description);
        createdShowNotification = "true";
        parentTask = "RuhanZone2";
        icon = "attack";

        conditionEventsShow[] = { "CounterattackStarted" };
        conditionEventsFailed[] = { "Evac" };
        conditionEventsSuccess[] = { "EstablishedBridgeheadInNorthernRuha" };
    };

    // Capture Officer
    class CaptureOfficer {
        title = CSTRING(Task_CaptureOfficer_Title);
        description = CSTRING(Task_CaptureOfficer_Description);
        createdShowNotification = "true";
        parentTask = "RuhanZone2";
        icon = "kill";

        conditionEventsShow[] = { "EstablishedBridgeheadInNorthernRuha" };
        conditionEventsFailed[] = { "Evac", "OfficerDead" };
        conditionEventsSuccess[] = { "OfficerCaptured" };
    };

    // Evac
    class Evac {
        title = CSTRING(Task_Evac_Title);
        description = CSTRING(Task_Evac_Description);
        createdShowNotification = "true";
        parentTask = "RuhanZone2";
        icon = "run";
        marker = "sys_marker_base";
        
        conditionEventsShow[] = {"Evac"};
        conditionEventsSuccess[] = {"EvacCompleted"};
    };
};
