# Ruhan Zone

## Mission Description

TODO: Fill

## Briefing

TODO: Fill

## Assets

- Company HQ (3 man)
- 2 Platoon HQ (3 man)
  - 3 infantry squads each (8 man each)
- Stryker ATGM (3 man)
- Logistics detachment (3 man)

Zeus slots: 2
Total slots: 65

## Played on

- 2021-09-25

## Zeus stuff

### Mission flow

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
