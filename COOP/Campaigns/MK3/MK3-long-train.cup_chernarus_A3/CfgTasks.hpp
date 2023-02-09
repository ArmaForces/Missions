class CfgTasks
{
    class LongTrain
    {
        title = CSTRING(Mission_Title);
        description = CSTRING(Mission_Briefing);
        icon = "container";

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

    class Civilians
    {
        title = "Cywile";
        description = "Cywile nie rozrabiają.";
        icon = "meet";
        parentTask = "LongTrain";

        owners[] = { "zues", "busDriver", "busTicketer" };
    };

    class Bus
    {
        title = "ChKS";
        description = "Jako kierowca Czarnoruskich Kolei Samochodowych jesteś aktualnie na przystanku w Lopatino. Odjazd o 18:03. Jedziesz do Pawłowa zatrzymując się na przystankach po drodze, mają oznaczoną godzinę ODJAZDU. Możesz odjechać maksymalnie minutę przed czasem. Niedopuszczalne jest opóźnienie większe niż 3 minuty. Zatrzymuj się tylko na wyznaczonych przystankach! Zwróć uwagę, że w Zelenogorsku jeden z przystanków został przeniesiony kawałek dalej, pod bazę wojskową a stary jest nieczynny, pozostała tylko wiata bez znaku. Po dojechaniu do Pawłowa, możesz wrócić do Zelenogórska i zatrzymać się na pętli przy bazie wojskowej. Ruszysz w kurs powrotny o 18:40 i pojedziesz zachowując takie same odstępy czasowe między kolejnymi przystankami jak podczas pierwszej jazdy.";
        icon = "car";
        parentTask = "Civilians";

        owners[] = { "zeus", "busDriver" };
    };

    class Tickets
    {
        title = "Bileciki do kontroli!";
        description = "Jesteś kanarem ChKS i dzisiaj wypadło, że będziesz kontrolował bileciki na trasie Vybor - Zelenogorsk [Baza Wojskowa] i z powrotem. Autobus powinien przyjechać o 18:05.";
        icon = "map";
        parentTask = "Civilians";

        owners[] = { "zeus", "busTicketer" };
    };

    class Resistance
    {
        title = "Partyzanci";
        description = "";
        icon = "meet";
        parentTask = "LongTrain";

        owners[] = { "zeus", "ext1Group", "ext4Group" };
    };

    class ResistanceStealSupplies : Resistance
    {
        title = "Ukradnij zoapatrzenie";
        description = "";
        icon = "box";
        parentTask = "Resistance";
    };

    class Chedaks
    {
        title = "Czedacy";
        description = "Jesteście elementem Czedackiej Armii. Jest ona niedofinansowana, tak jak Czarnoruska Armia była. Większość jednostek ma problemy ze sprzętem. Nawet ten transport nie jest w stanie tego zategować, ale lepsze to niż nic.";
        icon = "meet";
        parentTask = "LongTrain";

        owners[] = { "zeus", "baseGroup", "baseGuards", "ext1Group", "ext2Group", "ext3Group", "ext4Group" };
    };

    class UnloadTrain : Chedaks
    {
        title = "Rozładuj pociąg";
        description = "Przed Wami sporo pracy. Podobno przyjechało ponad 100 skrzyń ze sprzętem. Na żółto oznaczone zostały składziki, do których musicie przenieść (lub przewieźć) skrzynie. Rozładowane pojazdy zaparkujcie jakoś sensownie.";
        icon = "land";
        parentTask = "Chedaks";
    };

    class BaseCommander
    {
        title = "Dowódca bazy";
        description = "W zaznaczonych żółtych składzikach nie ma nic. Tam można składować skrzynie. Mogą być posortowane (jest 5 rodzajów skrzyń akurat) albo nie, dowolnie. Nadmiar można rozdać, żeby jednostki które przyjechały zabrały coś ze sobą. To w końcu i tak do nich trafi. Nie dawajcie jednak za dużo, chcecie mieć coś dla siebie też.";
        icon = "whiteboard";
        parentTask = "Chedaks";

        owners[] = { "zeus", "baseCommander" };
    };

    class BaseGroup
    {
        title = "Obsada bazy";
        description = "Pomagacie przy rozładunku, koordynujecie rozładunek, rozwiązujecie problemy. Reszta nie będzie wiedzieć gdzie co dać, Wy musicie to wiedzieć i im przekazać.";
        icon = "whiteboard";
        parentTask = "Chedaks";

        owners[] = { "zeus", "baseGroup" };
    };

    class BaseGuards
    {
        title = "Stróżówka";
        description = "Pilnujecie wjazdu do bazy. Nie wpuszczacie cywilów. Jeżeli ktoś będzie chciał wejść bez zezwolenia, aresztujcie. Kilka jednostek wysłało do nas żołnierzy do pomocy przy rozładunku, miejcie to na uwadze.";
        icon = "whiteboard";
        parentTask = "Chedaks";

        owners[] = { "zeus", "baseGuards" };
    };

    class External1
    {
        title = "Drużyna zewnętrzna 1";
        description = "Jesteście z małego oddziału, który nie ma stałej bazy. Aktualnie podczas zimy chowacie się w Diabelskim Zamku odkąd został opuszczony przez poprzednio stacjonujący tam batalion. Bieda u Was taka, że musieliście 'pożyczyć' ciężarówkę z sąsiedniej wioski. Sprzętu również brakuje, bo komu nie brakuje.";
        icon = "whiteboard";
        parentTask = "Chedaks";

        owners[] = { "zeus", "ext1Group" };
    };

    class External2
    {
        title = "Drużyna zewnętrzna 2";
        description = "Jesteście z bazy na Lotnisku, jednej z największych baz w Czarnorusi. Macie 2 ciężarówki, bo planujecie wywieźć dużo sprzętu. Legalnie bądź nie, dowódca kazał Wam ogarnąć przynajmniej 10 skrzyń sprzętu, różnego rodzaju. Im więcej, tym lepiej, idealnie byłoby 20. Starajcie się to zrobić dyskretnie, żeby nikt nie zauważył. Mała szansa, że ktoś się doliczy ile tam jest skrzyń. Chciałby również położyć łapska na jakimś nowym pojeździe, ale nie jest to konieczne.";
        icon = "whiteboard";
        parentTask = "Chedaks";

        owners[] = { "zeus", "ext2Group" };
    };

    class External3
    {
        title = "Drużyna zewnętrzna 3";
        description = "Jesteście z bazy pod Pawłowem. Stacjonuje tam elitarna jednostka zmotoryzowana. Jedziecie UAZem, ale chcecie wrócić z jakimś dodatkowym pojazdem kołowym. W końcu transport jest dla armii to Wam się należy, nie? Dobrze byłoby również ukraść trochę skrzyń ze sprzętem. Starajcie się to zrobić dyskretnie, żeby nikt nie zauważył. Mała szansa, że ktoś się doliczy ile tam jest skrzyń.";
        icon = "whiteboard";
        parentTask = "Chedaks";

        owners[] = { "zeus", "ext3Group" };
    };

    class External4
    {
        title = "Drużyna zewnętrzna 4";
        description = "Jesteście z leśnego posterunku na północ od tamy. Piszczy bieda, więc dowódca wysłał Was autobusem. Dlatego też nie mogliście wziąć broni ze sobą. Miło byłoby, gdybyście mogli wrócić jakimś pojazdem, bo na cały posterunek macie tylko jednego zgruzowanego UAZa, który jest w naprawie od tygodnia i wszędzie chodzicie pieszo.";
        icon = "whiteboard";
        parentTask = "Chedaks";

        owners[] = { "zeus", "ext4Group" };
    };
};
