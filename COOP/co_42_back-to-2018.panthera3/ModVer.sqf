{
	if (!isClass(configFile >> "CfgPatches" >> _x))then
	{
		_text = format["NIE wykryto moda %1. Załaduj mod i wróć na serwer.", _x];
		systemChat _text;
		titleText [_text, "PLAIN"];
		[]spawn
		{
			waitUntil {alive player && time > 0};
			sleep 0.1;
			player setDamage 1;
			setPlayerRespawnTime 1000000;
		};
	};
}forEach ["SMA_Weapons","Zab_splendid_smoke","awm_main"];