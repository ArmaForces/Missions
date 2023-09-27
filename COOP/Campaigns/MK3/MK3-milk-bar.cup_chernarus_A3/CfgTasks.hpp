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
    };

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

    /*
        Civilian Tasks
    */
    class Civilian
    {
        title = "Cywile";
        description = "Jesteście cywilami. Nie lubicie Czedaków oraz kolaborantów.";
        icon = "meet";

        owners[] = { "zeus", "CIVILIAN" };
    };

    class GoToVibor
    {
        title = "Zebranie w Wiborze";
        description = "Przypomniało Ci się, że usłyszałeś pocztą pantoflową o jakimś zebraniu dziś rano w Wiborze. Ma się odbyć jakoś przed 7:00.";
        icon = "move";
        parentTask = "Civilian";
        marker = "sys_marker_wibor";

        createdShowNotification = "true";
        conditionEventsShow[] = { "CiviliansToVibor" };
        owners[] = { "zeus", "CIVILIAN" };
    };

    // Task #1
    class StolenLada_Driver
    {
        title = "Kradziona Łada";
        description = "Tydzień temu razem ze wspólnikiem ukradliście w Czernogorsku błękitną ładę, wygląda na to że sytuacja przycichła więc pora przewieźć auto do dziupli. Podczas ostatniej rozmowy twój wspólnik wspominał że udało mu się zaleźć kupca. Twoim zadaniem jest dostać się samochodem do waszej dziupli w Łopatinie, Czekać będzie na ciebie twój wspólnik z którym udacie się do baru mlecznego w Wiborze gdzie ma czekać kupiec. Samochód ma lewe rejestracje i podrobiony dowód rejestracyjny. Dziupla znajduje się w szopie zaraz obok ceglanego domu naprzeciwko Cerkwii";
        icon = "car";
        parentTask = "Civilian";

        owners[] = { "zeus", "lada_driver"};
    };
    // Task #2
    class StolenLada_Co
    {
        title = "Kradziona Łada";
        description = "Tydzień temu razem ze wspólnikiem ukradliście w Czernogorsku błękitną ładę, samochód dotychczas stał w Garażu twojego wspólnika. W międzyczasie tobie udało się znaleźć kupca który za samochód oferuje niezłą kasę. Twoim zadaniem jest udanie się do waszej dziupli w Łopatinie, zaczekasz tam na wspólnika który ma dostarczyć auto, następnie udacie się do baru Mlecznego w Wiborze gdzie spotkacie się z kupcem. Wiesz że będzie mieć na sobie wojskowy plecak. Dziupla znajduje się w szopie zaraz obok ceglanego domu naprzeciwko Cerkwii.<br/><br/>Następnie wspólnie pojedziecie do Wiboru, gdzie umówiłeś się z kupcem w barze mlecznym. Będzie miał on na sobie wojskowy plecak.";
        icon = "car";
        parentTask = "Civilian";

        owners[] = { "zeus", "lada_seller" };
    };
    // Task #3
    class StolenLada_Buyer
    {
        title = "Błękitna Łada";
        description = "Wygląda na to że zrobiłeś niezły interes, Kilka dni temu poznałeś Faceta który po okazyjnej cenie sprzedaje błękitną Ładę w niezłym stanie a co ważniejsze, w okazyjnej cenie. Masz spotkać się z kupcem w barze Mlecznym w Wiborze, Twoim znakiem rozpoznawczym jest wojskowy plecak w którym trzymasz pieniądze.";
        icon = "car";
        parentTask = "Civilian";

        owners[] = { "zeus", "lada_buyer" };
    };

    // Task #5
    // Nikola Macecek
    class SmuggleCigarettes
    {
        title = "Przemyt fajek";
        description = "Jesteś Czedackim żołnierzem i obecnie przebywasz na przepustce w Sosnowce. Poza służbą dorabiasz sobie przewożąc papierosy przemycane z Takistanu. Fajki schowane są w skrytce za stacją transformatorów w północnej części wsi. Musisz je znaleźć i przewieźć do Wiboru. Kolega z jednostki, któremu masz je przekazać będzie na ciebie czekać pod supermarketem około 6:15. Pamiętaj, że ostatnio jest nagonka na fajki z Takistanu!";
        parentTask = "Civilian";

        owners[] = { "zeus", "civ_smuggler" };
    };

    // Task #6
    // Boris Planicka
    class SmuggleCigarettes_Receiver
    {
        title = "Odbierz dostawę fajek";
        description = "Jesteś drobnym szmuglerem który handluje przemycanymi z Takistanu papierosami, do czego wykorzystujesz swoją obecność w Armii Czedackiej. Dzisiaj musisz odebrać nową dostawę od kolegi z jednostki z Sosnowki, który przemyca fajki z Takistanu w czasie przepustki. Masz spotkać się z nim pod supermarketem w Wiborze około 6:15. Masz dla niego skromną wypłatę za przewóz towaru. Pamiętaj, że ostatnio jest nagonka na fajki z Takistanu!";
        parentTask = "Civilian";

        owners[] = { "zeus", "chkdz_smuggler" };
    };

    // Task #7
    class ChairsDriver
    {
        title = "Przewóz krzeseł";
        description = "Pracujesz jako kierowca ciężarówki, dzisiaj masz odebrać ładunek z kolejowego magazynu przeładunkowego pod Zelenogorskiem i przewieźć go pod pomnik w Wiborze. Dzisiaj będzie jechała z Tobą dodatkowa osoba do pomocy w załadunku, zabierz ją p"
        icon = "box";
        parentTask = "Civilian";

        owners[] = { "zeus", "chairsDriver" };
    };
    // Task #8
    class ChairsAssistant
    {
        title = "Przewóz krzeseł";
        description = "Jesteś Polskim emigrantem, Kiedyś byłeś mechanikiem jednak twoja kariera zakończyła się po podpaleniu śmietnika w swoim zakładzie, teraz chwytasz się różnych dorywczych zajęć. Dzisiaj masz pomóc w dostarczeniu ładunku krzeseł."
        icon = "box";
        parentTask = "Civilian";

        owners[] = { "zeus", "chairsAssistant" };
    };

    class BusDriver
    {
        title = "Kierowca autobusu";
        description = "Jesteś kierowcą Czarnoruskich Kolei Autobusowych (CKS). Dziś obsługujesz linię Lopatino - Zelenogorsk. Zeus powinien dostarczyć Ci rozkład jazdy.";
        icon = "move";
        parentTask = "Civilian";

        owners[] = { "zeus", "busDriver1", "busDriver2" };
    };

    /*
        Other Tasks
    */
    class MonkeZiuk
    {
        title = "Ziuk Garlinski";
        description = "Pamiętasz typa, bo jako jedyny kretyn z okradających bazę podał swoje prawdziwe dane. Będziesz chciał się z nim rozmówić i dołączyć do walki z tą niewdzięczną czedacką hołotą."
        icon = "meet";

        owners[] = { "zeus", "monke" };
        conditionCodeSuccess = "monke distance ziuk < 5";
        onSuccessEvents[] = { "MonkePissed" };
    };

    class MonkeGoPissing
    {
        title = "Idź do swojego kibla na końcu bazy";
        icon = "run";

        owners[] = { "zeus", "monke" };
        createdShowNotification = "true";
        conditionEventsShow[] = { "MonkeGoPiss" };
        conditionEventsSuccess[] = { "MonkePissed" };
    };
};
