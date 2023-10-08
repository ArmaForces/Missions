_handle = ppEffectCreate ["ColorCorrections", 1500];
_handle ppEffectEnable true;
_handle ppEffectAdjust [0, 1, 0, [0, 0, 0, 0], [1, 1, 1, 1], [0.299, 0.587, 0.114, 0],[-1, -1, 0, 0, 0, 0, 0]];
_handle ppEffectCommit 5;
waitUntil {ppEffectCommitted _handle};
_handle ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [1, 1, 1, 1], [0.299, 0.587, 0.114, 0],[-1, -1, 0, 0, 0, 0, 0]];
_handle ppEffectCommit 5;

["Initialize", [player, [], false, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator;
Madin_cache = false;

waitUntil {ppEffectCommitted _handle};
_handle ppEffectEnable false;
ppEffectDestroy _handle;