#include "script_component.hpp"

private _vehicle = if (vehicle player isEqualTo player) then { objNull } else { vehicle player };

["MDL_playerKilled", [getPlayerUID player, player, _vehicle]] call CBA_fnc_serverEvent;
