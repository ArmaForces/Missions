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
        ["Prawo jazdy", "Samochód"]
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
        ["Prawo jazdy", "Samochód"]
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
        ["Pozwolenie na broń", "Brak własnej broni"]
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
        ["Prawo jazdy", "Samochód; Autobus; Motocykl"]
]];

// Mikkeboss
GVAR(allDocuments) set [
    "TBD_Mikkeboss_UID", [
        ["ID", "Krasnolitus Bracelos" call _idFunc],
        ["Prawo jazdy", "Samochód"],
        ["Legitymacja wojskowa", "Kapitan Armii Czarnorusi<br/>W stanie spoczynku od 2020 roku<br/>Miejsce służby: Lotnisko Czarnoruś"],
        ["Pozwolenie na broń", "AKM, CZ 550, 6P9"]
]];

// Nielu
GVAR(allDocuments) set [
    "TBD_Nielu_UID", [
        ["ID", "Janek Jemniołek" call _idFunc],
        ["Prawo jazdy", "Samochód"]
]];

// Piesa
GVAR(allDocuments) set [
    "TBD_Piesa_UID", [
        ["ID", ["Toivo Iwanowicz", 1980] call _idFunc],
        ["Prawo jazdy", "Samochód; Motocykl"],
        ["Pozwolenie na broń", "Sztucer"]
]];

// Renchon
GVAR(allDocuments) set [
    "TBD_Renchon_UID", [
        ["ID", "Ziuk Garliński" call _idFunc],
        ["Prawo jazdy", "Samochód; Ciężarówka; Traktor"],
        ["Pozwolenie na broń", "Sztucer"]
]];

// Seweryn
GVAR(allDocuments) set [
    "TBD_Seweryn_UID", [
        ["ID", "Kuta Napletes" call _idFunc],
        ["Prawo jazdy", "Samochód; Traktor"]
]];

// Stalker
GVAR(allDocuments) set [
    "TBD_Stalker_UID", [
        ["ID", "Andriej Stalkerow" call _idFunc],
        ["Prawo jazdy", "Samochód"]
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

publicVariable QGVAR(allDocuments);
