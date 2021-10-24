class CfgTasks {
    class OperationShipPlane {
        title = CSTRING(Mission_Title);
        description = CSTRING(Mission_Briefing);
        icon = "boat";
    };

    // Navy
    class Navy {
        title = CSTRING(Task_Navy_Title);
        description = CSTRING(Task_Navy_Description);
        parentTask = "OperationShipPlane";
        icon = "boat";
        
        conditionEventsSuccess[] = { "AircraftCarrierTaken", "FrigatesDestroyed" };
        conditionEventsSuccessRequired = 2;
    };

    class AircraftCarrier {
        title = CSTRING(Task_AircraftCarrier_Title);
        description = CSTRING(Task_AircraftCarrier_Description);
        parentTask = "Navy";
        icon = "attack";

        conditionEventsSuccess[] = { "AircraftCarrierTaken" };
    };

    class Frigates {
        title = CSTRING(Task_Frigates_Title);
        description = CSTRING(Task_Frigates_Description);
        parentTask = "Navy";
        icon = "destroy";

        conditionEventsSuccess[] = { "Frigate1Destroyed", "Frigate2Destroyed", "Frigate3Destroyed" };
        conditionEventsSuccessRequired = 3;

        onSuccessEvents[] = { "FrigatesDestroyed" };
    };

    class Frigate1 {
        title = CSTRING(Task_Frigate_Title);
        description = CSTRING(Task_Frigate_Description);
        parentTask = "Frigates";
        icon = "destroy";

        conditionCodeSuccess = "!alive frigate_korean_1";
        onSuccessEvents[] = { "Frigate1Destroyed" };
    };

    class Frigate2 : Frigate1 {
        conditionCodeSuccess = "!alive frigate_korean_2";
        onSuccessEvents[] = { "Frigate2Destroyed" };
    };

    class Frigate3 : Frigate1 {
        conditionCodeSuccess = "!alive frigate_korean_3";
        onSuccessEvents[] = { "Frigate3Destroyed" };
    };


    // Airfield
    class Airfield {
        title = CSTRING(Task_Airfield_Title);
        description = CSTRING(Task_Airfield_Description);
        parentTask = "OperationShipPlane";
        icon = "plane";
        marker = "sys_marker_airfield";

        conditionEventsSuccess[] = { "AirfieldSecured" };
    };

    class AirfieldComms {
        title = CSTRING(Task_Comms_Title);
        description = CSTRING(Task_Comms_Description);
        parentTask = "Airfield";
        icon = "destroy";
        marker = "sys_marker_airfield_comms"

        conditionCodeSuccess = "!alive airfield_comms";
        onSuccessEvents[] = { "AirfieldCommsDestroyed" };
    };

    class AirfieldAntiShipBattery {
        title = CSTRING(Task_AntiShipBattery_Title);
        description = CSTRING(Task_AntiShipBattery_Description);
        parentTask = "Airfield";
        icon = "destroy";
        object = "airfield_antiship";

        conditionCodeSuccess = "!alive airfield_antiship";
        onSuccessEvents[] = { "AntiShipOnAirfieldEliminated" };
    };

    // Island
    class Island {
        title = CSTRING(Task_Island_Title);
        description = CSTRING(Task_Island_Description);
        parentTask = "OperationShipPlane";
        icon = "danger";
        marker = "sys_marker_aa_post";

        conditionEventsSuccessRequired = 2;
        conditionEventsSuccess[] = { "AntiAirOnIslandEliminated", "AntiShipOnIslandEliminated" };
    };

    class IslandComms : AirfieldComms {
        parentTask = "Island";
        marker = "island_comms_marker";

        conditionCodeSuccess = "!alive island_comms";
        onSuccessEvents[] = { "IslandCommsDestroyed" };
    };

    class IslandAntiAirWeapons {
        title = CSTRING(Task_IslandAntiAirWeapons_Title);
        description = CSTRING(Task_IslandAntiAirWeapons_Description);
        parentTask = "Island";
        icon = "destroy";

        conditionEventsSuccess[] = { "AntiAirOnIslandEliminated" };
    };

    class IslandAntiShipBattery : AirfieldAntiShipBattery {
        parentTask = "Island";
        object = "island_antiship";

        conditionCodeSuccess = "!alive island_antiship";
        onSuccessEvents[] = { "AntiShipOnIslandEliminated" };
    };

    // Temporary HQ
    class AirfieldHQ {
        title = CSTRING(Task_AirfieldHQ_Title);
        description = CSTRING(Task_AirfieldHQ_Description);
        parentTask = "OperationShipPlane";
        icon = "whiteboard";

        conditionEventsShow[] = { "AirfieldSecured" };
        onShowEvents[] = { "AirfieldHQShown" };

        conditionEventsSuccessRequired = 3;
        conditionEventsSuccess[] = { "FieldHospitalBuilt", "ServiceDepotBuilt", "InfantryArmoryBuilt" };
    };
    class AirfieldFieldHospital {
        title = CSTRING(Task_AirfieldFieldHospital_Title);
        description = CSTRING(Task_AirfieldFieldHospital_Description);
        parentTask = "AirfieldHQ";
        icon = "heal";
        marker = "sys_marker_field_hospital";

        conditionEventsShow[] = { "AirfieldHQShown" };
        conditionEventsSuccess[] = { "FieldHospitalBuilt" };
    };
    class AirfieldServiceDepot {
        title = CSTRING(Task_AirfieldServiceDepot_Title);
        description = CSTRING(Task_AirfieldServiceDepot_Description);
        parentTask = "AirfieldHQ";
        icon = "rearm";
        marker = "sys_marker_service_depot";

        conditionEventsShow[] = { "AirfieldHQShown" };
        conditionEventsSuccess[] = { "ServiceDepotBuilt" };
    };
    class AirfieldInfantryArmory {
        title = CSTRING(Task_AirfieldInfrantryArmory_Title);
        description = CSTRING(Task_AirfieldInfrantryArmory_Description);
        parentTask = "ArifieldHQ";
        icon = "rearm";
        marker = "sys_marker_infantry_armory";

        conditionEventsShow[] = { "AirfieldHQShown" };
        conditionEventsSuccess[] = { "InfantryArmoryBuilt" };
    };

    // Main island
    class FindImportantTargets {
        title = CSTRING(Task_FindImportantTargets_Title);
        description = CSTRING(Task_FindImportantTargets_Description);
        parentTask = "OperationShipPlane";
        icon = "search";

        conditionEventsSuccessRequired = 3;
        conditionEventsSuccess[] = { "Thing1Found", "Thing2Found", "Thing3Found" };

        onSuccessEvents[] = { "Evac" };
    };

    class Artifacts {
        title = CSTRING(Task_Artifacts_Title);
        description = CSTRING(Task_Artifacts_Description);
        parentTask = "FindImportantTargets";
        marker = "sys_marker_delivery_zone";

        conditionEventsShow[] = { "ArtifactsIntelFound" };
        conditionEventsSuccess[] = { "CingDzban", "CingMiska", "CingFajkaWodna" };
        conditionEventsSuccessRequired = 3;
    };

    class CingDzban {
        title = CSTRING(Task_CingDzban_Title);
        description = CSTRING(Task_Cing_Description);
        parentTask = "FindImportantTargets";
        object = "cing_dzban";
        
        conditionEventsShow[] = { "CingDzbanekFound" };
        conditionCodeSuccess = "cing_dzban inArea delivery_zone";
        onSuccessEvents[] = { "CingDzban" };
    };
    class CingMiska : CingDzban {
        title = CSTRING(Task_CingMiska_Title);
        object = "cing_miska";
        
        conditionEventsShow[] = { "CingMiskaFound" };
        conditionCodeSuccess = "cing_miska inArea delivery_zone";
        onSuccessEvents[] = { "CingMiska" };
    };
    class CingFajkaWodna : CingDzban {
        title = CSTRING(Task_CingFajkaWodna_Title);
        object = "cing_fajka_wodna";

        conditionEventsShow[] = { "CingFajkaWodnaFound" };
        conditionCodeSuccess = "cing_fajka_wodna inArea delivery_zone";
        onSuccessEvents[] = { "CingFajkaWodna" };
    };

    // Evac
    class Evac {
        title = CSTRING(Task_Evac_Title);
        description = CSTRING(Task_Evac_Description);
        parentTask = "OperationShipPlane";
        icon = "run";
        marker = "sys_marker_base";
        
        conditionEventsShow[] = {"Evac"};
        conditionEventsSuccess[] = {"EvacCompleted"};
    };
};
