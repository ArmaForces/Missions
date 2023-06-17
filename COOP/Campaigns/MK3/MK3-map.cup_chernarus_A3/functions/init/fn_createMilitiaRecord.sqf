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

player createDiarySubject ["militiaRecord", "Kartoteka"];

player createDiaryRecord ["militiaRecord", ["NIEZNANY #220318-1",
    "Brak możliwości ustalenia tożsamości.
    <br/><br/>
    Miejsce zamieszkania: NIEZNANE
    <br/>
    Dokumenty:
    <br/>
    BRAK
    <br/><br/>
    Historia kryminalna:
    <br/>
    - Napadł na posterunek milicji w Zelenogorsku w dniu 18.03.2022. Został postrzelony i w stanie krytycznym został zabrany do lokalnego szpitala.
"]];

// player createDiaryRecord ["militiaRecord", ["Jemniołek Stanisław",
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

// player createDiaryRecord ["militiaRecord", ["Jemniołek Janek ps. „jemniom”",
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

player createDiaryRecord ["militiaRecord", ["Iwanowicz Toivo ps. Igel",
    "Były milicjant, urodzony w roku 1980. Aktualnie bezrobotny. Miał dwójkę dzieci, stracił tragicznie podczas wyzwolenia, sprawcy nie odnaleziono. Potencjalnie niebezpieczny dla porządku publicznego.
    <br/><br/>
    Miejsce zamieszkania: NIEZNANE, kiedyś <marker name='sys_marker_home_igel'>Berezino</marker>
    <br/>
    Dokumenty:
    <br/>
    - Pozwolenie na broń; posiada myśliwski sztucer po pradziadzie
    <br/>
    - Prawo jazdy; ważne bezterminowo
    <br/>
    - Własność pojazdu: Zardzewiały TT650
    <br/><br/>
    Historia kryminalna:
    <br/>
    - Zdegradowany do stopnia podporucznika i zawieszony z powodu nałogu heroinowego. Spędził 2 lata w ośrodkach odwykowych i na rehabilitacji.
    <br/>
    - Aktywnie działał przy koordynacji ruchu milicyjnego ruchu oporu w czasie wyzwolenia Czarnorusi przez bratni naród Czedacki. Przeznaczony do stracenia, został uratowany przez ruch oporu. Wyrok stracenia został odwołany, gdyż wyzwolenie zostało zakończone z powodzeniem.
    <br/>
    - Napadł na posterunek milicji w Zelenogorsku w dniu 18.03.2022. Został postrzelony i w stanie krytycznym został zabrany do lokalnego szpitala.
"]];

player createDiaryRecord ["militiaRecord", ["Hypev Ivanion",
    "Były student ekonomii na Uniwersytecie Czernogórskim, został z niego wyrzucony po aresztowaniu podczas protestów antyczedackich.
    <br/><br/>
    Miejsce zamieszkania: <marker name='sys_marker_home_hypev'>Na zachód od Bogtyrki, przy zachodniej granicy Czarnorusi</marker>
    <br/>
    Dokumenty:
    <br/>
    - Pozwolenie na broń; brak własnej broni
    <br/>
    - Prawo jazdy; ważne bezterminowo
    <br/>
    - Własność pojazdu: UAZ 8014 MA
    <br/><br/>
    Historia kryminalna:
    <br/>
    - Aresztowany w trakcie protestów antyczedackich w Czernogorsku 08.06.2021
"]];

player createDiaryRecord ["militiaRecord", ["Garliński Ziuk",
    "Brudny wieśniak.
    <br/><br/>
    Miejsce zamieszkania: <marker name='sys_marker_home_ziuk'>Pogorewka, naprzeciwko cerkwii</marker>
    <br/>
    Dokumenty:
    <br/>
    - Prawo jazdy; ważne bezterminowo
    <br/>
    - Pozwolenie na broń; posiada strzelbę
    <br/><br/>
    Historia kryminalna:
    <br/>
    Aresztowany za domniemany udział w napadzie na posterunek w dniu 18.03.2022. Zatrzymany do kontroli na wyjeździe z Zelenogorska tuż po napadzie. Przewoził w samochodzie broń, kamizelki i granaty ogłuszające. Stwierdził, że przestępcy pomylili samochody i zabrali jego pojazd a on nie zauważył i odjechał ich pojazdem, bo były takie same. Zeznania funkcjonariuszy potwierdzają, że koło posterunku były 2 czerwone pojazdy w momencie napadu. Znaleziono 2 porzucone czerwone pojazdy w Pulkowie i Pustoszce. Zwolniony z powodu braku dowodów, skonfiskowano granaty.
"]];

player createDiaryRecord ["militiaRecord", ["Bracelos Krasnolitus",
    "Emerytowany kapitan armii czarnoruskiej. Zajmuje się strzelectwem.
    <br/><br/>
    Miejsce zamieszkania: <marker name='sys_marker_home_bracelos'>Lopatino</marker>
    <br/>
    Dokumenty:
    <br/>
    - Prawo jazdy; ważne bezterminowo
    <br/>
    - Pozwolenie na broń; AKM, CZ550, 6P9 z tłumikiem
    <br/><br/>
    Historia kryminalna:
    <br/>
    Brak
"]];
