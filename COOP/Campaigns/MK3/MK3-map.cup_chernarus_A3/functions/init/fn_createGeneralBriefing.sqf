#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Creates general briefing.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params [["_unit", player]];

_unit createDiarySubject ["generalBriefing", "Kartoteka"];

_unit createDiaryRecord ["generalBriefing", ["Opcje medyczne",
    "Menu medyczne dostępne tylko dla medyków lub w szpitalu/pojeździe medycznym."
]];

_unit createDiaryRecord ["generalBriefing", ["Główne założenia",
    "Wasze życie jest cenne i nie chcecie go stracić."
]];
