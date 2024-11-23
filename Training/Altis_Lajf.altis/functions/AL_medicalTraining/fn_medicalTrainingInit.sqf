if (!hasInterface) exitWith {};

medicalActions = [];

medical_facility_flag addAction ["Rozpocznij szkolenie medyczne", {
	[] call AL_fnc_medicalTrainingStart;
}, {}, 2, true, false, "", "true", 5];

medical_facility_flag addAction ["Zakończ szkolenie medyczne", {
	[] call AL_fnc_medicalTrainingStop;
}, {}, 2, true, false, "", "true", 5];