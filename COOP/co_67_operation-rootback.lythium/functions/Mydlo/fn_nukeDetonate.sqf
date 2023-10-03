// Check if bomb is still around the same area
if ((getPos nuclear_device) inArea "sys_marker_nukeInitial") then {
	["t_nuke","FAILED"] call BIS_fnc_taskSetState;
} else {
	["t_nuke","CANCELED"] call BIS_fnc_taskSetState;
};
// Detonate nuclear bomb
[[(getPos nuclear_device)], "Mydlo\nuke5kt.sqf"] remoteExec ["execVM", 0];
deleteVehicle nuclear_device;