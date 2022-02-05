# Slippery Night

## Mission Description

Ruhan special forces are trapped on a construction site.

## Briefing

Ruha, 2010

This morning Ruhan Special Forces managed to secure toys transport. Unfortunately we lost contact with them after LZ Monke was lost. Last time they reported from a construction site near Hietala. This was fortificated position and if they are still alive, most likely they are hiding there.

US forces have been deployed to the area to support Ruhan Defense Forces and launch a counterattack across the river in Ruha village.

### Tasks

1. Reach the construction site before survivors are overwhelmed
2. Break through the river in Ruha
3. Find high ranked officer and secure for extraction

### Execution

As Alpha platoon, your task will be to reach the trapped Bravo platoon as quickly as possible, to save them from inevitable death. Then, both platoons will head to Ruha, counterattack through the river and attempt to kidnap highly ranked officer.

## Assets

- 2 Platoon HQ (3 man)
  - 3 infantry squads each (8 man each)

Zeus slots: 2
Total slots: 56

## Played on

- 2021-11-27

## Zeus stuff

### Mission flow

```sqf
["BravoDead"] call CBA_fnc_serverEvent;
["ReachedConstructionSite"] call CBA_fnc_serverEvent;

["EstablishedBridgeheadInNorthernRuha"] call CBA_fnc_serverEvent;

["OfficerDead"] call CBA_fnc_serverEvent;
["OfficerCaptured"] call CBA_fnc_serverEvent;
```sqf
