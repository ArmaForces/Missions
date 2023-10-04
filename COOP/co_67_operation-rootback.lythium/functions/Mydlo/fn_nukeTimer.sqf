private _msg = format ["%1", (NukeTimeRemaining/3600) call BIS_fnc_timeToString];
[_msg, "PLAIN", 0.2] remoteExec ["titleText", remoteExecutedOwner];
