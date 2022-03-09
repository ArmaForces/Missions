class CfgTasks {
    tag = QUOTE(DOUBLES(PREFIX,COMPONENT));

    class OperationTartan {
        title = CSTRING(Mission_Title);
        description = CSTRING(Mission_Briefing);
        icon = "unknown";
    };

    /* RECON */
    class Recon {
        parentTask = "OperationTartan";
        icon = "scout";
        initialState = "SUCCEEDED";

        conditionEventsCancelled[] = { "PlayersDetected" };
        conditionEventsFailed[] = { "PlayersDead" };
        conditionEventsSuccess[] = { "EvacCompleted" };
    }

    /* LANDING */
    class Landing {
        parentTask = "OperationTartan";
        icon = "land";
        marker = "sys_marker_landing";

        conditionEventsCancelled[] = { "Evac" };
        conditionEventsFailed[] = { "PlayersDead" };
        conditionEventsSuccess[] = { "PlayersLanded" };
    };

    /* SOUTHEND AREA */
    class SecureSouthendArea : Landing {
        icon = "attack";

        conditionEventsSuccess[] = { "SouthendSecured" };
        conditionEventsSuccessRequired = 1;
        onSuccessEvents[] = { "SouthendAreaSecured" };
    };
    
    class Southend : SecureSouthendArea {
        parentTask = "SecureSouthendArea";
        marker = "sys_marker_southend";

        conditionEventsSuccess[] = { "SouthendSecured" };
    };
    class CampBrunericanBay : Southend {
        title = CSTRING(Task_Camp_Title);
        description = CSTRING(Task_Camp_Description);
        marker = "marker_camp_brunerican_bay";

        conditionEventsSuccess[] = { "CampBrunericanBayDestroyed" };
    };

    /* VILLA AREA */
    class SecureVillaArea : Landing {
        icon = "attack";

        conditionEventsSuccess[] = { "VillaSecured" };
        conditionEventsSuccessRequired = 1;
        onSuccessEvents[] = { "VillaAreaSecured" };
    };

    class Villa : SecureVillaArea {
        parentTask = "SecureVillaArea";
        marker = "marker_villa";

        conditionEventsSuccess[] = { "VillaSecured" };
    };


    /* ADDITIONAL TASKS */
    class RadioTowers : Landing {
        icon = "radio";

        conditionEventsSuccess[] = { "WestRadioTowerSecured", "EastRadioTowerSecured" };
        conditionEventsSuccessRequired = 2;
    };

    class WestRadioTower : RadioTowers {
        title = CSTRING(Task_RadioTower_Title);
        description = CSTRING(Task_RadioTower_Description);
        parentTask = "RadioTowers";
        marker = "marker_radio_tower_west";
        conditionEventsSuccess[] = { "WestRadioTowerSecured" };
    };
    class EastRadioTower : WestRadioTower {
        marker = "marker_radio_tower_east";
        conditionEventsSuccess[] = { "EastRadioTowerSecured" };
    };

    class SAMs : Landing {
        icon = "destroy";

        conditionEventsSuccess[] = { "SAMsDestroyed" };
    };

    class WestSAMSite : SAMs {
        title = CSTRING(Task_SAM_Title);
        description = CSTRING(Task_SAM_Description);
        parentTask = "SAMs";

        marker = "marker_sam_west";
        conditionEventsSuccess[] = { "WestSAMSiteDestroyed" };
    };
    class EastSAMSite : WestSAMSite {
        title = CSTRING(Task_SAM_Title);
        description = CSTRING(Task_SAM_Description);

        marker = "marker_sam_east";
        conditionEventsSuccess[] = { "EastSAMSiteDestroyed" };
    };

    class EastRadarCapture : WestSAMSite {
        title = CSTRING(Task_RadarCapture_Title);
        description = CSTRING(Task_RadarCapture_Description);
        icon = "interact";
        marker = "marker_radar_base";

        conditionEventsCancelled[] = { "EastRadarDestroyed" };
        conditionEventsSuccess[] = { "EastRadarCaptured" };
    };

    class EastRadarDestroy : EastRadarCapture {
        title = CSTRING(Task_RadarDestroy_Title);
        description = CSTRING(Task_RadarDestroy_Description);
        icon = "destroy";

        conditionEventsCancelled[] = { "EastRadarCaptured" };
        conditionEventsSuccess[] = { "EastRadarDestroyed" };
    };

    // Evac
    class Evac {
        parentTask = "OperationTartan";
        icon = "run";
        marker = "sys_marker_base";
        
        conditionEventsShow[] = {"Evac"};
        conditionEventsSuccess[] = {"EvacCompleted"};
    };
};
