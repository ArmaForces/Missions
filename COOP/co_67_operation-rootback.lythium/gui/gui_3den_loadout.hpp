class AF_dlg_3den_loadout
{
	idd=9970;
	movingenable=true;
	
	class controls
	{
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Madin, v1.063, #Pydima)
////////////////////////////////////////////////////////
class RscPicture_1200: IGUIBack
{
	idc = 1200;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	x = 0.345312 * safezoneW + safezoneX;
	y = 0.621 * safezoneH + safezoneY;
	w = 0.309375 * safezoneW;
	h = 0.33 * safezoneH;
	colorBackground[] = {0.25,0.25,0.25,0.9};
};
class RscPicture_1201: IGUIBack
{
	idc = 1201;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	x = 0.45875 * safezoneW + safezoneX;
	y = 0.643 * safezoneH + safezoneY;
	w = 0.185625 * safezoneW;
	h = 0.286 * safezoneH;
	colorBackground[] = {0.15,0.15,0.15,0.75};
};
class RscFrame_1800: RscFrame
{
	idc = 1800;
	x = 0.345312 * safezoneW + safezoneX;
	y = 0.621 * safezoneH + safezoneY;
	w = 0.309375 * safezoneW;
	h = 0.33 * safezoneH;
};
class RscListbox_1500: RscListbox
{
	idc = 1500;
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.643 * safezoneH + safezoneY;
	w = 0.0928125 * safezoneW;
	h = 0.198 * safezoneH;
	sizeEx = 0.0375;
	onLBSelChanged = "[lbCurSel 1500] call AF_fnc_loadoutSelector";
	class ScrollBar;
};
class RscListbox_1501: RscListbox
{
	idc = 1501;
	type = CT_LISTNBOX;
	colorBackground[] = {0.5, 0.5, 0.5, 0.5}; 
	drawSideArrows = 0; 
	shadow = 1;
	idcLeft = -1; 
	idcRight = -1; 	
	columns[] = {0.0, 0.7};
	x = 0.45875 * safezoneW + safezoneX;
	y = 0.643 * safezoneH + safezoneY;
	w = 0.185625 * safezoneW;
	h = 0.286 * safezoneH;
	sizeEx = 0.0375;
	onLBSelChanged = "[lbCurSel 1501] call AF_fnc_loadoutSet";
};
class RscButton_1600: RscButton
{
	idc = 1600;
	text = $STR_ArmaForces_Preset_Dialog_Close;
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.863 * safezoneH + safezoneY;
	w = 0.0928125 * safezoneW;
	h = 0.066 * safezoneH;
	sizeEx = 0.0375;
	action = "closeDialog 0";
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
	};
}