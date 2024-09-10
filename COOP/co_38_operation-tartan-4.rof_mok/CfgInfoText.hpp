class RscTitles {
    import RscInfoText from RscTitles;
    class RscInfoTextEdit : RscInfoText {
        idd = 310069;
        onLoad = "uinamespace setvariable ['AFP_Scripts_InfoText', _this select 0]";
        onUnload = "uinamespace setvariable ['AFP_Scripts_InfoText', nil]";
        class Controls :Controls {
            class InfoText : InfoText {
                colorShadow[] = {0, 1, 0, 1};
                colorText[] = {0, 0.7, 0, 0.6};
                font = "EtelkaMonospacePro";
                idc = 310169;
                sizeEx = 0.045;
                style = "0x01 + 0x10 + 0x200";
                h = "(8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
                w = "(35 * ( ((safezoneW / safezoneH) min 1.2) / 40))";
                x = "(safezoneX + safezoneW - 36 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
                y = "(safezoneY + safezoneH - 14 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
            };
        };
    };
};
