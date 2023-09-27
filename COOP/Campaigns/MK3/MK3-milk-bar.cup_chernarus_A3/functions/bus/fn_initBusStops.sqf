#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Schedules for buses in Chernarus
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#define ARROW_HELPER "Sign_Arrow_Direction_Cyan_F"
#define BALL_HELPER "Sign_Sphere25cm_F"

// Initialize lines
private _dddFnc = {
    params ["_lineNumber", "_origin", "_destination", "_originDepartureHours", "_line"];

    private _timeToArriveTotal = 0;
    {
        _x params ["_arrow", "_timeToArriveFromPrevious"];
        _timeToArriveTotal = _timeToArriveTotal + _timeToArriveFromPrevious;

        private _lineHeaderFormatted = format [LELSTRING(BusStops,LineX), _lineNumber, _origin, _destination];

        private _departureTimes = _originDepartureHours
            apply {_x + _timeToArriveTotal * (1/60)}
            apply {[_x, "HH:MM"] call BIS_fnc_timeToString}
            joinString " | ";

        private _lineDepartures = format ["%1\n%2", _lineHeaderFormatted, _departureTimes];

        private _timetable = _arrow getVariable [QGVAR(busTimetable), ""];
        if (_timetable isNotEqualTo "") then {
            _timetable = format ["%1\n-----\n%2", _timetable, _lineDepartures];
        } else {
            private _arrowLocationName = _arrow getVariable [QGVAR(busStopName), ""];
            if (_arrowLocationName isEqualTo "") then {
                private _arrowLocation = [_arrow] call FUNC(getNearestLocationWithAvailableName);
                _arrowLocationName = [_arrowLocation] call FUNC(getLocationName);
            };

            _timetable = format ["%1\n=====\n%2", _arrowLocationName, _lineDepartures];
        };
        TRACE_1("Updated timetable: %1", _timetable);

        _arrow setVariable [QGVAR(busTimetable), _timetable];
        hideObjectGlobal _arrow;
    } forEach _line;

    INFO_4("Initialized line %1: %2 - %3 | Total length (min): %4", _lineNumber, _origin, _destination, _timeToArriveTotal);
    INFO_4("Line %1 has stops: %2", _lineNumber, str _line);
};

// Departure times (double[])
// Stop | Time to arrive from previous (min)
private _line1DeparturesFromLopatino = [6, 7, 8, 9];
private _line1ScheduleFromLopatino = [
    [bus_lopatino_loop, 0],
    [bus_vibor_from_lopatino, 3],
    [bus_pustoshka_from_vibor, 2],
    [bus_pustoshka_church, 1],
    [bus_sosnovka_to_zelenogorsk, 4],
    [bus_zelenogorsk_from_sosnovka, 2],
    [bus_zelenogorsk_centre_to_south, 1],
    [bus_zelenogorsk_train_station, 2]
];

private _line1DeparturesFromZelenogorsk = [6.4, 7.4, 8.4, 9.4];
private _line1ScheduleFromZelenogorsk = [
    [bus_zelenogorsk_train_station, 0],
    [bus_zelenogorsk_centre_to_north, 2],
    [bus_zelenogorsk_to_sosnovka, 1],
    [bus_sosnovka_from_zelenogorsk, 4],
    [bus_pustoshka_to_vibor, 4],
    [bus_vibor_from_pustoshka, 2],
    [bus_lopatino, 3],
    [bus_lopatino_loop, 1]
];

private _line2DeparturesFromLopatino = [7.1, 8.3, 9.5];
private _line2ScheduleFromLopatino = [
    [bus_lopatino_loop, 0],
    [bus_vibor_from_lopatino, 3],
    [bus_kabanino_to_stary_sobor, 2],
    [bus_stary_sobor_from_kabanino, 2],
    [bus_rogovo_to_pogorevka, 3],
    [bus_pogorevka_from_rogovo, 2],
    [bus_zelenogorsk_train_station, 2]
];

private _line2DeparturesFromZelenogorsk = [7.3, 8.5, 9.7];
private _line2ScheduleFromZelenogorsk = [
    [bus_zelenogorsk_train_station, 0],
    [bus_pogorevka_to_rogovo, 7],
    [bus_rogovo_from_pogorevka, 2],
    [bus_stary_sobor_to_kabanino, 3],
    [bus_kabanino_from_stary_sobor, 2],
    [bus_vibor_from_kabanino, 3],
    [bus_lopatino, 3],
    [bus_lopatino_loop, 1]
];

// Line no. | Start | End | Start hours
[
    1, // Line no.
    "Lopatino", // Start location name
    LELSTRING(BusStops,Line1_ZelenogorskViaPustoshka), // End location name
    _line1DeparturesFromLopatino, // Start hours double[]
    _line1ScheduleFromLopatino // Stops [arrow_object, int timeToArriveFromPrevious]
] call _dddFnc;

[
    1, // Line no.
    "Zelenogorsk", // Start location name
    LELSTRING(BusStops,Line1_LopatinoViaPustoshka), // End location name
    _line1DeparturesFromZelenogorsk, // Start hours double[]
    _line1ScheduleFromZelenogorsk // Stops [arrow_object, int timeToArriveFromPrevious]
] call _dddFnc;

