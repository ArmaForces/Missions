/*
    AF_fnc_setViewDistance

    Description:
        Funckcja do zmiany odległości widzenia
		
*/

params ["_dist"];
private _dist2 = _dist * 0.7;
if (_dist > minviewdistance) then {
	if (_dist < maxviewdistance) then {
			setViewDistance _dist;
		if (_dist2 < minviewdistance) then {
			setobjectviewdistance minviewdistance;
		} else {
			setobjectviewdistance _dist2;
		};
	} else {
		setViewDistance maxviewdistance;
		setobjectviewdistance maxviewdistance * 0.7;
	};
} else {
	setViewDistance minviewdistance;
	setobjectviewdistance minviewdistance;
};
ctrlSetText [311, str viewdistance];