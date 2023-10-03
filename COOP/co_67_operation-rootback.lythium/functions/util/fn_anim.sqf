/*
    AF_fnc_anim

    Description:
        synchronizacja animacji w MP

    Parameter(s):
        _unit - jednostka <OBJECT>
		_anim - nazwa animacji <STRING>

    Returns:
        Was script initialized [BOOL]

*/
if (isDedicated) exitwith {};
(_this select 0) switchMove (_this select 1);
true