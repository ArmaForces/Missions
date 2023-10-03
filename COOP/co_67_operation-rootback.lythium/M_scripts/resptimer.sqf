if (isServer) then {
resptime = 90;
_timer = 1;
while {resptime > 0} do {
_text = format ["czas do końca: %1 minut", resptime];  
_text remoteExec ["systemChat"];
resptime = resptime - _timer;
uisleep (_timer * 90);
};
"kiedyś to były czasy, teraz to nie ma czasu." remoteExec ["systemChat"];
[["\n\n\n\n\nrespawn wyłączony \n\nGG WP EZ", "PLAIN", 1]] remoteExec ["titleText",0];
[AF_coop_side, -5000] call BIS_fnc_respawnTickets;
};