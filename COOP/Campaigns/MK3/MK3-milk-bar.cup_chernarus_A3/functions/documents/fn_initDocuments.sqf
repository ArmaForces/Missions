#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Initializes documents. Runs on server.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

if (!isServer) exitWith {};

private _idFunc = {
    params ["_name", ["_birthDate", "B/D"], ["_country", "Republika Czarnorusi"]];

    format ["%1<br/>Urodzony: %2<br/>%3", _name, _birthDate, _country];
};

// TEST
GVAR(allDocuments) set [
    "_SP_PLAYER_", [
        ["ID", "Bongo Dongo" call _idFunc],
        ["Prawo jazdy", "Jazda z kurwami"],
        ["Pozwolenie na broń", "Sztucer"]
]];

// Ajvar
GVAR(allDocuments) set [
    "TBD_Ajvar_UID", [
        ["ID", "Papalugos Inos" call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Dowód Rejestracyjny Skoda", "Skoda Octavia, Czarna, CH-SV4JV4R"],
        ["Dowód Rejestracyjny Gyros", "Skoda S1203, Zielona Gyros, CH-SV4JV4R2"]
]];

// Bene
GVAR(allDocuments) set [
    "TBD_Bene_UID", [
        ["ID", ["Beniamino Castello", 1992] call _idFunc],
        ["Prawo jazdy", "Samochód; Samolot"]
]];

// Bolec
GVAR(allDocuments) set [
    "TBD_Bolec_UID", [
        ["ID", "Aslanbek Abdurakhman" call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Dowód Rejestracyjny", "Skoda 105L, Niebieska, TK-LMB073C"]
]];

// Command DDOS
GVAR(allDocuments) set [
    "TBD_CommandDDOS_UID", [
        ["Dowód Osobisty", ["Karol Wrobel", nil, "Rzeczpospolita Polska"] call _idFunc]
]];

// Czesiek
GVAR(allDocuments) set [
    "TBD_Czesiek_UID", [
        ["ID", ["Jan Honza Mikes", 1987, "Česká republika"] call _idFunc]
]];

// Haverex
GVAR(allDocuments) set [
    "TBD_Haverex_UID", [
        ["Dowód Osobisty", ["Waldemar Biały", nil, "Rzeczpospolita Polska"] call _idFunc]
]];

// Hefalump
GVAR(allDocuments) set [
    "TBD_Hefalump_UID", [
        ["ID", ["Raashid el-Karam", nil, "Republika Takistanu"] call _idFunc],
        ["Prawo jazdy", "Samochód"]
]];

// Hyperion
GVAR(allDocuments) set [
    "TBD_Hyperion_UID", [
        ["ID", "Ivanion Hypev" call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Pozwolenie na broń", "Brak własnej broni"],
        ["Dowód Rejestracyjny", "UAZ 8014 MA"]
]];

// Jay
GVAR(allDocuments) set [
    "TBD_Jay_UID", [
        ["ID", "TBD_Jay" call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Paszport Polsatu", "TBD_Jay jest dziennikarzem<br/>Wystawca: AAN News"]
]];

// Krystol
GVAR(allDocuments) set [
    "TBD_Krystol_UID", [
        ["ID", "Bedřich Pavlaček" call _idFunc],
        ["Prawo jazdy", "Samochód; Autobus; Motocykl"],
        ["Legitymacja CKS", "Kierowca Czarnoruskich Kolei Samochodowych<br/>Bedřich Pavlaček<br/>Autobus CH-CKS003"],
        ["Dowód Rejestracyjny", "TT650, Czerwono-biały, Bez numerów"]
]];

// Mikkeboss
GVAR(allDocuments) set [
    "TBD_Mikkeboss_UID", [
        ["ID", "Krasnolitus Bracelos" call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Legitymacja wojskowa", "Kapitan Armii Czarnorusi<br/>W stanie spoczynku od 2020 roku<br/>Miejsce służby: Lotnisko Czarnoruś"],
        ["Pozwolenie na broń", "AKM, CZ 550, 6P9"],
        ["Dowód Rejestracyjny", "Skoda Octavia, Biała, CH-LPM4J1K"]
]];

// Monkey
GVAR(allDocuments) set [
    "TBD_Monkey_UID", [
        ["ID", ["Dimitrij Monkyrov", 1969] call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Legitymacja wojskowa", "Szeregowy Armii Czedackiej<br/>Zdegradowany ze stopnia podpułkownika za zdefraudowanie transportu wojskowego<br/>Miejsce służby: Obóz Tishina"]
]];

// Nielu
GVAR(allDocuments) set [
    "TBD_Nielu_UID", [
        ["ID", "Janek Jemniołek" call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Dowód Rejestracyjny", "Łada, Czarna, CH-CHN137U"]
]];

// Piesa
GVAR(allDocuments) set [
    "TBD_Piesa_UID", [
        ["ID", ["Toivo Iwanowicz", 1980] call _idFunc],
        ["Prawo jazdy", "Samochód; Motocykl"],
        ["Pozwolenie na broń", "Myśliwski sztucer po pradziadzie"],
        ["Dowód Rejestracyjny", "TT650, Zardzewiały, Bez numerów"]
]];

// Renchon
GVAR(allDocuments) set [
    "TBD_Renchon_UID", [
        ["ID", "Ziuk Garliński" call _idFunc],
        ["Prawo jazdy", "Samochód; Ciężarówka; Traktor"],
        ["Pozwolenie na broń", "Sztucer"]
]];

// Saper
GVAR(allDocuments) set [
    "TBD_Saper_UID", [
        ["ID", "Janusz Сгам" call _idFunc]
]];

// Seweryn
GVAR(allDocuments) set [
    "TBD_Seweryn_UID", [
        ["ID", "Kuta Napletes" call _idFunc],
        ["Prawo jazdy", "Samochód; Traktor"],
        ["Dowód Rejestracyjny", "Traktor CATOR 2009, Bez numerów"]
]];

// Stalker
GVAR(allDocuments) set [
    "TBD_Stalker_UID", [
        ["ID", "Andriej Stalkerow" call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Dowód Rejestracyjny", "Wołga, Czarna, CH-PR0B0SZCZ"]
]];

// Zaborz
GVAR(allDocuments) set [
    "TBD_Zaborz_UID", [
        ["Dowód Osobisty", ["Wojciech Kazubowski", 1992, "Rzeczpospolita Polska"] call _idFunc],
        ["Prawo jazdy", "Kategoria B<br/>Rzeczpospolita Polska"]
]];

// Windows
GVAR(allDocuments) set [
    "TBD_Windows_UID", [
        ["ID", "TBD_Windows" call _idFunc],
        ["Prawo jazdy", "Samochód"]
]];

// TODO: Assignable documents

// Task #1 - kradziona Łada kierowca
GVAR(allDocuments) set [
    "Viktor Bobek", [
        ["ID", ["Viktor Bobek", 1976] call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Dowód rejestracyjny", "Łada, Zielona, CH-NP444"]
]];

// Task #2 - kradziona Łada
GVAR(allDocuments) set [
    "Michal Korolenko", [
        ["ID", ["Michal Korolenko", 1973] call _idFunc],
        ["Prawo jazdy", "Samochód"]
]];

// Task #3 -
GVAR(allDocuments) set [
    "Boris Grygar", [
        ["ID", ["Boris Grygar", 1973] call _idFunc],
        ["Prawo jazdy", "Samochód"]
]];

// Task #4 Dezerter
GVAR(allDocuments) set [
    "Piotr Wowrynowicz", [
        ["ID", ["Piotr Wowrynowicz", 1989] call _idFunc]
]];

// Task #5 - Szmugler fajek cywilny
// Jabar
GVAR(allDocuments) set [
    "František Jabarećek", [
        ["ID", ["František Jabarećek", 1991] call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Dowód rejestracyjny", "Łada, Zielona, CH-SS1243"]
]];

// Task #6 - Szmugler fajek czedak
// Ajvar?
GVAR(allDocuments) set [
    "Boris Planicka", [
        ["ID", ["Boris Planicka", 1994] call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Legitymacja wojskowa", "Szeregowy Armii Czedackiej<br/>Miejsce służby: Obóz Tishina"]
]];

// Task #7 - Kierowca ciężarówki do fabryki krzeseł
GVAR(allDocuments) set [
    "Oleg Kropacek", [
        ["ID", ["Oleg Kropacek", 1987] call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Dowód rejestracyjny", "Praga V3S, Żółty, CH-NS2312"]
]];

// Task #8 - Pomocnik z krzesłami
GVAR(allDocuments) set [
    "Radosław Przyjazny", [
        ["ID", ["Radosław Przyjazny", 1996] call _idFunc]
]];

// Task #

// Piesa nie Piesa
GVAR(allDocuments) set [
    "TBD_Piesa2_UID", [
        ["ID", ["Fiodor Piotrowicz Chwalewagner", 1967] call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Dowód Rejestracyjny", "Wołga, Zielona, TODO"]
]];

// Godziak (OPFOR)
GVAR(allDocuments) set [
    "TBD_Godziak_UID", [
        ["ID", ["Yewgenij Fisenko", nil, "Republika Czedacka"] call _idFunc],
        ["Legitymacja wojskowa", "Porucznik Armii Republiki Czedackiej<br/>Dowódca jednostki<br/>Miejsce służby: Obóz Wojskowy Tishina"]
]];

// Generic Chedaki
GVAR(allDocuments) set [
    "Bogdan Beranek", [
        ["ID", ["Bogdan Beranek", 1992] call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Legitymacja wojskowa", "Szeregowy Armii Czedackiej<br/>Miejsce służby: Obóz Tishina"]
]];

GVAR(allDocuments) set [
    "Jaromir Smetana", [
        ["ID", ["Jaromir Smetana", 1995] call _idFunc],
        ["Legitymacja wojskowa", "Szeregowy Armii Czedackiej<br/>Miejsce służby: Obóz Tishina"]
]];

GVAR(allDocuments) set [
    "Jaromir Kozel", [
        ["ID", ["Jaromir Kozel", 1995] call _idFunc],
        ["Legitymacja wojskowa", "Szeregowy Armii Czedackiej<br/>Miejsce służby: Obóz Tishina"]
]];

publicVariable QGVAR(allDocuments);
