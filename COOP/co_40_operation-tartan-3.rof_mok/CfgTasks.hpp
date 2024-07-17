class CfgTasks {
    tag = QUOTE(DOUBLES(PREFIX,COMPONENT));

    class OperationTartan {
        title = LSTRING(Mission_Title);
        description = LSTRING(Mission_Briefing);
        icon = "unknown";
    };

    class RadarMachariochBay {
        parentTask = "OperationTartan";
        icon = "interact";
        marker = "marker_radar_macharioch_bay";
        title = LSTRING(Task_HackRadar_Title);
        description = LSTRING(Task_HackRadar_Description);

        conditionEventsCancelled[] = { "Evac" };
        conditionEventsFailed[] = { "RadarMachariochBayDestroyed" };
        conditionEventsSuccess[] = { "RadarMachariochBayHacked" };
    };
    class RadarTorrMor : RadarMachariochBay {
        marker = "marker_radar_torr_mor";
        conditionEventsFailed[] = { "RadarTorrMorDestroyed" };
        conditionEventsSuccess[] = { "RadarTorrMorHacked" };
    };
    class RadarGlenKerran : RadarMachariochBay {
        marker = "marker_radar_glen_kerran";
        conditionEventsFailed[] = { "RadarGlenKerranDestroyed" };
        conditionEventsSuccess[] = { "RadarGlenKerranHacked" };
    };

    // Evac
    class Evac {
        parentTask = "OperationTartan";
        icon = "run";
        marker = "sys_marker_base";
        
        conditionEventsShow[] = {"Evac"};
        conditionEventsSuccess[] = {"EvacCompleted"};
    };

    // /* TASKS FROM 2nd PART */

    // /* SOUTHEND DEFENSE */
    // class DefendSouthend {
    //     parentTask = "OperationTartan";
    //     icon = "defend";
    //     marker = "sys_marker_southend";

    //     conditionEventsCancelled[] = { "Evac" };
    //     conditionEventsFailed[] = { "PlayersDead" };
    // };

    // class OptionalBuildFortifications : DefendSouthend {
    //     parentTask = "DefendSouthend";
    //     icon = "use";
    //     marker = "";

    //     conditionEventsSuccess[] = { "WestBunkersBuilt", "HillBunkersBuilt" };
    //     conditionEventsSuccessRequired = 2;
        
    //     onSuccessEvents[] = { "SouthendFortificationsBuilt" };
    // };

    // class OptionalBuildWestFortifications : OptionalBuildFortifications {
    //     parentTask = "OptionalBuildFortifications";
    //     marker = "";
    //     object = "west_fortifications";
        
    //     conditionEventsSuccess[] = { "WestBunkersBuilt" };
    // };

    // class OptionalBuildHillFortifications : OptionalBuildWestFortifications {
    //     object = "hill_fortifications";

    //     conditionEventsSuccess[] = { "HillBunkersBuilt" };
    // }

    // class OptionalDeliverWeaponsWest : OptionalBuildWestFortifications {
    //     icon = "rearm";
    //     conditionEventsSuccess[] = { "WeaponsDeliveredWest" };
    // };

    // class OptionalDeliverWeaponsHill : OptionalBuildHillFortifications {
    //     icon = "rearm";
    //     conditionEventsSuccess[] = { "WeaponsDeliveredHill" };
    // };

    // /* VILLA AREA */
    // class SecureVillaArea : DefendSouthend {
    //     icon = "attack";
    //     marker = "";

    //     conditionEventsSuccess[] = { "VillaSecured", "RestOfVillaAreaSecured" };
    //     conditionEventsSuccessRequired = 2;
    //     onSuccessEvents[] = { "VillaAreaSecured" };
    // };

    // class Villa : SecureVillaArea {
    //     parentTask = "SecureVillaArea";
    //     marker = "marker_villa";

    //     conditionEventsSuccess[] = { "VillaSecured" };
    //     conditionEventsSuccessRequired = 1;
    // };


    // /* ADDITIONAL TASKS */
    // class RadioTowers : DefendSouthend {
    //     icon = "radio";
    //     marker = "";
    //     initialState = "CREATED";

    //     conditionEventsSuccess[] = { "WestRadioTowerSecured", "EastRadioTowerSecured" };
    //     conditionEventsSuccessRequired = 2;
    //     onSuccessEvents[] = {};
    // };

    // class WestRadioTower : RadioTowers {
    //     title = CSTRING(Task_RadioTower_Title);
    //     description = CSTRING(Task_RadioTower_Description);
    //     parentTask = "RadioTowers";
    //     marker = "marker_radio_tower_west";
    //     conditionEventsSuccess[] = { "WestRadioTowerSecured" };
    // };
    // class EastRadioTower : WestRadioTower {
    //     marker = "marker_radio_tower_east";
    //     conditionEventsSuccess[] = { "EastRadioTowerSecured" };
    // };

    // class SAMs : DefendSouthend {
    //     icon = "destroy";
    //     marker = "";

    //     conditionEventsSuccess[] = { "SAMsDestroyed" };
    //     conditionEventsSuccessRequired = 1;
    //     onSuccessEvents[] = {};
    // };

    // class WestSAMSite : SAMs {
    //     title = CSTRING(Task_SAM_Title);
    //     description = CSTRING(Task_SAM_Description);
    //     parentTask = "SAMs";
    //     initialState = "SUCCEEDED";

    //     marker = "marker_sam_west";
    //     conditionEventsSuccess[] = { "WestSAMSiteDestroyed" };
    // };
    // class EastSAMSite : WestSAMSite {
    //     title = CSTRING(Task_SAM_Title);
    //     description = CSTRING(Task_SAM_Description);

    //     marker = "marker_sam_east";
    //     conditionEventsSuccess[] = { "EastSAMSiteDestroyed" };
    // };

    // class EastRadarCapture : WestSAMSite {
    //     title = CSTRING(Task_RadarCapture_Title);
    //     description = CSTRING(Task_RadarCapture_Description);
    //     icon = "interact";
    //     marker = "marker_radar_base";
    //     initialState = "CREATED";

    //     conditionEventsCancelled[] = { "EastRadarDestroyed" };
    //     conditionEventsSuccess[] = { "EastRadarCaptured" };
    // };

    // class EastRadarDestroy : EastRadarCapture {
    //     title = CSTRING(Task_RadarDestroy_Title);
    //     description = CSTRING(Task_RadarDestroy_Description);
    //     icon = "destroy";

    //     conditionEventsCancelled[] = { "EastRadarCaptured" };
    //     conditionEventsSuccess[] = { "EastRadarDestroyed" };
    // };




    // /* TASKS FROM 1st PART */

    // /* RECON */
    // class Recon {
    //     parentTask = "OperationTartan";
    //     icon = "scout";
    //     initialState = "SUCCEEDED";

    //     conditionEventsCancelled[] = { "PlayersDetected" };
    //     conditionEventsFailed[] = { "PlayersDead" };
    //     conditionEventsSuccess[] = { "EvacCompleted" };
    // }

    // /* LANDING */
    // class Landing : SecureVillaArea {
    //     icon = "land";
    //     marker = "sys_marker_landing";
    //     initialState = "SUCCEEDED";

    //     conditionEventsSuccess[] = { "PlayersLanded" };
    //     onSuccessEvents[] = {};
    // };

    // /* SOUTHEND AREA */
    // class SecureSouthendArea : Landing {
    //     icon = "attack";
    //     marker = "";
    //     initialState = "SUCCEEDED";

    //     conditionEventsSuccess[] = { "SouthendSecured", "CampBrunericanBayDestroyed", "RestOfSouthendAreaSecured" };
    //     conditionEventsSuccessRequired = 3;
    //     onSuccessEvents[] = { "SouthendAreaSecured" };
    // };
    
    // class Southend : SecureSouthendArea {
    //     parentTask = "SecureSouthendArea";
    //     marker = "sys_marker_southend";

    //     conditionEventsSuccess[] = { "SouthendSecured" };
    // };
    // class CampBrunericanBay : Southend {
    //     title = CSTRING(Task_Camp_Title);
    //     description = CSTRING(Task_Camp_Description);
    //     marker = "marker_camp_brunerican_bay";

    //     conditionEventsSuccess[] = { "CampBrunericanBayDestroyed" };
    // };
};
