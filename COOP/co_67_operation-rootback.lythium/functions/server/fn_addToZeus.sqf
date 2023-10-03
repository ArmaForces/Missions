/*
	AF_fnc_addToZeus

	Description:
		Dodanie wszystkich jednostek oraz pojazdów do zeusa

	Parameter(s):
		NOTHING

	Returns:
		NOTHING
*/

if (!isServer) exitWith {false};

{
	_unit = _x; 
	{
		_x addCuratorEditableObjects [[_unit], true];
	} forEach allCurators; 
} forEach (allUnits + (vehicles select {_x isKindOf "AllVehicles"}));