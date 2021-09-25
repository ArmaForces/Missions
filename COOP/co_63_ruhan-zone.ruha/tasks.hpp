class CfgTasks {
    class RuhanZone {
        title = CSTRING(Mission_Title);
        description = CSTRING(Mission_Briefing);
        icon = "target";

        conditionEventsSuccess[] = { "BangingComplete" };
    };

    // Landing
    class Land {
        title = CSTRING(Task_Land_Title);
        description = CSTRING(Task_Land_Description);
        marker = "lz_monke";
        parentTask = "RuhanZone";
        icon = "land";

        conditionEventsSuccess[] = { "LZMonke" };
    };

    // Attack
    class Karacostam {
        title = CSTRING(Task_Karacostam_Title);
        description = CSTRING(Task_Karacostam_Description);
        marker = "sys_marker_karacostam";
        parentTask = "RuhanZone";
        icon = "attack";

        conditionEventsSuccess[] = { "KaracostamSecured" };
    };

    class Ruhanpera : Karacostam{
        title = CSTRING(Task_Ruhanpera_Title);
        description = CSTRING(Task_Ruhanpera_Description);
        marker = "sys_marker_ruhanpera";
        parentTask = "Karacostam";

        conditionEventsSuccess[] = { "RuhanperaSecured" };
    };

    class Hietala : Ruhanpera {
        title = CSTRING(Task_Hietala_Title);
        description = CSTRING(Task_Hietala_Description);
        marker = "sys_marker_hietala";

        conditionEventsSuccess[] = { "HietalaSecured" };
    };


    // Defend
    class HoldKaracostam {
        title = CSTRING(Task_HoldKaracostam_Title);
        description = CSTRING(Task_HoldKaracostam_Description);
        createdShowNotification = "true";
        marker = "sys_marker_karacostam"
        parentTask = "RuhanZone";
        icon = "defend";

        conditionEventsShow[] = { "KaracostamSecured" };
        onShowEvents[] = { "StartKaracostamDefense" };
        conditionEventsCanceled[] = { "CounterattackSuccessfull" };
    };

    // Convoy
    class Convoy {
        title = CSTRING(Task_Convoy_Title);
        description = CSTRING(Task_Convoy_Description);
        createdShowNotification = "true";
        marker = "sys_marker_stadium";
        parentTask = "HoldKaracostam";
        icon = "wait";

        conditionEventsShow[] = { "StartKaracostamDefense" };
        conditionEventsCanceled[] = { "CounterattackSuccessfull" };
    };

    // Prepare defenses
    class PrepareDefenses {
        title = CSTRING(Task_PrepareDefenses_Title);
        description = CSTRING(Task_PrepareDefenses_Description);
        createdShowNotification = "true";
        parentTask = "HoldKaracostam";
        icon = "use";

        conditionEventsShow[] = { "StartKaracostamDefense" };
        onShowEvents[] = { "StartPreparingDefenses" };

        conditionEventsSuccessRequired = 4;
        conditionEventsSuccess[] = { "NorthwestOfStadiumBuilt", "NortheastOfStadiumBuilt", "SoutheastOfStadiumBuilt", "SouthOfKaracostamBuilt" };
    };

    class NorthwestOfStadium {
        title = CSTRING(Task_PrepareDefenses_Title);
        description = CSTRING(Task_PrepareDefenses_Bunkers_Description);
        marker = "sys_marker_northwestOfStadium";
        parentTask = "PrepareDefenses";
        icon = "use";

        conditionEventsShow[] = { "StartPreparingDefenses" };
        conditionEventsSuccess[] = { "NorthwestOfStadiumBuilt" };
    };

    class NortheastOfStadium : NorthwestOfStadium {
        marker = "sys_marker_northeastOfStadium";
        conditionEventsSuccess[] = { "NortheastOfStadiumBuilt" };
    };

    class SoutheastOfStadium : NorthwestOfStadium {
        marker = "sys_marker_southeastOfStadium";
        conditionEventsSuccess[] = { "SoutheastOfStadiumBuilt" };
    };

    class SouthOfKaracostam : NorthwestOfStadium {
        marker = "sys_marker_southOfKaracostam";
        conditionEventsSuccess[] = { "SouthOfKaracostamBuilt" };
    };

    // Retreat
    class Counterattack {
        title = CSTRING(Task_Counterattack_Title);
        description = CSTRING(Task_Counterattack_Description);
        createdShowNotification = "true";
        parentTask = "RuhanZone";
        icon = "danger";

        conditionEventsShow[] = { "CounterattackStarted" };
        conditionEventsSuccess[] = { "BangingComplete" };
    };

    class RetreatToKaracostam {
        title = CSTRING(Task_RetreatToKaracostam_Title);
        description = CSTRING(Task_RetreatToKaracostam_Description);
        createdShowNotification = "true";
        marker = "sys_marker_northeastOfStadium";
        parentTask = "Counterattack";
        icon = "run";

        conditionEventsShow[] = { "CounterattackStarted" };
        conditionEventsSuccess[] = {"CounterattackSuccessfull"};
    };

    class AbandonStadium : RetreatToKaracostam {
        title = CSTRING(Task_AbandonStadium_Title);
        description = CSTRING(Task_AbandonStadium_Description);
        createdShowNotification = "true";
        marker = "sys_marker_first_line";

        conditionEventsShow[] = { "CounterattackSuccessfull" };
        conditionEventsSuccess[] = { "CounterattackKaracostam" };
    };

    class RetreatToHietala : RetreatToKaracostam {
        title = CSTRING(Task_RetreatToHietala_Title);
        description = CSTRING(Task_RetreatToHietala_Description);
        createdShowNotification = "true";
        marker = "sys_marker_second_line";

        conditionEventsShow[] = { "CounterattackKaracostam" };
        conditionEventsSuccess[] = { "CounterattackHietala" };
    };

    // Ending
    class WaitForReinforcements {
        title = CSTRING(Task_WaitForReinforcements_Title);
        description = CSTRING(Task_WaitForReinforcements_Description);
        createdShowNotification = "true";
        marker = "sys_marker_second_line";
        parentTask = "RuhanZone";
        icon = "wait";

        conditionEventsShow[] = { "CounterattackHietala" };
        conditionEventsCanceled[] = { "LZMonkeLost" };
    };

    class Survive {
        title = CSTRING(Task_Survive_Title);
        description = CSTRING(Task_Survive_Description);
        createdShowNotification = "true";
        marker = "sys_marker_second_line";
        parentTask = "RuhanZone";
        icon = "wait";

        conditionEventsShow[] = { "LZMonkeLost" };
        conditionEventsSuccess[] = { "BangingComplete" };
    };

    // Evac
    class Evac {
        title = CSTRING(Task_Evac_Title);
        description = CSTRING(Task_Evac_Description);
        createdShowNotification = "true";
        parentTask = "RuhanZone";
        icon = "run";
        marker = "sys_marker_base";
        
        conditionEventsShow[] = {"Evac"};
        conditionEventsSuccess[] = {"EvacCompleted"};
    };
};
