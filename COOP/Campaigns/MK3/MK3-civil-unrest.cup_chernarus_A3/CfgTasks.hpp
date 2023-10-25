class CfgTasks
{
    class TBD_MISSION_TITLE
    {
        title = CSTRING(Mission_Title);
        description = CSTRING(Mission_Briefing);
        icon = "refuel";

        conditionEventsSuccess[] = { "MissionWon" };
        conditionEventsFailed[] = { "MissionFailed" };
    };

    /* Generals tasks for everyone */

    class Survive
    {
        title = "Przeżyj";
        description = "No nie chcesz ginąć. Jeżeli nie masz wyjścia, poddaj się.";
        icon = "heal";

        createdShowNotification = "true";
        conditionCodeShow = "CBA_missionTime > 600";
        conditionEventsShow[] = { "MissionStarted" };

        // Condition for failure local for each player.
        conditionEventsSuccess[] = { "MissionWon", "MissionFailed" };
    };

    /* Resistance Tasks */

    class Resistance
    {
        title = "Partyzanci";
        description = "W końcu nienawiść do okupanta przerodziła się w prawdziwe działania. Pamiętajcie, nie chcecie nikogo zabić! Jeżeli nie będzie wyjścia, poddaj się.";
        icon = "meet";
        parentTask = "TBD_MISSION_TITLE";

        owners[] = { "zeus", "resistanceGroup" };
    };

    /* Militia Tasks */

    class Militia
    {
        title = "Milicja";
        description = "Po niesamowitej wpadce wczoraj, gdzie Milicja otworzyła ogień do protestujących, postanowiono wzmocnić Zelenogorsk w sprzęt do tłumienia zamieszek. Jednakże Milicja nie jest od terroryzowania lokalnej ludności. Nie łamiecie prawa. Nie męczycie ludności cywilnej. Przede wszystkim zapewniacie bezpieczeństwo i pilnujecie porządku. Jeżeli coś wydaje się podejrzane, zgłaszacie, obserwujecie i dopiero w razie potrzeby, interweniujecie. W miarę możliwości, staracie się aresztować, chyba że Wasze życie jest zagrożone. Możecie przekraczać prędkość tylko jadąc na sygnale. Jeżeli jest więcej niż 1 pojazd w kolumnie, sygnał dźwiękowy syreny można wyłączyć, żeby zachować zmysły.";
        icon = "meet";
        parentTask = "TBD_MISSION_TITLE";

        owners[] = { "zeus", "patrol1Group", "patrol2Group", "patrol3Group", "patrol4Group", "stationGroup", "convoyGroup" };
    };

    class Patrol : Militia
    {
        title = "Patrol";
        description = "Jednostki Milicji wyruszają na rutynowy patrol po okolicy w poszukiwaniu pijanych kierowców oraz w celu zwiększenia bezpieczeństwa podczas porannych godzin ze słabą widocznością.";
        icon = "search";
        parentTask = "Militia";

        owners[] = { "zeus", "patrol1Group", "patrol2Group", "patrol3Group", "patrol4Group", "stationGroup", "kgm" };
    };

    /* Emergency Services */

    class EmergencyNumber
    {
        title = "Numer Alarmowy";
        description = "Zainstalowano numer alarmowy 112. Zgłoszenia będą się pokazywać na czacie oraz na mapie, jeżeli masz przy sobie telefon komórkowy. Markery na mapie znikną w ciągu kilku minut od zgłoszenia (żeby nie wisiały do końca gry). Jeżeli zostanie zgłoszona przemoc, zachowajcie ostrożność i wyślijcie więcej jednostek.";
        icon = "run";
        parentTask = "TBD_MISSION_TITLE";

        owners[] = { "zeus", "ambulance", "patrol1Group", "patrol2Group", "patrol3Group", "patrol4Group", "stationGroup" };
    };

    /*
        Civilian Tasks
    */
    class Civilian
    {
        title = "Cywile";
        description = "Jesteście cywilami. Nie lubicie Czedaków oraz kolaborantów. A aktualnie to ugułem nie lubicie też Milicji. Poza zadaniami wymienionymi niżej własna inicjatywa mile widziana.";
        icon = "meet";
        parentTask = "TBD_MISSION_TITLE";

        owners[] = { "zeus", "CIVILIAN" };
    };

    class Protest
    {
        title = "Protest";
        icon = "meet";
        parentTask = "Civilian";
        marker = "sys_marker_protest";

        owners[] = { "zeus", "CIVILIAN" };
        conditionEventsSuccess[] = { "ProtestStarted" };
        conditionEventsFailed[] = { "ProtestFailed" };
    };

    class Kebab
    {
        title = "Kebab";
        description = "Tu znajduje się jakaś buda z kebabem, znajomy Ci ją polecił. Powinna się otworzyć koło 6:30. Może i to jakiś ciemny, brudny zaułek, ale chyba o to w tym chodzi.";
        icon = "meet";
        parentTask = "Civilian";
        marker = "marker_zelenogorsk_gyros";

        owners[] = { "zeus", "CIVILIAN" };
        conditionEventsCanceled[] = { "ProtestStarts" };
    };

    class Supermarket
    {
        title = "Supermarket";
        description = "Najlepiej wyposażony sklep w tej części Czarnorusi. Byłbym zdziwiony, gdyby tam czegoś nie było.";
        icon = "meet";
        parentTask = "Civilian";
        marker = "marker_zelenogorsk_market";

        owners[] = { "zeus", "CIVILIAN" };
        conditionEventsCanceled[] = { "ProtestStarts" };
    };

    class Kiosk
    {
        title = "Kiosk";
        description = "Jeżeli preferujesz naturalne sposoby podnoszenia ciśnienia z rana, tu dowiesz się jak bardzo władza Cię dyma.";
        icon = "meet";
        parentTask = "Civilian";
        marker = "marker_zelenogorsk_news";

        owners[] = { "zeus", "CIVILIAN" };
        conditionEventsCanceled[] = { "ProtestStarts" };
    };

    /*
        Other Tasks
    */
    class MonkeZiuk
    {
        title = "Ziuk Garlinski";
        description = "Pamiętasz typa, bo jako jedyny kretyn z okradających bazę podał swoje prawdziwe dane. Będziesz chciał się z nim rozmówić i dołączyć do walki z tą niewdzięczną czedacką hołotą."
        icon = "meet";
        parentTask = "Civilian";

        owners[] = { "zeus", "monke" };
        conditionCodeSuccess = "monke distance ziuk < 5";
    };
};
