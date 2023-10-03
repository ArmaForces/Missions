// zabijaninie nieprzytomnych jednostek AI / przywracanie przytomności.
// szkoda CPU na obliczanie jednostek, które przez kilkadziesiąt minut leżą i nic nie robią.
// szczególnie, że nieprzytomne jednostki mogą tak leżeć od początku do końca misji.

_unit = _this select 0;
if (!isPlayer _unit && {_unit getVariable ["killUncons", true]})then
{
	[_unit]spawn
	{
		_unit = _this select 0;
		sleep random [10,30,60];
		if (_unit getVariable ["ace_isunconscious",true])then
		{
			if ((random 1) < 0.1)then
			{
				//_unit setVariable ["M_AIvoiceAlive",false,2];
				sleep 1;
				_unit setDamage 1;
			}else
			{
				//[_unit, false, 0, true] call ace_medical_fnc_setUnconscious;
				sleep 3;
				if (_unit getVariable ["ace_isunconscious",true])then
				{
					//_unit setVariable ["M_AIvoiceAlive",false,2];
					sleep 1;
					_unit setDamage 1;
				};
			};
		};
	};
};