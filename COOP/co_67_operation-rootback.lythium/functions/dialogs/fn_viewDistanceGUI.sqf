/*
    AF_fnc_viewDistanceGUI

    Description:
        Konsola do zmiany odległości widzenia
		
*/
disableSerialization;
createDialog "AF_dlg_viewDistance";
[{!isNull (findDisplay 10)},{
    ctrlSetText [311, str viewdistance];
}, [], -1] call CBA_fnc_waitUntilAndExecute;
