#define COPY_1(ITEM) 		ITEM
#define COPY_2(ITEM) 		COPY_1(ITEM),ITEM
#define COPY_3(ITEM) 		COPY_2(ITEM),ITEM
#define COPY_4(ITEM) 		COPY_3(ITEM),ITEM
#define COPY_5(ITEM) 		COPY_4(ITEM),ITEM
#define COPY_6(ITEM) 		COPY_5(ITEM),ITEM
#define COPY_7(ITEM) 		COPY_6(ITEM),ITEM
#define COPY_8(ITEM) 		COPY_7(ITEM),ITEM
#define COPY_9(ITEM) 		COPY_8(ITEM),ITEM
#define COPY_10(ITEM) 		COPY_9(ITEM),ITEM
#define COPY_15(ITEM)		COPY_10(ITEM),COPY_5(ITEM)
#define COPY_20(ITEM) 		COPY_10(ITEM),COPY_10(ITEM)
#define COPY_30(ITEM) 		COPY_20(ITEM),COPY_10(ITEM)
#define BANDAGES_4_10_KIT 	COPY_10('ACE_fieldDressing'),COPY_10('ACE_elasticBandage'),COPY_10('ACE_quikclot'),COPY_10('ACE_packingBandage')
#define BASE_MEDICATIONS	COPY_10('ACE_apap'),COPY_15('ACE_fieldDressing'),COPY_2('ACE_tourniquet')
#define BASE_GEAR			"ACRE_PRC343","ACE_Flashlight_XL50","ACE_MapTools","ACE_EarPlugs","ItemcTabHCam",BASE_MEDICATIONS
#define CLS_LOADOUT 		COPY_30('ACE_apap'),COPY_30('ACE_fieldDressing'),COPY_4('ACE_bloodIV_250'),COPY_4('ACE_tourniquet'),COPY_2('ACE_epinephrine')
#define MEDIC_LOADOUT 		COPY_2('ACE_adenosine'),COPY_2('ACE_atropine'),COPY_5('ACE_epinephrine'),COPY_5('ACE_fentanyl'),COPY_1('ACE_naloxone'),COPY_10('ACE_apap'),COPY_2(BANDAGES_4_10_KIT),COPY_5('ACE_bloodIV'),COPY_5('ACE_bloodIV_500'),COPY_5('ACE_bloodIV_250'),"adv_aceCPR_AED"
#define MEDEVAC_LOADOUT 	MEDIC_LOADOUT

AF_fnc_loadoutUniformSet = {
	params ["_unit"];
	{
		_unit addItemToUniform _x;
	} forEach [BASE_GEAR];
};

AF_fnc_LoadoutMedicSet = {
	params ["_unit"];
	private _medicalLevel = _unit getVariable ["ACE_Medical_medicClass", getNumber (configFile >> "CfgVehicles" >> typeOf _unit >> "attendant")];
	if (_medicalLevel > 0) then {
		// Fancy variables to help medic role/team detemination
		private _groupLeader = leader group _unit;
		//private _ranks = ["PRIVATE", "CORPORAL", "SERGEANT", "LIEUTENANT", "CAPTAIN", "MAJOR", "COLONEL"];
		private _groupLeaderRank = _groupLeader get3DENAttribute "rank" select 0;
		private _groupLeaderMedicalLevel = _groupLeader getVariable ["ACE_Medical_medicClass", getNumber (configFile >> "CfgVehicles" >> typeOf _groupLeader >> "attendant")];
		// Check if unit has some fancy vest (then it is true)
		private _vest = vest _unit;
		private _vestCheck = (([
			"rhs_6b23_medic_fix",
			"rhs_6b23_digi_medic_fix",
			"rhsgref_6b23_khaki_medic_fix",
			"rhs_6b5_medic_khaki_fix",
			"rhs_6b5_medic_fix"
			] findIf {_x == _vest}) != -1);

		// Determine which loadout should be assigned
		// Default medic loadout
		private _Loadout = [CLS_LOADOUT];
		// Squad Medic
		if (_groupLeaderRank == "LIEUTENANT" || {['SL', typeOf _groupLeader] call BIS_fnc_inString}) then {
			_Loadout = [MEDIC_LOADOUT];
		};
		// Medevac medic
		if (_groupLeaderMedicalLevel > 0) then {
			_Loadout = [MEDEVAC_LOADOUT];
		};

		// Add items to backpack
		{
			if (_vestCheck && {{["blood", _x] call BIS_fnc_inString} || {_x == "ACE_surgicalKit"}}) then {
				_unit addItemToVest _x;
			} else {
				_unit addItemToBackpack _x;
			};
		} forEach _Loadout;
	};
};