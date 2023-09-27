#include "script_component.hpp"
/*
 * Author: Madin
 * Konsola zulu do zmiany nazw grup
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

disableSerialization;
waitUntil {!isNull (findDisplay 9991);};
lbClear 123;
lbClear 126;
private _ctrl1 = (findDisplay 9991) displayCtrl 123;
private _ctrl2 = (findDisplay 9991) displayCtrl 126;

// Utwórz listę grup graczy
wgroups = [];
{
	wgroups pushBackUnique (group _x);
} forEach allPlayers;

// Wyświetl odpowiednie nazwy grup na liście
{
	_x;
	private _grname = groupId _x;
	_ctrl1 lbAdd _grname;
} forEach wgroups;

if (!isnil "_this" && {(count _this) == 1}) then {
	private _selector = _this select 0;
	if (_selector != -1) then {
		// Wyświetl listę graczy w grupie
		private _units = units (wgroups select _selector);
		{
			private _name = name _x;
			_ctrl2 lbAdd _name;
		} forEach _units;
	};
	_selector = nil;
};
