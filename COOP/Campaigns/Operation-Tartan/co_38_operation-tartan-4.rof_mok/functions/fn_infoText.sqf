#include "script_component.hpp"
/*
 * Author: 3Mydlo3, Karel Moricky
 *
 * Fancy multi-line text in bottom right corner
 *
 * Based on infoText.sqf by Karel Moricky
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

// TODO: Clean that mess at some point

// NO TABS, NO
#define SPACE_ASCII 32
#define AF_INTROTEXT_LAYER QGVAR(InfoTextLayer)

private _fnc_createControl = {
	// Register control
	([AF_INTROTEXT_LAYER] call bis_fnc_rscLayer) cutRsc ["rscInfoTextEdit", "plain"];

	disableSerialization;
	private _display = uiNamespace getVariable "AFP_Scripts_InfoText";
	_display displayctrl 310169
};

fnc_destroyControl = {
	// Remove control
	([AF_INTROTEXT_LAYER] call bis_fnc_rscLayer) cutText ["", "plain"];

    disableSerialization;
    private _display = uiNamespace getVariable "AFP_Scripts_InfoText";
	_display closeDisplay 1;
};

fnc_renderMessageLines = {
	params ["_textLines"];

	_textLines
		apply {
			if (_x isEqualType {}) then {
				call _x
			} else {
				_x
			}
		}
};

fnc_refreshMessage = {
	params ["_textControl", "_textLines", "_unhiddenCharacters"];

	private _fullTextLines = [_textLines] call fnc_renderMessageLines;

	private _originalUnhiddenCharacters = _unhiddenCharacters;
	private _leftToUnhide = _unhiddenCharacters;
	private _characterWasSpace = false;
	private _lineEndReached = false;

	TRACE_2("Text lines: %2 | Unhidden Characters: %1", _unhiddenCharacters, str _fullTextLines);

	private _refreshedText = _fullTextLines
		apply {
			TRACE_2("Line %1, left to unhide = %2", _x, _leftToUnhide);

			// Necessary toArray before count due to ąęół etc.
			private _lineArray = toArray _x;
			private _lineLength = count _lineArray;
			if (_leftToUnhide isEqualTo 0) then {
				// Empty line
				TRACE_1("Line is empty","");
				""
			} else {
				if (_lineLength > _leftToUnhide) then {
					// Unhide part of the line
					private _lastNotHiddenCharacter = _leftToUnhide - 1;
					_leftToUnhide = 0;

					TRACE_2("Found partially unhidden line with %1 length. Last not hidden character: %2", _lineLength, _lastNotHiddenCharacter);

					private _anyMoreNonSpaceCharactersToUnhideInLine = false;
					private _spaceCharactersRemaining = 0;
					// Search for next character to unhide
					for "_i" from _lastNotHiddenCharacter to (_lineLength - 1) do {
						private _character = _lineArray select _i;
						TRACE_2("Current character _i = %1 _character = %2", _i, _character);
						private _isNotSpaceCharacter = _character isNotEqualTo SPACE_ASCII;

						if (_leftToUnhide isNotEqualTo 0) then {
							TRACE_1("Yet to find non-space character","");
							// Unhide found character
							if (_isNotSpaceCharacter) then {
								TRACE_2("Unhiding character %1 => %2", _i, toString [_character]);
							} else {
								_characterWasSpace = true;
							};
							// Always increase _unhiddenCharacters by one, even if it's just space to avoid the need to ignore spaces in calculations and continue
							_leftToUnhide = 0;
							_unhiddenCharacters = _unhiddenCharacters + 1;
						} else {
							// Hide character if it's not space
							if (_isNotSpaceCharacter) then {
								TRACE_2("Hiding character %1 => %2", _i, toString [_character]);
								_lineArray set [_i, SPACE_ASCII];
								_anyMoreNonSpaceCharactersToUnhideInLine = true;
							} else {
								// Count spaces in case there are no non-space characters remaining in line
								_spaceCharactersRemaining = _spaceCharactersRemaining + 1;
							};
						};
					};
					_leftToUnhide = 0;

					// Handle only space characters remaining in line
					if (!_anyMoreNonSpaceCharactersToUnhideInLine) then {
						_lineEndReached = true;
						_unhiddenCharacters = _unhiddenCharacters + _spaceCharactersRemaining;
					};

					toString _lineArray
				} else {
					_leftToUnhide = _leftToUnhide - _lineLength;
					TRACE_2("Found unhidden line with %1 length, %2 characters left to unhide", _lineLength, _leftToUnhide);

					// Check if character was unhidden as a part of full line unhide
					if (_leftToUnhide isEqualTo 0) then {
						_lineEndReached = true;
						_unhiddenCharacters = _unhiddenCharacters + 1;
					};
					_x
				};
			};
		};

	private _refreshedTextWithLineBreaks = _refreshedText
		apply {_x insert [-1, "\n"]};
	_textControl ctrlsettext str composeText _refreshedTextWithLineBreaks;
	_textControl ctrlcommit 0.01;
};

fnc_hideMessageLoop = {
	params [
		"_textControl",
		"_textLines",
		"_unhiddenCharacters",
		["_fadeDelay", 0.025],
		["_fadePlaySound", ""]];

	private _fullTextLines = [_textLines] call fnc_renderMessageLines;

	private _originalUnhiddenCharacters = _unhiddenCharacters;
	private _leftToHide = _unhiddenCharacters - 1;
	private _lineEndReached = false;
	private _messageEndReached = false;

	TRACE_2("Text lines: %2 | Unhidden Characters: %1", _unhiddenCharacters, str _fullTextLines);

	private _partiallyHiddenText = _fullTextLines
		apply {
			TRACE_2("Line %1, left to unhide = %2",_x,_leftToHide);

			// Necessary toArray before count due to ąęół etc.
			private _lineArray = toArray _x;
			private _lineLength = count _lineArray;
			if (_leftToHide isEqualTo 0) then {
				// Empty line
				TRACE_1("Line is empty","");
				""
			} else {
				if (_lineLength > _leftToHide) then {
					// Unhide part of the line
					private _lastNotHiddenCharacter = _leftToHide;
					_leftToHide = 1;

					TRACE_2("Found partially unhidden line with %1 length. Last not hidden character: %2", _lineLength, _lastNotHiddenCharacter);

					private _anyMoreNonSpaceCharactersToUnhideInLine = false;
					private _spaceCharactersRemaining = 0;
					// Search for next character to unhide
					for "_i" from (_lineLength - 1) to  _lastNotHiddenCharacter step -1 do {
						private _character = _lineArray select _i;
						TRACE_2("Current character _i = %1 _character = %2",_i,_character);
						private _isNotSpaceCharacter = _character isNotEqualTo SPACE_ASCII;

						if (_leftToHide isNotEqualTo 0) then {
							TRACE_1("Yet to find non-space character","");
							// Unhide found character
							if (_isNotSpaceCharacter) then {
								TRACE_2("Hiding character %1 => %2", _i, toString [_character]);
								_lineArray set [_i, SPACE_ASCII];
								_leftToHide = 0;
							};
							// Always decrease _unhiddenCharacters by one, even if it's just space to avoid the need to ignore spaces in calculations and continue
							_unhiddenCharacters = _unhiddenCharacters - 1;
						} else {
							// Hide character if it's not space
							if (_isNotSpaceCharacter) then {
								TRACE_2("Hiding character %1 => %2", _i, toString [_character]);
								_lineArray set [_i, SPACE_ASCII];
								_anyMoreNonSpaceCharactersToUnhideInLine = true;
							} else {
								// Count spaces in case there are no non-space characters remaining in line
								_spaceCharactersRemaining = _spaceCharactersRemaining + 1;
							};
						};
					};
					_leftToHide = 0;

					// Handle only space characters remaining in line
					if (!_anyMoreNonSpaceCharactersToUnhideInLine) then {
						_lineEndReached = true;
						_unhiddenCharacters = _unhiddenCharacters - _spaceCharactersRemaining;
					};

					toString _lineArray
				} else {
					_leftToHide = _leftToHide - _lineLength;
					TRACE_2("Found unhidden line with %1 length, %2 characters left to unhide",_lineLength,_leftToUnhide);

					// Check if character was unhidden as a part of full line unhide
					if (_leftToHide isEqualTo 0) then {
						_lineEndReached = true;
						_unhiddenCharacters = _unhiddenCharacters - 1;
					};
					_x
				};
			};
		};

    // Not sure why, but it hides all characters and doesn't terminate, therefore additional check if number had changed
	private _messageEndReached = _unhiddenCharacters isEqualTo 0 || {_unhiddenCharacters isEqualTo _originalUnhiddenCharacters};

	private _partiallyHiddenTextWithLineBreaks = _partiallyHiddenText
		apply {_x insert [-1, "\n"]};
	_textControl ctrlsettext str composeText _partiallyHiddenTextWithLineBreaks;
	_textControl ctrlcommit 0.01;

	if (_messageEndReached) exitWith {
		INFO("Message fully faded");
		call fnc_destroyControl;
	};

	if (_fadePlaySound isNotEqualTo "") then { playSound _fadePlaySound };

	_this set [2, _unhiddenCharacters];
	[fnc_hideMessageLoop, _this, _fadeDelay] call CBA_fnc_waitAndExecute;
};

private _fnc_unhideMessageLoop = {
	params [
		"_textControl",
		"_textLines",
		"_unhiddenCharacters",
		"_onUnhideMessage",
		"_onFullyVisible",
		["_fullyVisibleSeconds", 5],
		["_characterUnhideDelay", 0.1],
		["_lineUnhideDelay", 0.5],
		["_fadeDelay", 0.025],
		["_unhidePlaySound", "ReadoutClick"],
		["_fadePlaySound", ""]];

	private _fullTextLines = [_textLines] call fnc_renderMessageLines;

	private _originalUnhiddenCharacters = _unhiddenCharacters;
	private _leftToUnhide = _unhiddenCharacters + 1;
	private _characterWasSpace = false;
	private _lineEndReached = false;

	TRACE_2("Text lines: %2 | Unhidden Characters: %1", _unhiddenCharacters, str _fullTextLines);

	private _partiallyHiddenText = _fullTextLines
		apply {
			TRACE_2("Line %1, left to unhide = %2", _x, _leftToUnhide);

			// Necessary toArray before count due to ąęół etc.
			private _lineArray = toArray _x;
			private _lineLength = count _lineArray;
			if (_leftToUnhide isEqualTo 0) then {
				// Empty line
				TRACE_1("Line is empty","");
				""
			} else {
				if (_lineLength > _leftToUnhide) then {
					// Unhide part of the line
					private _lastNotHiddenCharacter = _leftToUnhide - 1;
					_leftToUnhide = 1;

					TRACE_2("Found partially unhidden line with %1 length. Last not hidden character: %2", _lineLength, _lastNotHiddenCharacter);

					private _anyMoreNonSpaceCharactersToUnhideInLine = false;
					private _spaceCharactersRemaining = 0;
					// Search for next character to unhide
					for "_i" from _lastNotHiddenCharacter to (_lineLength - 1) do {
						private _character = _lineArray select _i;
						TRACE_2("Current character _i = %1 _character = %2", _i, _character);
						private _isNotSpaceCharacter = _character isNotEqualTo SPACE_ASCII;

						if (_leftToUnhide isNotEqualTo 0) then {
							TRACE_1("Yet to find non-space character","");
							// Unhide found character
							if (_isNotSpaceCharacter) then {
								TRACE_2("Unhiding character %1 => %2", _i, toString [_character]);
							} else {
								_characterWasSpace = true;
							};
							// Always increase _unhiddenCharacters by one, even if it's just space to avoid the need to ignore spaces in calculations and continue
							_leftToUnhide = 0;
							_unhiddenCharacters = _unhiddenCharacters + 1;
						} else {
							// Hide character if it's not space
							if (_isNotSpaceCharacter) then {
								TRACE_2("Hiding character %1 => %2", _i, toString [_character]);
								_lineArray set [_i, SPACE_ASCII];
								_anyMoreNonSpaceCharactersToUnhideInLine = true;
							} else {
								// Count spaces in case there are no non-space characters remaining in line
								_spaceCharactersRemaining = _spaceCharactersRemaining + 1;
							};
						};
					};
					_leftToUnhide = 0;

					// Handle only space characters remaining in line
					if (!_anyMoreNonSpaceCharactersToUnhideInLine) then {
						_lineEndReached = true;
						_unhiddenCharacters = _unhiddenCharacters + _spaceCharactersRemaining;
					};

					toString _lineArray
				} else {
					_leftToUnhide = _leftToUnhide - _lineLength;
					TRACE_2("Found unhidden line with %1 length, %2 characters left to unhide", _lineLength, _leftToUnhide);

					// Check if character was unhidden as a part of full line unhide
					if (_leftToUnhide isEqualTo 0) then {
						_lineEndReached = true;
						_unhiddenCharacters = _unhiddenCharacters + 1;
					};
					_x
				};
			};
		};

	private _messageEndReached = _originalUnhiddenCharacters isEqualTo _unhiddenCharacters;

	private _partiallyHiddenTextWithLineBreaks = _partiallyHiddenText
		apply {_x insert [-1, "\n"]};
	_textControl ctrlsettext str composeText _partiallyHiddenTextWithLineBreaks;
	_textControl ctrlcommit 0.01;

	if (_messageEndReached) exitWith {

		INFO("Message fully visible");
		[
			_textControl,
			_textLines,
			_unhiddenCharacters,
			_fullyVisibleSeconds,
			_fadeDelay,
			_fadePlaySound
		] call _onFullyVisible;
	};

	if (_unhidePlaySound isNotEqualTo "" && {!_characterWasSpace}) then { playSound _unhidePlaySound };

	_this set [2, _unhiddenCharacters];

	private _delay = if (_lineEndReached) then {
		_lineUnhideDelay
	} else {
		if (_characterWasSpace) then {
			_characterUnhideDelay/2
		} else {
			_characterUnhideDelay
		}
	};

	[_onUnhideMessage, _this, _delay] call CBA_fnc_waitAndExecute;
};

private _fnc_onFullyVisible = {
	params [
		"_textControl",
		"_textLines",
		"_unhiddenCharacters",
		["_fullyVisibleSeconds", 5],
		["_fadeDelay", 0.025],
		["_fadePlaySound", ""]];

	INFO_1("Message will be fully visible for %1 seconds", _fullyVisibleSeconds);

	for "_delay" from 0.1 to _fullyVisibleSeconds - 0.1 step 0.1 do {
		[fnc_refreshMessage, [_textControl, _textLines, _unhiddenCharacters], _delay]  call CBA_fnc_waitAndExecute;
	};

	[fnc_hideMessageLoop, [
		_textControl,
		_textLines,
		_unhiddenCharacters,
		_fadeDelay,
		_fadePlaySound
	], _fullyVisibleSeconds] call CBA_fnc_waitAndExecute;
};

private _textControl = call _fnc_createControl;
private _textLines = _this;
[
	_textControl,
	_textLines,
	0,
	_fnc_unhideMessageLoop,
	_fnc_onFullyVisible
] call _fnc_unhideMessageLoop;
