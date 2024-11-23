/*
Adds teleport actions to object.

Params:
0: <OBJECT> - object which has teleport action assigned

Return value:
None

Example:
[this] spawn AL_fnc_teleporterAddDestination;

Locality:
Runs local. Effect local.
*/

params ["_teleporter"];
{
	private _destination_name = _x select 1;
	private _destination_object = _x select 0;
	if (_destination_object != _teleporter) then {
		_teleporter addAction [_destination_name, {
			private _destination_object = _this select 3;
			player setPos (getPos _destination_object);
		}, _destination_object];
	};
} forEach AL_Teleports;