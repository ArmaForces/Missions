# Ruhan Zone 2

## Mission Description

Ruhan special forces are tasked with securing toys transport.

## Briefing

Ruha, 2010

The ongoing hybrid war is devastating. Unknown forces captured the area west of the river. They recently managed to cross it over the northern bridge, pushing Ruhan Defense Forces south. They appear quite well armed and trained, which is why we suppose this might be a destabilization attempt orchestrated by a foreign intelligence.

Our intel shows they are particularly interested in factories. We suppose it's a Russian effort to take control of Ruhan industry, known for high quality toys. They started gathering all the toys from the area at the Karanmanikko village stadium.

Ruhan Defense Force, resupplied by NATO, began their counteroffensive this morning.

### Tasks

1. Land on LZ Monke
2. Support the assault on Ruhanpera
3. Capture Hietala
4. Capture Karasomething
5. Prepare fortifications
6. Protect the convoy
7. Hold Karasomething

### Execution

You will land on LZ Monke, support the ongoing assault on Ruhanpera and advance further north to secure Karasomething village and it's stadium, where all toys are stored. Friendly convoy will transport the toys out of the village.

## Assets

- 2 Platoon HQ (3 man)
  - 3 infantry squads each (8 man each)

Zeus slots: 2
Total slots: 56

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
