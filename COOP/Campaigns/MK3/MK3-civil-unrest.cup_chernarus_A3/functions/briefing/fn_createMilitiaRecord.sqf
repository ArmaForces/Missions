#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Creates briefing records of known criminals in Chernarus.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#define DIARY_NAME "criminalRecord"

params [["_unit", player]];

_unit createDiarySubject [DIARY_NAME, "Kartoteka"];

private _createRecordFunc = {
    params ["_name", "_description", ["_residence", "NIEZNANE"], ["_documents", []], ["_criminalRecord", []]];

    private _documentsText = _documents apply {format ["- %1: %2", _x#0, _x#1]} joinString "<br/>";
    if (_documentsText isEqualTo "") then { _documentsText = "BRAK" };
    private _criminalRecordText = _criminalRecord apply {format ["- %1", _x]} joinString "<br/>";
    if (_criminalRecordText isEqualTo "") then { _criminalRecordText = "BRAK" };
    private _text = format ["%1<br/><br/>Miejsce zamieszkania: %2<br/>Dokumenty:<br/>%3<br/><br/>Historia kryminalna:<br/>%4",
        _description, _residence, _documentsText, _criminalRecordText];

    _unit createDiaryRecord [DIARY_NAME, [_name, _text]];
};

["NIEZNANY #220317-1x3",
    "3 dresów w wieku 23-26 lat. Prawdopodobnie część większej grupy przestępczej.<br/>Potencjalnie niebezpieczni dla zdrowia i życia. W przypadku spotkania natychmiast wezwać wsparcie i powstrzymać się od działań bezpośrednich dopóki nie jest zagrożone życie lub zdrowie.",
    nil,
    [
        ["ID", "Wszystkie nieczytelne, wyglądają na podrobione dokumenty Republiki Czarnorusi."],
        ["Prawo jazdy", "Samochód;Motocykl, wystawione przez Czedacką Republikę Ludową"]
    ], [
        "Podejrzani o rozboje w centralnej Czarnorusi na przestrzeni ostatnich tygodni",
        "Ucieczka przed milicją",
        "Nielegalne posiadanie i użycie broni",
        "Ucieczka z aresztu w dniu 18.03.2022"
    ]
] call _createRecordFunc;
["NIEZNANY #220318-2",
    "Mężczyzna około 40 lat. Brak możliwości ustalenia tożsamości.",
    nil,
    [],
    [
        "Napadł na posterunek milicji w Zelenogorsku w dniu 18.03.2022. Został postrzelony i w stanie krytycznym został zabrany do lokalnego szpitala."
    ]
] call _createRecordFunc;
["NIEZNANY #220318-1",
    "Mężczyzna około 50 lat. Brak możliwości ustalenia tożsamości.",
    nil,
    [],
    [
        "Napadł na posterunek milicji w Zelenogorsku w dniu 18.03.2022. Został postrzelony i w stanie krytycznym został zabrany do lokalnego szpitala."
    ]
] call _createRecordFunc;

["Wowrynowicz Piotr",
    "Dezerter z armii Czedackiej",
    "<marker name='sys_marker_wowrynowicz-piotr'>Wybor</marker>",
    [],
    [
        "Dwa tygodnie temu opuścił swoją jednostkę stacjonującą w Diabelskim Zamku. Patrole dotychczas skierowane w miejsce zamieszkania poszukiwanego stwierdziły że nie ma go w domu. Poszukiwany może być uzbrojony. Najprawdopodobniej ubrany w elementy wojskowego wyposażenia. Należy zachować szczególną ostrożność w kontakcie z Poszukiwanym."
    ]
] call _createRecordFunc;

// player createDiaryRecord [DIARY_NAME, ["Jemniołek Stanisław",
//     "Taksówkarz z Czernogórska.
//     <p>
//     <h2>Dokumenty:</h2>
//     <ul>
//     <li>Prawo jazdy; ważne bezterminowo</li>
//     <ul>
//     </p><p>
//     <h2>Historia kryminalna:</h2>
//     Aresztowany za posiadanie nielegalnych dewiz.
// "]];

// player createDiaryRecord [DIARY_NAME, ["Jemniołek Janek ps. „jemniom”",
//     "Syn Stanisława Jemniołka, taksówkarza z czernogorska którego czedacy zamknęli za niewinność i podłożone dewizy.
//     <p>
//     <h2>Dokumenty:</h2>
//     <ul>
//     <li>Prawo jazdy; ważne bezterminowo</li>
//     <ul>
//     </p><p>
//     <h2>Historia kryminalna:</h2>
//     Aresztowany za udział w proteście w Czernogórsku w dniu ------. Po zamknięciu ojca wyszedł na ulice protestować przeciwko władzy. Podczas okrzyku opisującego co zawsze należy się do mordy czedackim kurwom został spałowany.
// "]];

["Iwanowicz Toivo ps. Igel",
    "Były milicjant, urodzony w roku 1980. Aktualnie bezrobotny. Miał dwójkę dzieci, stracił tragicznie podczas wyzwolenia, sprawcy nie odnaleziono. Potencjalnie niebezpieczny dla porządku publicznego.",
    "NIEZNANE, kiedyś <marker name='sys_marker_home_igel'>Berezino</marker>",
    ["TBD_Piesa_UID"] call FUNC(getDocuments),
    [
        "Zdegradowany do stopnia podporucznika i zawieszony z powodu nałogu heroinowego. Spędził 2 lata w ośrodkach odwykowych i na rehabilitacji.",
        "Aktywnie działał przy koordynacji ruchu milicyjnego ruchu oporu w czasie wyzwolenia Czarnorusi przez bratni naród Czedacki. Przeznaczony do stracenia, został uratowany przez ruch oporu. Wyrok stracenia został odwołany, gdyż wyzwolenie zostało zakończone z powodzeniem."
    ]
] call _createRecordFunc;

["Hypev Ivanion",
    "Były student ekonomii na Uniwersytecie Czernogórskim, został z niego wyrzucony po aresztowaniu podczas protestów antyczedackich.",
    "<marker name='sys_marker_home_hypev'>Na zachód od Bogtyrki, przy zachodniej granicy Czarnorusi</marker>",
    "TBD_Hyperion_UID" call FUNC(getDocuments),
    [
        "Aresztowany w trakcie protestów antyczedackich w Czernogorsku 08.06.2021"
    ]
] call _createRecordFunc;

["Garliński Ziuk",
    "Brudny wieśniak.",
    "<marker name='sys_marker_home_ziuk'>Pogorewka, naprzeciwko cerkwii</marker>",
    "TBD_Renchon_UID" call FUNC(getDocuments),
    [
        "Aresztowany za domniemany udział w napadzie na posterunek w dniu 18.03.2022. Zatrzymany do kontroli na wyjeździe z Zelenogorska tuż po napadzie. Przewoził w samochodzie broń, kamizelki i granaty ogłuszające. Stwierdził, że przestępcy pomylili samochody i zabrali jego pojazd a on nie zauważył i odjechał ich pojazdem, bo były takie same. Zeznania funkcjonariuszy potwierdzają, że koło posterunku były 2 czerwone pojazdy w momencie napadu. Znaleziono 2 porzucone czerwone pojazdy w Pulkowie i Pustoszce. Zwolniony z powodu braku dowodów, skonfiskowano granaty."
    ]
] call _createRecordFunc;

["Bracelos Krasnolitus",
    "Emerytowany kapitan armii czarnoruskiej. Zajmuje się strzelectwem.",
    "<marker name='sys_marker_home_bracelos'>Lopatino</marker>",
    "TBD_Mikkeboss_UID" call FUNC(getDocuments)
] call _createRecordFunc;
