class CfgTasks
{
    class TBD_MISSION_TITLE
    {
        title = CSTRING(Mission_Title);
        description = CSTRING(Mission_Briefing);
        icon = "TBD_MISSION_ICON";

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
        description = "Milicja jako tako zachowała jeszcze resztki godności po przewrocie. Wielką wpadką wizerunkową było brutalne stłumienie protestów antyrządowych, ale od tamtej pory Milicja stara się odzyskać zaufanie społeczeństwa. Nie łamiecie prawa. Nie męczycie ludności cywilnej. Przede wszystkim zapewniacie bezpieczeństwo i pilnujecie porządku. Jeżeli coś wydaje się podejrzane, zgłaszacie, obserwujecie i dopiero w razie potrzeby, interweniujecie. W miarę możliwości, staracie się aresztować, chyba że Wasze życie jest zagrożone. Możecie przekraczać prędkość tylko jadąc na sygnale. Jeżeli jest więcej niż 1 pojazd w kolumnie, sygnał dźwiękowy syreny można wyłączyć, żeby zachować zmysły.";
        icon = "meet";
        parentTask = "TBD_MISSION_TITLE";

        owners[] = { "zeus", "patrol1Group", "patrol2Group", "patrol3Group", "patrol4Group", "stationGroup", "convoyGroup" };
    };

    class Patrol : Militia
    {
        title = "Patrol";
        description = "Jednostki Milicji wyruszają na rutynowy patrol po okolicy w poszukiwaniu pijanych kierowców oraz w celu zwiększenia bezpieczeństwa podczas porannych godzin ze słabą widocznością. Spróbujcie rozłożyć się tak, by w razie wezwania z trójkąta Lopatino-Zelenogorsk-Stary Sobor móc szybko dotrzeć na miejsce.";
        icon = "search";
        parentTask = "Militia";

        owners[] = { "zeus", "patrol1Group", "patrol2Group", "patrol3Group", "patrol4Group", "stationGroup" };

        // conditionCodeSuccess = "daytime > 6.3";
        // conditionEventsCanceled[] = { "MilitiaStationAlarm" };
    };

    // class Patrol1 : Patrol
    // {
    //     title = "Patrol 1";
    //     description = "Jako Patrol 1 pojedziecie do Wiboru. Następnie możecie skręcić w stronę Lopatino i przed miastem skręcić na południe do Miszkina lub pojechać do Kabanina.";
    //     parentTask = "Patrol";

    //     owners[] = { "zeus", "patrol1Group" };
    // };

    // class Patrol2 : Patrol
    // {
    //     title = "Patrol 2";
    //     description = "Jako Patrol 2 pojedziecie do Kabanina przez Pogorewkę i Rogowo. W drodze powrotnej przejedźcie przez Pulkowo.";
    //     parentTask = "Patrol";

    //     owners[] = { "zeus", "patrol2Group" };
    // };

    // class Patrol3 : Patrol
    // {
    //     title = "Patrol 3";
    //     description = "Jako Patrol 3 pojedziecie do Kamenki i Komarewa. Następnie zahaczycie o Bor i Pawłowo z drodze powrotnej, chyba że spotkacie konwój, wtedy możecie wracać na posterunek razem z nimi.";
    //     parentTask = "Patrol";

    //     owners[] = { "zeus", "patrol3Group" };
    // };

    // class Patrol4 : Patrol
    // {
    //     title = "Patrol 4";
    //     description = "Jako Patrol 4 pojedziecie do Kozłowki, następnie sprawdzicie jak sprawy mają się na tamie po zachodniej stronie Zelenogorska. Jeżeli wystarczy Wam czasu, przejedźcie się do Pulkowa.";
    //     parentTask = "Patrol";

    //     owners[] = { "zeus", "patrol4Group" };
    // };

    class PatrolCheckpointPustoshka : Patrol
    {
        title = "Punkt kontrolny Pustoszka";
        description = "Punkt kontrolny wymaga obsadzenia przez jeden z patroli. Grupa Czedacka będzie Wam pomagać.";
        parentTask = "Patrol";
        icon = "documents";
        marker = "marker_checkpoint_pustoshka_south";
    };

    class PatrolCheckpointPogorevka : PatrolCheckpointPustoshka
    {
        title = "Punkt kontrolny Pogorewka";
        description = "Punkt kontrolny wymaga obsadzenia przez jeden z patroli. Grupa Czedacka będzie Wam pomagać.";
        marker = "marker_checkpoint_pogorevka_south";
    };

    // class PatrolStation : Patrol
    // {
    //     title = "Patrol 5";
    //     description = "Jako Patrol 5 zostaniecie na posterunku, wypadło na Was, że zajmiecie się papierkową robotą a przy okazji przypilnujecie bandytów.";
    //     parentTask = "Patrol";

    //     owners[] = { "zeus", "stationGroup" };
    // };

