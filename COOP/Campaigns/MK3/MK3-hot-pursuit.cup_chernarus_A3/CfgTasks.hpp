class CfgTasks
{
    class HotPursuit
    {
        title = CSTRING(Mission_Title);
        description = CSTRING(Mission_Briefing);
        icon = "car";

        conditionEventsSuccess[] = { "MissionWon" };
        conditionEventsFailed[] = { "MissionFailed" };
    };

    class Survive
    {
        title = "Przeżyj";
        description = "No nie chcesz ginąć. Jeżeli nie masz wyjścia, poddaj się.";
        icon = "heal";

        createdShowNotification = "true";
        conditionCodeShow = "CBA_missionTime > 300";
        conditionEventsShow[] = { "MissionStarted" };

        // Condition for failure local for each player.
        conditionEventsSuccess[] = { "MissionWon", "MissionFailed" };
    };

    class Resistance
    {
        title = "Partyzanci";
        description = "W końcu nienawiść do okupanta przerodziła się w prawdziwe działania. Pamiętajcie, nie chcecie nikogo zabić! Jeżeli nie będzie wyjścia, poddaj się.";
        icon = "meet";
        parentTask = "HotPursuit";

        owners[] = { "zeus", "resistanceGroup" };
    };

    class ResistanceHeist : Resistance
    {
        title = "Włam na posterunek";
        description = "Waszym jest przede wszystkim walizka z hajsem. Oprócz tego wiecie też o skrzyniach z bronią. Dobrze byłoby ukraść jedną lub dwie, ale więcej nie chcecie ryzykować, bo Wam nie starczy czasu. Więźniów możecie uwolnić, możecie zignorować. Na posterunku powinno być 2 policjantów. Musicie ich zmusić do poddania się, np. krzykiem, flashbangami. Na całą akcję macie półtorej minuty (6:15:00 -> 6:16:30). Potem dojedzie ciężko uzbrojona Milicja.";
        icon = "search";
        parentTask = "Resistance";

        conditionEventsSuccess[] = { "DoorsBreached" };
    };

    class ResistanceEscape : Resistance
    {
        title = "Czas uciekać!";
        description = "Wydupiać szybko! Zgubcie pościg a następnie kierujcie się do kryjówki partyzantów [002 065].";
        icon = "run";
        parentTask = "Resistance";

        createdShowNotification = "true";
        conditionEventsShow[] = { "ResistanceTimeToRun" };
        conditionEventsSuccess[] = { "ResistanceEscaped" };
    };

    class Bandits
    {
        title = "Bandyci";
        description = "Zostaliście aresztowani po pościgu dzień wcześniej. Wieźliście kasę i broń. Wszystko to znajduje się aktualnie razem z Wami na komisariacie. Podobno niedługo ma przyjechać transport zabrać Was i to co mieliście ze sobą do Czernogórska. Nie znacie nikogo, kto mógłby Wam pomóc, działaliście tylko we 3. Nie jesteście chętni do współpracy z nikim, ale cenicie sobie życie i wolność.";
        icon = "meet";
        parentTask = "HotPursuit";

        owners[] = { "zeus", "banditsGroup" };
    };

    class BanditsHope : Bandits
    {
        title = "Oczekuj na cud";
        description = "Wygląda na to, że macie przesrane.";
        icon = "wait";
        parentTask = "Bandits";
    };

    class BanditsEscape : Bandits
    {
        title = "Uciekaj";
        description = "Wiej ile sił w nogach!";
        icon = "run";
        parentTask = "Bandits";
    };

    class Militia
    {
        title = "Milicja";
        description = "Milicja jako tako zachowała jeszcze resztki godności po przewrocie. Wielką wpadką wizerunkową było brutalne stłumienie protestów antyrządowych, ale od tamtej pory Milicja stara się odzyskać zaufanie społeczeństwa. Nie łamiecie prawa. Nie męczycie ludności cywilnej. Przede wszystkim zapewniacie bezpieczeństwo i pilnujecie porządku. Jeżeli coś wydaje się podejrzane, zgłaszacie, obserwujecie i dopiero w razie potrzeby, interweniujecie. Możecie przekraczać prędkość tylko jadąc na sygnale. Jeżeli jest więcej niż 1 pojazd w kolumnie, sygnał dźwiękowy syreny można wyłączyć, żeby zachować zmysły.";
        icon = "meet";
        parentTask = "HotPursuit";

        owners[] = { "zeus", "patrol1Group", "patrol2Group", "patrol3Group", "patrol4Group", "stationGroup", "convoyGroup" };
    };

    class Convoy : Militia
    {
        title = "Konwój";
        description = "Na mapie, kolorem brązowym, została zaznaczona trasa konwoju. Jest to najszybsza trasa biorąc pod uwagę mułowatość Waszych starych już lodówek, którym wieki zajmuje rozpędzenie się. Jedźcie ostrożnie, bo zbytnie szarżowanie może skończyć się awariami. Konwój wyruszy w trasę o 6:05. Nie rozdzielajcie się! W Komarowie powinniście być koło 6:10. W Pawłowie powinniście być około 6:15. Około 6:20 dotrzecie na posterunek. Przeniesiecie aresztowanych do pojazdów, załadujecie skradzione rzeczy i ruszycie w drogę powrotną tą samą trasą."; //TODO: Change hours
        icon = "car";
        parentTask = "Militia";

        owners[] = { "zeus", "convoyGroup" };

        conditionEventsCanceled[] = { "MilitiaStationAlarm" };
    }

    class Patrol : Militia
    {
        title = "Patrol";
        description = "Jednostki Milicji wyruszają na rutynowy patrol po okolicy w poszukiwaniu pijanych kierowców oraz w celu zwiększenia bezpieczeństwa podczas porannych godzin ze słabą widocznością. Wyruszycie o 6:05. O 6:18 zakończycie swoje patrole i rozpoczniecie powrót na posterunek.";
        icon = "search";
        parentTask = "Militia";

        owners[] = { "zeus", "patrol1Group", "patrol2Group", "patrol3Group", "patrol4Group", "stationGroup" };

        conditionCodeSuccess = "daytime > 6.3";
        conditionEventsCanceled[] = { "MilitiaStationAlarm" };
    }

    class Patrol1 : Patrol
    {
        title = "Patrol 1";
        description = "Jako Patrol 1 pojedziecie do Viboru.";
        parentTask = "Patrol";

        owners[] = { "zeus", "patrol1Group" };
    };

    class Patrol2 : Patrol
    {
        title = "Patrol 2";
        description = "Jako Patrol 2 pojedziecie do Kabanina.";
        parentTask = "Patrol";

        owners[] = { "zeus", "patrol2Group" };
    };

    class Patrol3 : Patrol
    {
        title = "Patrol 3";
        description = "Jako Patrol 3 pojedziecie do .";
        parentTask = "Patrol";

        owners[] = { "zeus", "patrol3Group" };
    };

    class Patrol4 : Patrol
    {
        title = "Patrol 4";
        description = "Jako Patrol 4 pojedziecie do .";
        parentTask = "Patrol";

        owners[] = { "zeus", "patrol4Group" };
    };

    class PatrolStation : Patrol
    {
        title = "Patrol 5";
        description = "Jako Patrol 5 zostaniecie na posterunku, wypadło na Was, że zajmiecie się papierkową robotą a przy okazji przypilnujecie bandytów.";
        parentTask = "Patrol";

        owners[] = { "zeus", "stationGroup" };
    };

    class StationSituation : Militia
    {
        title = "Alarm na komisariacie";
        description = "Wygląda na to, że ktoś nieupoważniony jest na komisariacie. Wszystkie jednostki na syrenach na komisariat jak najszybciej!";

        createdShowNotification = "true";
        conditionEventsShow[] = { "MilitiaStationAlarm" };
    };
};
