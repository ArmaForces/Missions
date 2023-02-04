class view_distance_settings
{
	idd=10;
	movingenable=false;
	
	class controls
	{
	////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Madin, v1.063, #Migofo)
////////////////////////////////////////////////////////

class RscFrame_1800: RscFrame
{
	idc = 300;
	x = 0.293749 * safezoneW + safezoneX;
	y = 0.313 * safezoneH + safezoneY;
	w = 0.4125 * safezoneW;
	h = 0.33 * safezoneH;
};
class RscButton_1601: RscButton
{
	idc = 301;
	text = "500m"; //--- ToDo: Localize;
	x = 0.304062 * safezoneW + safezoneX;
	y = 0.335 * safezoneH + safezoneY;
	w = 0.061875 * safezoneW;
	h = 0.066 * safezoneH;
	action = "[500] call fnc_setdistance";
};
class 750m: RscButton
{
	idc = 302;
	text = "750m"; //--- ToDo: Localize;
	x = 0.386562 * safezoneW + safezoneX;
	y = 0.335 * safezoneH + safezoneY;
	w = 0.061875 * safezoneW;
	h = 0.066 * safezoneH;
	action = "[750] call fnc_setdistance";
};
class 1000m: RscButton
{
	idc = 303;
	text = "1000m"; //--- ToDo: Localize;
	x = 0.469062 * safezoneW + safezoneX;
	y = 0.335 * safezoneH + safezoneY;
	w = 0.061875 * safezoneW;
	h = 0.066 * safezoneH;
	action = "[1000] call fnc_setdistance";
};
class 1250m: RscButton
{
	idc = 304;
	text = "1250m"; //--- ToDo: Localize;
	x = 0.551562 * safezoneW + safezoneX;
	y = 0.335 * safezoneH + safezoneY;
	w = 0.061875 * safezoneW;
	h = 0.066 * safezoneH;
	action = "[1250] call fnc_setdistance";
};
class 1500m: RscButton
{
	idc = 305;
	text = "1500m"; //--- ToDo: Localize;
	x = 0.634062 * safezoneW + safezoneX;
	y = 0.335 * safezoneH + safezoneY;
	w = 0.061875 * safezoneW;
	h = 0.066 * safezoneH;
	action = "[1500] call fnc_setdistance";
};
class 2000m: RscButton
{
	idc = 306;
	text = "2000m"; //--- ToDo: Localize;
	x = 0.304062 * safezoneW + safezoneX;
	y = 0.423 * safezoneH + safezoneY;
	w = 0.061875 * safezoneW;
	h = 0.066 * safezoneH;
	action = "[2000] call fnc_setdistance";
};
class 3000m: RscButton
{
	idc = 307;
	text = "3000m"; //--- ToDo: Localize;
	x = 0.386562 * safezoneW + safezoneX;
	y = 0.423 * safezoneH + safezoneY;
	w = 0.061875 * safezoneW;
	h = 0.066 * safezoneH;
	action = "[3000] call fnc_setdistance";
};
class 5000m: RscButton
{
	idc = 308;
	text = "5000m"; //--- ToDo: Localize;
	x = 0.469062 * safezoneW + safezoneX;
	y = 0.423 * safezoneH + safezoneY;
	w = 0.061875 * safezoneW;
	h = 0.066 * safezoneH;
	action = "[5000] call fnc_setdistance";
};
class 7500m: RscButton
{
	idc = 309;
	text = "7500m"; //--- ToDo: Localize;
	x = 0.551562 * safezoneW + safezoneX;
	y = 0.423 * safezoneH + safezoneY;
	w = 0.061875 * safezoneW;
	h = 0.066 * safezoneH;
	action = "[7500] call fnc_setdistance";
};
class 10000m: RscButton
{
	idc = 310;
	text = "10000m"; //--- ToDo: Localize;
	x = 0.634062 * safezoneW + safezoneX;
	y = 0.423 * safezoneH + safezoneY;
	w = 0.061875 * safezoneW;
	h = 0.066 * safezoneH;
	action = "[10000] call fnc_setdistance";
};
class RscEdit_1400: RscEdit
{
	idc = 311;
	x = 0.45875 * safezoneW + safezoneX;
	y = 0.511 * safezoneH + safezoneY;
	w = 0.0825 * safezoneW;
	h = 0.044 * safezoneH;
};
class buttonaccept_gui: RscButton
{
	idc = 312;
	text = "Ustaw własną"; //--- ToDo: Localize;
	x = 0.45875 * safezoneW + safezoneX;
	y = 0.577 * safezoneH + safezoneY;
	w = 0.0825 * safezoneW;
	h = 0.044 * safezoneH;
	action = "[parseNumber (ctrlText 311)] call fnc_setdistance";
};
class close_settings: RscButton
{
	idc = 313;
	text = "Zamknij"; //--- ToDo: Localize;
	x = 0.613437 * safezoneW + safezoneX;
	y = 0.533 * safezoneH + safezoneY;
	w = 0.0825 * safezoneW;
	h = 0.088 * safezoneH;
	action = "closeDialog 0";
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

	};
};
