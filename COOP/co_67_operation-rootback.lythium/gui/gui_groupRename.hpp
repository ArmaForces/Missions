class GVAR(dlg_groupRename) {
	idd = 9991;
	movingenable = false;

	class controls {
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Martin, v1.063, #Nodywu)
		////////////////////////////////////////////////////////
		class GridB3: RscFrame {
			idc = 121;
			x = 0.296635 * safezoneW + safezoneX;
			y = 0.219938 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class Closebutton3: RscButton {
			idc = 122;
			text = $STR_ArmaForces_Preset_Dialog_Close;
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.154 * safezoneH;
			action = "closeDialog 0";
		};
		class groupList_1: RscListbox {
			idc = 123;
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.190781 * safezoneW;
			h = 0.33 * safezoneH;
			onLBSelChanged = QUOTE([lbCurSel 123] call FUNC(groupRenameList));
		};
		class b_tyegrouptext1: RscEdit {
			idc = 124;
			x = 0.309755 * safezoneW + safezoneX;
			y = 0.598022 * safezoneH + safezoneY;
			w = 0.190245 * safezoneW;
			h = 0.0560125 * safezoneH;
		};
		class RscButton_1600: RscButton {
			idc = 125;
			text = $STR_ArmaForces_Preset_Dialog_GroupRename_Rename;
			x = 0.329436 * safezoneW + safezoneX;
			y = 0.668037 * safezoneH + safezoneY;
			w = 0.144324 * safezoneW;
			h = 0.0840187 * safezoneH;
			action = QUOTE((wgroups select (lbCurSel 123)) setGroupIdGlobal [ctrlText 124];[lbCurSel 123] call FUNC(groupRenameList););
			soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect", 0.09, 1};
		};
		class listplayername: RscListbox {
			idc = 126;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.190781 * safezoneW;
			h = 0.33 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};
