player addAction ["<t color='#FF8000'>Spawn Quad</t>", {
	//if (vehicle player == player && !(player inArea nospawn1) && !(player inArea nospawn2)) then {
		private _veh = createVehicle ["B_Quadbike_01_F", getPos player, [], 0, "CAN_COLLIDE"];
		player moveInDriver _veh;
		_veh setDir getDir player;
		_veh engineOn true;
		clearItemCargoGlobal _veh;
		_veh addEventHandler ["GetOut", {deleteVehicle (_this select 0)}];
	//};
}, {}, 0, false, true, "", "true", 5];