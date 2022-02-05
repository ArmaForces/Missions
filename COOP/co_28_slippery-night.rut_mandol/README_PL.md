# Śliska noc

## Opis misji

Ruhańskie siły specjalne są w potrzasku na placu budowy.

## Briefing

Ruha, 2010

Tego ranka Ruhańskie Siły Specjalne zabezpieczyły transport zabawek. Niestety straciliśmy z nimi kontakt po utracie LZ Monke. Ostatni raz zgłosili się z placu budowy w pobliżu Hietali. To była ufortyfikowana pozycja i, jeżeli jeszcze żyją, najprawdopodobniej tam się ukrywają.

Siły amerykańskie przybyły na pomoc Ruhańskim Siłom Obronnym i zamierzają rozpocząć kontratak przez rzekę w wiosce Ruha.

### Zadania

1. Dotrzyj na plac budowy zanim Bravo zostanie przytłoczone atakami
2. Przebij się przez obronę na rzece w Ruha
3. Znajdź i porwij wysokiego rangą oficera

### Wykonanie

Waszym zadaniem jako plutonu Alpha będzie dotarcie do uwięzionego plutonu Bravo tak szybko, jak to możliwe, ratując ich od nieuchronnej śmierci. Później wszyscy pojedziecie do Ruha i przeprowadzicie kontratak przez rzekę oraz spróbujecie porwać wrogiego oficera.

## Assets

- 2 Dowództwa plutonu (3 ludzi)
  - 3 drużyny piechoty w każdym (po 8 ludzi)

Zeus slots: 2
Total slots: 56

## Rozegrana

- 2021-11-27

## Rzeczy dla Zeusa

### Przebieg misji

```sqf
["BravoDead"] call CBA_fnc_serverEvent;
["ReachedConstructionSite"] call CBA_fnc_serverEvent;

["EstablishedBridgeheadInNorthernRuha"] call CBA_fnc_serverEvent;

["OfficerDead"] call CBA_fnc_serverEvent;
["OfficerCaptured"] call CBA_fnc_serverEvent;
```sqf
