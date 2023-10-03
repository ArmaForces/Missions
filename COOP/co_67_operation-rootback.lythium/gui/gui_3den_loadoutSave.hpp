class AF_dlg_3den_loadoutSave {
	idd = 9960;
	movingenable = true;
	
	class controls {
		controls[] = {
			RscFrame_1800,
			RscButton_1600,
			RscEdit_1400,
			RscEdit_1401,
			RscButton_1601,
			RscText_1000
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Madin, v1.063, #Detedo)
		////////////////////////////////////////////////////////
		class RscPicture_1200: IGUIBack {
			idc = 1200;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.335 * safezoneW + safezoneX;
			y = 0.689 * safezoneH + safezoneY;
			w = 0.33 * safezoneW;
			h = 0.264 * safezoneH;
			colorBackground[] = {0.25,0.25,0.25,0.9};
		};
		class RscFrame_1800: RscFrame {
			idc = 1800;

			x = 0.335 * safezoneW + safezoneX;
			y = 0.689 * safezoneH + safezoneY;
			w = 0.33 * safezoneW;
			h = 0.264 * safezoneH;
		};
		class RscButton_1600: RscButton {
			idc = 1600;
			action = "closeDialog 0";

			text = $STR_ArmaForces_Preset_Dialog_Close;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.865 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.066 * safezoneH;
		};
		class RscEdit_1400: RscEdit {
			idc = 1400;
			text = $STR_ArmaForces_Preset_Dialog_3den_loadoutSave_loadoutGroupName;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.777 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class RscEdit_1401: RscEdit {
			idc = 1401;
			text = $STR_ArmaForces_Preset_Dialog_3den_loadoutSave_loadoutName;
			x = 0.479375 * safezoneW + safezoneX;
			y = 0.777 * safezoneH + safezoneY;
			w = 0.175313 * safezoneW;
			h = 0.044 * safezoneH;

		};
		class RscButton_1601: RscButton {
			idc = 1601;
			text = $STR_ArmaForces_Preset_Dialog_3den_loadoutSave_copyToClipboardAndSave;
			x = 0.479376 * safezoneW + safezoneX;
			y = 0.865 * safezoneH + safezoneY;
			w = 0.175313 * safezoneW;
			h = 0.066 * safezoneH;
			action = "[parsetext (ctrlText 1400), parsetext (ctrlText 1401)] call AF_fnc_3denSavePreset; [localize ""STR_ArmaForces_Preset_Dialog_3den_loadoutSave_copiedToClipboard""] call BIS_fnc_3DENNotification; closeDialog 0";
		};
		class RscText_1000: RscText {
			idc = 1000;
			text = $STR_ArmaForces_Preset_Dialog_3den_loadoutSave_title;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.711 * safezoneH + safezoneY;
			w = 0.304219 * safezoneW;
			h = 0.044 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};