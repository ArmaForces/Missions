#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Creates briefing records of vehicles in Chernarus.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#define DIARY_NAME "vehicleRecord"

params [["_unit", player]];

_unit createDiarySubject [DIARY_NAME, "Numery pojazdów"];

private _createRecordFunc = {
    params ["_licensePlate", "_model", "_color", "_owner", "_description"];

    _unit createDiaryRecord [DIARY_NAME, [_licensePlate,
        format ["Model: %1 <br/>Kolor: %2 <br/>Właściciel: %3<br/><br/>Opis:<br/>%4", _model, _color, _owner, _description]
    ]];
};

["CH-ZGM004", "Łada", "Milicyjna", "Komisariat w Zelenogorsku", "Prowadzona przez milicjanta uległa wypadkowi czołowemu z autobusem ChKS jadącym środkiem drogi. Stan do kasacji, chyba że mechanik coś wyczaruje. Stoi w <marker name='sys_marker_militia_parking'>milicyjnym warsztacie</marker> i oczekuje na naprawę."] call _createRecordFunc;
["CH-ZGM002", "Łada", "Milicyjna", "Komisariat w Zelenogorsku", "Stojąca na drodze uległa wypadkowi czołowemu z autobusem ChKS, który nie zauważył jej zza budynku. Mocno zniszczony przód, do odratowania. Stoi w <marker name='sys_marker_militia_parking'>milicyjnym warsztacie</marker> i oczekuje na naprawę."] call _createRecordFunc;
["CH-ZG3131", "Łada", "Czerwony", "Nieznany", "Czerwona Łada. Zatrzymana z Ziukiem Garlińskim jako kierowcą po napadzie na komisariat. Stoi w <marker name='sys_marker_militia_parking'>milicyjnym warsztacie</marker> do rozwiązania sprawy."] call _createRecordFunc;
["CH-ZG2742", "Łada", "Czerwony", "Nieznany", "Kradziona czerwona Łada. Porzucona w Pulkowie po napadzie na komisariat. Stoi w <marker name='sys_marker_militia_parking'>milicyjnym warsztacie</marker> do rozwiązania sprawy."] call _createRecordFunc;
["CH-RG021 ", "Golf IV", "Czerwony", "Nieznany", "Kradziony czerwony Golf, zmazana ostatnia cyfra na tablicy. Właściciel nieznany. Porzucony w Pustoszce po napadzie na komisariat. Stoi w <marker name='sys_marker_militia_parking'>milicyjnym warsztacie</marker> do rozwiązania sprawy."] call _createRecordFunc;
["CH-CKS012", "Ikarus", "ChKS", "Komisariat w Zelenogorsku", "Prowadzony przez autobusiarza uległ wypadkowi czołowemu z milicyjną Ładą. Autobusiarz został obciążony mandatem za nieostrożną jazdę. Mocno uszkodzony. Stoi w <marker name='sys_marker_militia_parking'>milicyjnym warsztacie</marker> i oczekuje na naprawę."] call _createRecordFunc;
["CH-CKS006", "Ikarus", "ChKS", "Komisariat w Zelenogorsku", "Prowadzony przez autobusiarza uległ wypadkowi czołowemu z milicyjną Ładą. Autobusiarz został obciążony mandatem za przekroczenie prędkości w terenie zabudowanym i wjechanie w pojazd milicyjny. Lekko uszkodzony. Stoi w <marker name='sys_marker_militia_parking'>milicyjnym warsztacie</marker> i oczekuje na naprawę."] call _createRecordFunc;
["CH-CH1534", "Łada", "Błękitny", "Obywatel Czernogórska", "Skradziony tydzień temu w Czernogórsku."] call _createRecordFunc;

/*
 * Transforms array of short codes and long names into <br/> delimited string for display.
 * [["CODE1", "Ddd"], ["CODE2", "Dddddd"]] => "CODE1 - Ddd<br/>CODE2 - Dddddd"
*/
private _registrationCodeRecordFunc = {
    params ["_codes"];
    _codes apply {format ["%1 - %2", _x select 0, _x select 1]} joinString "<br/>"
};

private _countryCodes = [
    ["CH", "Chernarus"],
    ["TK", "Takistan"]
];

private _chernarusCityCodes = [
    ["BG", "Bogtyrka"],
    ["BR", "Berezino"],
    ["CH", "Chernogorsk"],
    ["EL", "Elektrozawodsk"],
    ["KR", "Krasnostaw"],
    ["LP", "Lopatino"],
    ["NS", "Nowy Sobor"],
    ["NP", "Nowaja Petrowka"],
    ["NW", "Nowodimitrowsk"],
    ["MS", "Miszkino"],
    ["PG", "Pogorewka"],
    ["PL", "Pulkowo"],
    ["PS", "Pustoszka"],
    ["PW", "Pawlowo"],
    ["RG", "Rogovo"],
    ["SL", "Solniczny"],
    ["SS", "Stary Sobor"],
    ["SW", "Sewerograd"],
    ["WB", "Wibor"],
    ["ZG", "Zelenogorsk"]
];

private _text = format ["Kody krajów:<br/>%1<br/><br/>Kody miast Czarnorusi:<br/>%2",
    [_countryCodes] call _registrationCodeRecordFunc,
    [_chernarusCityCodes] call _registrationCodeRecordFunc];

_unit createDiaryRecord [DIARY_NAME, ["Kody rejestracji",
    _text
]];
