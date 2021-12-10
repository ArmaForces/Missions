class CfgTasks {
    tag = QUOTE(DOUBLES(PREFIX,COMPONENT));

    class SlipperyNight {
        title = LSTRING(Mission_Title);
        description = LSTRING(Mission_Briefing);
        icon = "truck";

        conditionEventsSuccess[] = { "CargoDelivered" };
    };

    // Mission start

    class FindBioweapon {
        parentTask = "SlipperyNight";
        icon = "search";

        priority = 10;
    };

    class EnterTheVillage {
        parentTask = "FindBioweapon";
        icon = "getin";
        marker = "sys_marker_start";

        conditionEventsSuccess[] = { "PlayersEnteredWest", "PlayersEnteredEast", "PlayersNearTheMarket" };
        conditionEventsSuccessRequired = 2;
    };

    class EnterTheVillageWest : EnterTheVillage {
        parentTask = "EnterTheVillage";
        marker = "sys_marker_west_entrance";

        conditionEventsSuccess[] = { "PlayersEnteredWest" };
        conditionEventsCanceled[] = { "PlayersNearTheMarket" };
    };

    class EnterTheVillageEast : EnterTheVillageWest {
        marker = "sys_marker_east_entrance";

        conditionEventsSuccess[] = { "PlayersEnteredEast" };
    };

    class SilentlyApproachMarket {
        parentTask = "FindBioweapon";
        icon = "move";

        conditionEventsCanceled[] = { "PlayersDetected" };
        conditionEventsSuccess[] = { "PlayersNearTheMarket" };
    };

    class SecureBioweapon {
        parentTask = "FindBioweapon";
        icon = "defend";
        object = "bioweapon";

        createdShowNotification = "true";
        conditionEventsShow[] = { "PlayersNearTheMarket", "PlayersDetected" };
        conditionEventsSuccess[] = { "BioweaponSecured" };
    };

    // Convoy

    class DeliverBioweaponToBase {
        parentTask = "SlipperyNight";
        icon = "truck";
        marker = "sys_marker_mandolBase";

        conditionEventsShow[] = { "BioweaponSecured" };
        conditionEventsSuccess[] = { "CargoDelivered" };
    };

    // Evac
    class Evac {
        createdShowNotification = "true";
        parentTask = "RuhanZone2";
        icon = "run";
        marker = "sys_marker_base";
        
        conditionEventsShow[] = {"Evac"};
        conditionEventsSuccess[] = {"EvacCompleted"};
    };
};
