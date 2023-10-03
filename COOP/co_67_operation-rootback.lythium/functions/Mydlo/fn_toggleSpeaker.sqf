params["_radioID",["_change", false], ["_state", false]];

titleText [format["Radio: %1", ((missionNamespace getVariable "acre_sys_data_radioScratchData") getVariable _radioID) getVariable "opt_radio_speaker"], "PLAIN DOWN", 1];
if (!_change) exitWith {};
if (_state) then {
	_state = "ON";
} else {
	_state = "OFF";
};
[_radioID, "opt_radio_speaker", _state] call acre_sys_data_fnc_setScratchData;
titleText [format["Radio: %1", ((missionNamespace getVariable "acre_sys_data_radioScratchData") getVariable _radioID) getVariable "opt_radio_speaker"], "PLAIN DOWN", 1];