markers = true;
markers_refresh_rate = 5;
if (side player == AF_coop_side) then {
	while {markers} do {
		_Markers=[];
		{
			if (side _x == AF_coop_side) then {
				_name = format["gracz%1",(random 999)];
				_marker = createMarkerlocal [_name, getpos _x];
				_marker setmarkertypelocal "mil_dot";
				if (vehicle _x == _x) then {
					_marker setMarkerSizelocal [0.5, 0.5];
				} else {
					_marker setMarkerSizelocal [0.75, 0.75];
				};
				_marker setmarkercolorlocal "ColorWEST";
				_Markers pushback [_marker,_x];
				if (_x == player) then {
					_marker setmarkercolorlocal "ColorYellow";
				} else {
//					_unconscious = _x getVariable "ACE_isUnconscious";
//					if (_unconscious) then {
//						_marker setmarkercolorlocal "ColorOrange";
//					} else {
					if (group _x == group player) then {
						_marker setmarkercolorlocal "ColorGreen";
					};
				};
			};
		} foreach AllPlayers;
		
		sleep markers_refresh_rate;
		
		{
			deletemarkerlocal (_x select 0);
		} foreach _Markers;
	};
};