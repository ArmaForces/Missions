AF_InstantRespawn = {
	if (!isDedicated && !alive player) then
	{
		setPlayerRespawnTime 1;
		[format ["%1 Respawn",profileName]] remoteExec ["systemChat",remoteExecutedOwner,false];
	};
};
if !(isClass(configFile >> "cfgPatches" >> "achilles_data_f_achilles")) exitWith {};
["!ArmaForces", "Instant respawn", 
{
	remoteExec ["AF_InstantRespawn",0];
	["Cyk, respawn poleciał"] call Ares_fnc_ShowZeusMessage;
}] call Ares_fnc_RegisterCustomModule;