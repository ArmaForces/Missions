# Strefa Ruhańska

## Opis misji

Ruhańskie siły specjalne wyruszają odbić transport zabawek.

## Briefing

Ruha, 2010

Trwająca wojna hybrydowa rujnuje okolicę. Nieznane siły przejęły obszar na zachód od rzeki. Niedawno dali radę przekroczyć rzekę pólnocnym mostem, wypychając Ruhańskie Siły Obronne na południe. Przeciwnicy są dobrze uzbrojeni i wyszkoleni, dlatego podejrzewany, że to może być próba destabilizacji sterowanej przez obcy wywiad.

Nasze dane wywiadowcze wskazują, że przeciwnik jest szczególnie zainteresowany fabrykami. Podejrzewamy, że to rosyjska próba przejęcia kontroli na Ruhańskim przemysłem, znanym z zabawek wysokiej jakości. Zaczęli zbierać wszystkie zabawki z okolicy na stadionie w wiosce Karanmanikko.

Ruhańskie Siły Obronne, zaopatrzone przez NATO, rozpoczęł kontrofensywę tego poranka.

### Zadania

1. Wyląduj na LZ Monke
2. Wesprzyj atak na Ruhanperę
3. Zajmij Hietalę
4. Zajmij Karacostam
5. Przygotuj fortyfikacje
6. Osłaniaj konwój
7. Utrzymaj Karacostam

### Wykonanie

Wylądujecie na LZ Monke, wesprzecie trwający atak na Ruhanperę a następnie zaatakujecie na północ w kierunku wioski Karacostam i stadionu, na którym przechowywane są wszystkie zabawki. Sojuszniczy konwój przetransportuje zabawki z wioski.

## Assets

- Dowództwo kompanii (3 ludzi)
- 2 Dowództwa plutonu (3 ludzi)
  - 3 drużyny piechoty w każdym (po 8 ludzi)
- Stryker ATGM (3 ludzi)
- Logistyka (3 ludzi)

Zeus slots: 2
Total slots: 65

## Rozegrana

- 2021-09-25

## Rzeczy dla Zeusa

### Przebieg misji

```sqf
["LZMonke"] call CBA_fnc_serverEvent;
["RuhanperaSecured"] call CBA_fnc_serverEvent;
["HietalaSecured"] call CBA_fnc_serverEvent;
["KaracostamSecured"] call CBA_fnc_serverEvent;
["CounterattackStarted"] call CBA_fnc_serverEvent;
["CounterattackSuccessfull"] call CBA_fnc_serverEvent;
["CounterattackKaracostam"] call CBA_fnc_serverEvent;
["CounterattackHietala"] call CBA_fnc_serverEvent;
["LZMonkeLost"] call CBA_fnc_serverEvent;
["BangingComplete"] call CBA_fnc_serverEvent;
```sqf
