_trigger = _this select 0;
sleep 1;
_units = allUnits inAreaArray _trigger;
{
	hideObjectGlobal _x;
	_x enableSimulationGlobal false;
}forEach _units;
waitUntil {sleep 2; (allPlayers findif {_x inArea _trigger}) != -1};
{
	_x hideObjectGlobal false;
	_x enableSimulationGlobal true;
}forEach _units;