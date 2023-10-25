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
    "76561197994901659", [
        ["ID", "Papalugos Inos" call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Dowód Rejestracyjny Skoda", "Skoda Octavia, Czarna, CH-SV4JV4R"],
        ["Dowód Rejestracyjny Gyros", "Skoda S1203, Zielona Gyros, CH-SV4JV4R2"]
]];

// Bene
GVAR(allDocuments) set [
    "76561198001457336", [
        ["ID", ["Beniamino Castello", 1992] call _idFunc],
        ["Prawo jazdy", "Samochód; Samolot"]
]];

// Bolec
GVAR(allDocuments) set [
    "76561197962229109", [
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
        ["ID", ["Jan Honza Mikes", 1987, "Česká republika"] call _idFunc],
        ["Legitymacja Milicjanta", "Krawężnik Jan Honza Mikes<br/>Rejon Zelenogorsk"]
]];

// Godziak (OPFOR)
GVAR(allDocuments) set [
    "76561198253276369", [
        ["ID", ["Yewgenij Fisenko", nil, "Republika Czedacka"] call _idFunc],
        ["Legitymacja wojskowa", "Porucznik Armii Republiki Czedackiej<br/>Dowódca jednostki<br/>Miejsce służby: Obóz Wojskowy Tishina"]
]];

// Haverex
GVAR(allDocuments) set [
    "TBD_Haverex_UID", [
        ["Dowód Osobisty", ["Waldemar Biały", nil, "Rzeczpospolita Polska"] call _idFunc]
]];

// Hefalump
GVAR(allDocuments) set [
    "76561198204208611", [
        ["ID", ["Raashid el-Karam", nil, "Republika Takistanu"] call _idFunc],
        ["Prawo jazdy", "Samochód"]
]];

// Hyperion
GVAR(allDocuments) set [
    "76561198146225203", [
        ["ID", "Ivanion Hypev" call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Pozwolenie na broń", "Brak własnej broni"],
        ["Dowód Rejestracyjny", "UAZ 8014 MA"]
]];

// Jay
GVAR(allDocuments) set [
    "76561198048944238", [
        ["ID", "TBD_Jay" call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Paszport Polsatu", "TBD_Jay jest dziennikarzem<br/>Wystawca: AAN News"]
]];

// Krystol
GVAR(allDocuments) set [
    "76561198073589142", [
        ["ID", "Bedřich Pavlaček" call _idFunc],
        ["Prawo jazdy", "Samochód; Autobus; Motocykl"],
        ["Legitymacja CKS", "Kierowca Czarnoruskich Kolei Samochodowych<br/>Bedřich Pavlaček<br/>Autobus CH-CKS003"],
        ["Dowód Rejestracyjny", "TT650, Czerwono-biały, Bez numerów"]
]];

// Mikkeboss
GVAR(allDocuments) set [
    "76561198067129148", [
        ["ID", "Krasnolitus Bracelos" call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Legitymacja wojskowa", "Kapitan Armii Czarnorusi<br/>W stanie spoczynku od 2020 roku<br/>Miejsce służby: Lotnisko Czarnoruś"],
        ["Pozwolenie na broń", "AKM, CZ 550, 6P9"],
        ["Dowód Rejestracyjny", "Skoda Octavia, Biała, CH-LPM4J1K"]
]];

// Monkey
GVAR(allDocuments) set [
    "76561198066994468", [
        ["ID", ["Dimitrij Monkyrov", 1969] call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Legitymacja wojskowa", "Szeregowy Armii Czedackiej<br/>Zdegradowany ze stopnia podpułkownika za zdefraudowanie transportu wojskowego<br/>Miejsce służby: Obóz Tishina"]
]];

// Nielu
GVAR(allDocuments) set [
    "76561197987156621", [
        ["ID", "Janek Jemniołek" call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Dowód Rejestracyjny", "Łada, Czarna, CH-CHN137U"]
]];

// Piesa
GVAR(allDocuments) set [
    "76561198221934828", [
        ["ID", ["Toivo Iwanowicz", 1980] call _idFunc],
        ["Prawo jazdy", "Samochód; Motocykl"],
        ["Pozwolenie na broń", "Myśliwski sztucer po pradziadzie"],
        ["Dowód Rejestracyjny", "TT650, Zardzewiały, Bez numerów"]
]];

// Piesa nie Piesa
GVAR(allDocuments) set [
    "76561198221934828", [
        ["ID", ["Fiodor Piotrowicz Chwalewagner", 1967] call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Dowód Rejestracyjny", "Wołga, Zielona, TODO"]
]];

// Renchon
GVAR(allDocuments) set [
    "76561198028964866", [
        ["ID", "Ziuk Garliński" call _idFunc],
        ["Prawo jazdy", "Samochód; Ciężarówka; Traktor"],
        ["Pozwolenie na broń", "Sztucer"]
]];

// Saper
GVAR(allDocuments) set [
    "76561198022680504", [
        ["ID", "Janusz Сгам" call _idFunc],
        ["Legitymacja Milicjanta", "Krawężnik Janusz Сгам<br/>Rejon Zelenogorsk"]
]];

// Seweryn
GVAR(allDocuments) set [
    "76561198019933197", [
        ["ID", "Kuta Napletes" call _idFunc],
        ["Prawo jazdy", "Samochód; Traktor"],
        ["Dowód Rejestracyjny", "Traktor CATOR 2009, Bez numerów"]
]];

// Stalker
GVAR(allDocuments) set [
    "76561198205788649", [
        ["ID", "Andriej Stalkerow" call _idFunc],
        ["Prawo jazdy", "Samochód"]
]];

// Zaborz
GVAR(allDocuments) set [
    "76561198060965315", [
        ["Dowód Osobisty", ["Wojciech Kazubowski", 1992, "Rzeczpospolita Polska"] call _idFunc],
        ["Prawo jazdy", "Kategoria B<br/>Rzeczpospolita Polska"]
]];

// Windows
GVAR(allDocuments) set [
    "76561198018567644", [
        ["ID", "TBD_Windows" call _idFunc],
        ["Prawo jazdy", "Samochód"]
]];

// TODO: Assignable documents
GVAR(allDocuments) set [
    "TBD_ASSIGNABLE", [
        ["Dowód rejestracyjny", "Łada, Zielona, CH-NP444"]
]];

publicVariable QGVAR(allDocuments);

// Jabar: 76561198055137986