    // class StationSituation : Militia
    // {
    //     title = "Alarm na komisariacie";
    //     description = "Wygląda na to, że ktoś nieupoważniony jest na komisariacie. Wszystkie jednostki na syrenach na komisariat jak najszybciej!";

    //     createdShowNotification = "true";
    //     conditionEventsShow[] = { "MilitiaStationAlarm" };
    // };

    /* Emergency Services */

    class EmergencyNumber
    {
        title = "Numer Alarmowy";
        description = "Zainstalowano numer alarmowy 112. Zgłoszenia będą się pokazywać na czacie oraz na mapie, jeżeli masz przy sobie telefon komórkowy. Markery na mapie znikną w ciągu kilku minut od zgłoszenia (żeby nie wisiały do końca gry). Jeżeli zostanie zgłoszona przemoc, powinniście wezwać na pomoc Czedaków (nie mają dostępu do systemu alarmowego).";
        icon = "run";
        parentTask = "TBD_MISSION_TITLE";

        owners[] = { "zeus", "ambulance", "patrol1Group", "patrol2Group", "patrol3Group", "patrol4Group", "stationGroup" };
    };

    /* Chedaki Tasks */

    class Chedaks
    {
        title = "Czedacy";
        description = "Jesteście elementem Czedackiej Armii. Ze względu na spore problemy z bandytami w ostatnimi czasie, zostaliście przydzieleni do pomocy Milicji. Waszym zadaniem jest wyłapanie bandytów sprawnie umykających Wam od przeszło 2 tygodni.";
        icon = "meet";

        parentTask = "TBD_MISSION_TITLE";
        owners[] = { "zeus", "chdkzGroup1" };
    };

    class ChedaksCheckpoints {
        title = "Punkty kontrolne";
        description = "W pobliżu Pustoszki i Pogorewki zorganizowane zostały punkty kontrolne, które obsadzacie w grupach trzyosobowych, w towarzystwie Milicji. Pilnujecie, żeby wszystko przebiegało zgodnie z procedurami oraz żeby nikt nie próbował omijać punktów kontrolnych (z punktu w Pustoszce widać (słabo) drogę z Pogorewki ze wschodu; z punktu w Pogorewce widać bardzo dobrze objazd przez Pulkowo). W przypadku podejrzeń, możecie wysłać radiowóz w celu sprawdzenia pojazdu.";
        icon = "rifle";

        parentTask = "Chedaks";
        owners[] = { "zeus", "chdkzGroup1" };
    };
    class ChedaksHelpingMilitia {
        title = "Pomoc Milicji";
        description = "Jeżeli będzie taka potrzeba a punkty kontrolne nie będą wymagać dodatkowej pomocy, możecie pomagać zespołom Milicji 'w polu'. Możecie jeździć swoimi pojazdami (jeśli macie) lub razem z Milicją (po 1-2).";
        icon = "search";

        parentTask = "Chedaks";
        owners[] = { "zeus", "chdkzGroup1" };
    };
    class ChedaksReactToViolence {
        title = "Reaguj na przemoc";
        description = "W przypadku zgłoszenia strzelaniny/przemocy natychmiast ruszacie na miejsce wezwania, Milicja nie da rady.";
        icon = "danger";

        parentTask = "Chedaks";
        owners[] = { "zeus", "chdkzGroup1" };
    };

    /* Civilian Tasks */

    /* Other Tasks */

    class Bandits
    {
        title = "Bandyci";
        description = "Zostaliście aresztowani po pościgu dzień wcześniej. Wieźliście kasę i broń. Wszystko to znajduje się aktualnie razem z Wami na komisariacie. Podobno niedługo ma przyjechać transport zabrać Was i to co mieliście ze sobą do Czernogórska. Nie znacie nikogo, kto mógłby Wam pomóc, działaliście tylko we 3. Nie jesteście chętni do współpracy z nikim, ale cenicie sobie życie i wolność. Ogólnie nie chcecie nikogo zabijać, zależy Wam tylko na pieniądzach.";
        icon = "meet";
        parentTask = "TBD_MISSION_TITLE";

        owners[] = { "zeus", "banditsGroup" };
    };

    class BanditsHope : Bandits
    {
        title = "Oczekuj na cud";
        description = "Wygląda na to, że macie przesrane.";
        icon = "wait";
        parentTask = "Bandits";

        conditionEventsSuccess[] = { "BanditsCanEscape" };
    };

    class BanditsEscape : Bandits
    {
        title = "Uciekaj";
        description = "Wiej ile sił w nogach! W razie potrzeby, ukradnij samochód.";
        icon = "run";
        parentTask = "Bandits";

        createdShowNotification = "true";
        conditionCodeShow = "units banditsGroup findIf {!(_x getVariable [""ace_captives_isHandcuffed"", true])} != -1";
        onShowEvents[] = { "BanditsCanEscape" };
    };
};
