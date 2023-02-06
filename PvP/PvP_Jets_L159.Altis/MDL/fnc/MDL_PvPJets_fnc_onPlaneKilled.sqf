
params ["_plane", "_killer"];

private _pilot = _plane getVariable ["MDL_PVP_pilot", driver _plane];
private _killer = _plane getVariable ["MDL_PVP_killer", _killer];

diag_log text format ["[PVP] INFO: onPlaneKilled - pilot: %1, by: %2", name _pilot, name _killer];

{
    _x setDamage 1;
} forEach crew _plane;

[_plane getVariable "MDL_PVPJets_side", -10] call BIS_fnc_respawnTickets;

_plane spawn {sleep 45; deleteVehicle _this};
