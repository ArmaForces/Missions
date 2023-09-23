#include "..\script_component.hpp"
/*
 * Author: 3Mydlo3
 *
 * Checks if unit is medical service.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Is a medical service unit <BOOL>
 *
 * Public: No
 */

#define VANILLA_MEDIC "C_Man_Paramedic_01_F"
#define CHERNO_MEDIC "CUP_C_C_Doctor_01"

params ["_unit"];

private _unitType = typeOf _unit;

_unitType isEqualTo VANILLA_MEDIC || {_unitType isEqualTo CHERNO_MEDIC}
