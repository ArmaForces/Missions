/*
    AF_fnc_groupRenameGUI

    Description:
        Konsola zulu do zmiany nazw grup

*/
disableSerialization;
createDialog "AF_dlg_groupRename";
[{!isNull (findDisplay 9991)},{
    call AF_fnc_groupRenameList;
}, [], -1] call CBA_fnc_waitUntilAndExecute;