[
    2, // Line no.
    "Lopatino", // Start location name
    LELSTRING(BusStops,Line2_ZelenogorskViaStarySobor), // End location name
    _line2DeparturesFromLopatino, // Start hours double[]
    _line2ScheduleFromLopatino // Stops [arrow_object, int timeToArriveFromPrevious]
] call _dddFnc;

[
    2, // Line no.
    "Zelenogorsk", // Start location name
    LELSTRING(BusStops,Line2_LopatinoViaStarySobor), // End location name
    _line2DeparturesFromZelenogorsk, // Start hours double[]
    _line2ScheduleFromZelenogorsk // Stops [arrow_object, int timeToArriveFromPrevious]
] call _dddFnc;

private _allArrows = allMissionObjects ARROW_HELPER;
private _arrowsWithoutLineAssigned = _allArrows
    select {_x getVariable [QGVAR(busTimetable), ""] isEqualTo ""};

{
    WARNING_2("Arrow %1 on position %2 has no line assigned.", str _x, position _x);
    deleteVehicle _x;
} forEach _arrowsWithoutLineAssigned;

// Initialize bus stops
private _busStopModels = [
    "zastavka_cedule.p3d",
    "busstop_village.p3d",
    // "busstop_01_shelter_f.p3d",
    "busstop_02_shelter_f.p3d"
];

private _pos = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
private _allObjects = nearestObjects [_pos, [], worldSize, false];
private _busStops = _allObjects select {typeOf _x in _busStopModels || {((getModelInfo _x)#0) in _busStopModels}};

private _action = [
    "rozklad_jazdy",
    "Rozkład jazdy",
    "\A3\ui_f\data\map\mapcontrol\BusStop_CA.paa",
    {
        params ["_target", "_player"];
        private _arrow = _target getVariable [QGVAR(busStopArrow), objNull];
        if (_arrow isEqualTo objNull) exitWith {
            hint "PRZYSTANEK NIECZYNNY";
        };

        private _timetable = _arrow getVariable [QGVAR(busTimetable), "BRAK ROZKŁADU"];
        hint _timetable;
    },
    {true}
] call ace_interact_menu_fnc_createAction;

{
    private _busStop = _x;
    private _position = getPos _x;
    private _model = getModelInfo _busStop select 0;

    private _dummyLocalHelper = switch (_model) do {
        case "busstop_village.p3d": {
            private _noticeboard = "Land_Noticeboard_F" createVehicleLocal [0, 0, 0];

            // Set it along the left wall of the bus stop shed
            private _dir = vectorDir _busStop;
            private __noticeboardPosition = _position vectorAdd ([0, 0, 1.35] vectorCrossProduct _dir)
                vectorAdd [0, 0, -2.6];
            _noticeboard setPos __noticeboardPosition;

            // Rotate so it's aligned with wall
            _noticeboard setDir ((getDir _busStop) - 90);

            // Create ball helper as interaction point on Land_Noticeboard_F is too low.
            private _helper = BALL_HELPER createVehicleLocal [0, 0, 0];

            // Put the ball +- into the board
            private _helperPosition = __noticeboardPosition vectorAdd [0, 0, 1.25];
            _helper setPos _helperPosition;

            // Hide the helper, but interactions are still possible, unlike with hideObject
            _helper setObjectTexture [0, ""];

            _helper
        };
        case "zastavka_cedule.p3d": {
            private _helper = BALL_HELPER createVehicleLocal [0, 0, 0];

            // Put the ball +- into timetable of the object
            private _helperPosition = _position vectorAdd [0, 0, -1.15];
            _helper setPos _helperPosition;

            // Hide the helper, but interactions are still possible, unlike with hideObject
            _helper setObjectTexture [0, ""];

            _helper
        };
        // case "busstop_01_shelter_f.p3d";
        case "busstop_02_shelter_f.p3d": {
            private _helper = BALL_HELPER createVehicleLocal [0, 0, 0];

            // Put the ball +- into timetable of the object
            private _helperPosition = _busStop modelToWorld [-1.5, 1.2, 0.4];
            _helper setPos _helperPosition;

            // Hide the helper, but interactions are still possible, unlike with hideObject
            _helper setObjectTexture [0, ""];

            _helper
        };
        default {
            private _helper = BALL_HELPER createVehicleLocal [0, 0, 0];
            _helper setPos _position;

            _helper
        };
    };

    _dummyLocalHelper enableSimulation false;

    private _busStopArrows = nearestObjects [_position, [ARROW_HELPER], 10];
    if (count _busStopArrows > 0) then {
        private _arrow = _busStopArrows select 0;

        _dummyLocalHelper setVariable [QGVAR(busStopArrow), _arrow];
        _arrow setVariable [QGVAR(busStop), _dummyLocalHelper];

        private _arrowTimetable = _arrow getVariable [QGVAR(busTimetable), ""];
        if (_arrowTimetable isNotEqualTo "") then {
            INFO_1("Found bus stop arrow with a timetable near %1", _position);
        } else {
            INFO_1("Found bus stop arrow without a timetable near %1", _position);
        };
    } else {
        WARNING_1("Not found bus stop arrow near %1", _position);
        deleteVehicle _dummyLocalHelper;
    };

    [_dummyLocalHelper, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;
} forEach _busStops;
