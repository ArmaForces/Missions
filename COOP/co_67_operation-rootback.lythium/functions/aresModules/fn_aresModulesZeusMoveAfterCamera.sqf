//Moduł do włączania i wyłączania (toggle) poruszania się jednostki Zeusa za kamerą Curatora. Umożliwia to, na przykład, szybkie
//podsłuchanie rozmów BPP bez konieczności używania teleportu. Na starcie misji jest wyłączony.

if !(isClass (configFile >> "cfgPatches" >> "achilles_data_f_achilles") || !hasInterface) exitWith {};

zeus_move_after_camera_enabled = false;

["!ArmaForces", "Zeus - move after camera",
{
	[] spawn {
		zeus_move_after_camera_enabled = !zeus_move_after_camera_enabled;

		if (!zeus_move_after_camera_enabled) exitWith {};

		player allowDamage false;

		private _wasSimulated = simulationEnabled player;
		player enableSimulation false;

		private _wasHidden = isObjectHidden player;
		player hideObjectGlobal true;

		{player disableCollisionWith _x} forEach allPlayers;

		systemchat "Zeus podąża za kamerą";

		while {zeus_move_after_camera_enabled} do {
			if (!isNull curatorCamera) then {
				player setPos (getPos curatorCamera);
			};
			sleep 1;
		};

		// Restore previous simulation and visibility
		player enableSimulation _wasSimulated;
		player hideObjectGlobal _wasHidden;
		{player enableCollisionWith _x} forEach allPlayers;

		systemchat "Zeus już nie będzie podązał za kamerą";
	};
}] call Ares_fnc_RegisterCustomModule;
