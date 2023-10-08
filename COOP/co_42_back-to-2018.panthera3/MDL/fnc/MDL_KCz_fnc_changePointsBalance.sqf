params ["_pointsChange"];

MDL_KCz_Points = MDL_KCz_Points + _pointsChange;

_msg = format ["Liczba dostępnych punktów: %1 \n\n Zmiana: %2",MDL_KCz_Points,_pointsChange];

hint _msg;