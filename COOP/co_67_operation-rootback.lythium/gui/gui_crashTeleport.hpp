class AF_dlg_crashTeleport {
	idd = 11;
	movingenable = false;

	class controls {
		class RscFrame_1058: RscFrame {
			idc = 1800;
			x = 0.402031 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.195937 * safezoneW;
			h = 0.165 * safezoneH;
		};
		class RscText_1059: RscText {
			idc = 1000;
			text = $STR_ArmaForces_Preset_Dialog_crashTeleport_Ask;
			x = 0.412344 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.180469 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class RscButton_1060: RscButton {
			idc = 1600;
			text = $STR_ArmaForces_Preset_Dialog_crashTeleport_Agree;
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.066 * safezoneH;
			action = "[player] remoteExec ['AF_fnc_crashTeleportServer',2]; systemchat localize ""STR_ArmaForces_Preset_Dialog_crashTeleport_AgreeConfirmation""'.'; closeDialog 0";
		};
		class RscButton_1061: RscButton {
			idc = 1601;
			text = $STR_ArmaForces_Preset_Dialog_crashTeleport_Reject;
			x = 0.525781 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.066 * safezoneH;
			action = "systemchat localize ""STR_ArmaForces_Preset_Dialog_crashTeleport_RejectConfirmation""; closeDialog 0";
		};
	};
};