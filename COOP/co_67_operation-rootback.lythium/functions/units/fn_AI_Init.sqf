// Funkcje odpalane dla każdej postawionej jednostki AI z 3DEN / zeusa

_unit = _this select 0;
if !(isPlayer _unit) then
{
[_unit] call AF_fnc_eventHandlers;
[_unit] call AF_fnc_skill;
if (AF_Ai_tracers) then {[{[_unit] call M_fnc_magscript}] call CBA_fnc_execNextFrame};
};