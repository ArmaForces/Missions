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

        private _lineHeaderFormatted = format ["Line %1: %2 - %3", _lineNumber, _origin, _destination];

        private _departureTimes = _originDepartureHours
            apply {_x + _timeToArriveTotal * (1/60)}
            apply {[_x, "HH:MM"] call BIS_fnc_timeToString}
            joinString " | ";

        private _lineDepartures = format ["%1\n%2", _lineHeaderFormatted, _departureTimes];

        private _timetable = _arrow getVariable [QGVAR(busTimetable), ""];
        if (_timetable isNotEqualTo "") then {
            _timetable = format ["%1\n-----\n%2", _timetable, _lineDepartures];
        } else {
            _timetable = _lineDepartures;
        };
        TRACE_1("Updated timetable: %1", _timetable);

        _arrow setVariable [QGVAR(busTimetable), _timetable];
    } forEach _line;

    INFO_4("Initialized line %1: %2 - %3 | Total length (min): %4", _lineNumber, _origin, _destination, _timeToArriveTotal);
    INFO_4("Line %1 has stops: %2", _lineNumber, str _line);
};

[{
    params ["_dddFnc"];
    // Stop | Time to arrive from previous (min)
    private _line1ScheduleFromLopatino = [
        [bus_lopatino_loop, 0],
        [bus_vibor_from_lopatino, 3],
        [bus_pustoshka_from_vibor, 2],
        [bus_pustoshka_church, 1],
        [bus_sosnovka_to_zelenogorsk, 4],
        [bus_zelenogorsk_from_sosnovka, 2]
    ];

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

    private _line2ScheduleFromLopatino = [
        [bus_lopatino_loop, 0],
        [bus_vibor_from_lopatino, 3],
        [bus_kabanino_to_stary_sobor, 2],
        [bus_stary_sobor_from_kabanino, 2],
        [bus_rogovo_to_pogorevka, 3],
        [bus_pogorevka_from_rogovo, 2],
        [bus_zelenogorsk_train_station, 2]
    ];

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
    [1, "Lopatino", "Zelenogorsk p. Pustoshka", [
        7, 8, 9
    ], _line1ScheduleFromLopatino] call _dddFnc;

    [1, "Zelenogorsk", "Lopatino p. Pustoshka", [
        7.2, 8.3, 9.4
    ], _line1ScheduleFromZelenogorsk] call _dddFnc;

    [2, "Lopatino", "Zelenogorsk p. Stary Sobor", [
        7.1, 8.3, 9.5
    ], _line2ScheduleFromLopatino] call _dddFnc;

    [2, "Zelenogorsk", "Lopatino p. Stary Sobor", [
        7.3, 8.5, 9.7
    ], _line2ScheduleFromZelenogorsk] call _dddFnc;

    private _allArrows = allMissionObjects ARROW_HELPER;
    private _arrowsWithoutLineAssigned = _allArrows
        select {_x getVariable [QGVAR(busTimetable), ""] isEqualTo ""};

    {
        WARNING_2("Arrow %1 on position %2 has no line assigned.", str _x, position _x);
        deleteVehicle _x;
    } forEach _arrowsWithoutLineAssigned;
}, [_dddFnc]] call CBA_fnc_execNextFrame;

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
            private _helper = "Land_Noticeboard_F" createVehicleLocal [0, 0, 0];

            // Set it along the left wall of the bus stop shed
            private _dir = vectorDir _busStop;
            private _helperPosition = _position vectorAdd ([0, 0, 1.35] vectorCrossProduct _dir)
                vectorAdd [0, 0, -2.6];
            _helper setPos _helperPosition;

            // Rotate so it's aligned with wall
            _helper setDir ((getDir _busStop) - 90);

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

    // Arrows will appear after mission init, but this entire script runs in preInit, so a delay is needed.
    [{
        params ["_position", "_dummyLocalHelper"];
        private _busStopArrows = nearestObjects [_position, [ARROW_HELPER], 10];
        if (count _busStopArrows > 0) then {
            private _arrow = _busStopArrows select 0;
            _dummyLocalHelper setVariable [QGVAR(busStopArrow), _arrow];
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
    }, [_position, _dummyLocalHelper]] call CBA_fnc_execNextFrame;

    [_dummyLocalHelper, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;
} forEach _busStops;