

_array = Groundzero nearObjects ["All", 400];
{_x setDamage ((getDamage _x) + 1.0)} forEach _array;

sleep 2; // ~2

_array = Groundzero nearObjects ["Man", 500];
{_x setDamage ((getDamage _x) + 1.0)} forEach _array;

_array = Groundzero nearObjects ["Land", 500];
{_x setDamage ((getDamage _x) + 1.0)} forEach _array;

_array = Groundzero nearObjects ["Ship", 500];
{_x setDamage ((getDamage _x) + 0.9)} forEach _array;

_array = Groundzero nearObjects ["Motorcycle", 500];
{_x setDamage ((getDamage _x) + 1.0)} forEach _array;

_array = Groundzero nearObjects ["Car", 500];
{_x setDamage ((getDamage _x) + 1.0)} forEach _array;

_array = Groundzero nearObjects ["Air", 500];
{_x setDamage ((getDamage _x) + 0.8)} forEach _array;

_array = Groundzero nearObjects ["Tank", 500];
{_x setDamage ((getDamage _x) + 0.8)} forEach _array;

_array = Groundzero nearObjects ["Thing", 500];
{_x setDamage ((getDamage _x) + 1.0)} forEach _array;

_array = Groundzero nearObjects ["Static", 500];
{_x setDamage ((getDamage _x) + 1.0)} forEach _array;

_array = Groundzero nearObjects ["Strategic", 500];
{_x setDamage ((getDamage _x) + 1.0)} forEach _array;

_array = Groundzero nearObjects ["NonStrategic", 500];
{_x setDamage ((getDamage _x) + 1.0)} forEach _array;

sleep 3; // ~3 

_array = Groundzero nearObjects ["Man", 700];
{_x setDamage ((getDamage _x) + 0.7)} forEach _array;

_array = Groundzero nearObjects ["Land", 700];
{_x setDamage ((getDamage _x) + 0.5)} forEach _array;

_array = Groundzero nearObjects ["Ship", 700];
{_x setDamage ((getDamage _x) + 0.5)} forEach _array;

_array = Groundzero nearObjects ["Motorcycle", 700];
{_x setDamage ((getDamage _x) + 0.5)} forEach _array;

_array = Groundzero nearObjects ["Car", 700];
{_x setDamage ((getDamage _x) + 0.5)} forEach _array;

_array = Groundzero nearObjects ["Air", 700];
{_x setDamage ((getDamage _x) + 0.5)} forEach _array;

_array = Groundzero nearObjects ["Tank", 700];
{_x setDamage ((getDamage _x) + 0.5)} forEach _array;

_array = Groundzero nearObjects ["Thing", 700];
{_x setDamage ((getDamage _x) + 0.5)} forEach _array;

_array = Groundzero nearObjects ["Static", 700];
{_x setDamage ((getDamage _x) + 0.7)} forEach _array;

_array = Groundzero nearObjects ["Strategic", 700];
{_x setDamage ((getDamage _x) + 0.7)} forEach _array;

_array = Groundzero nearObjects ["NonStrategic", 700];
{_x setDamage ((getDamage _x) + 0.7)} forEach _array;

sleep 3; // ~3 

_array = Groundzero nearObjects ["Man", 1000];
{_x setDamage ((getDamage _x) + 0.7)} forEach _array;

_array = Groundzero nearObjects ["Land", 1000];
{_x setDamage ((getDamage _x) + 0.4)} forEach _array;

_array = Groundzero nearObjects ["Ship", 1000];
{_x setDamage ((getDamage _x) + 0.4)} forEach _array;

_array = Groundzero nearObjects ["Motorcycle", 1000];
{_x setDamage ((getDamage _x) + 0.4)} forEach _array;

_array = Groundzero nearObjects ["Car", 1000];
{_x setDamage ((getDamage _x) + 0.4)} forEach _array;

_array = Groundzero nearObjects ["Air", 1000];
{_x setDamage ((getDamage _x) + 0.4)} forEach _array;

_array = Groundzero nearObjects ["Tank", 1000];
{_x setDamage ((getDamage _x) + 0.4)} forEach _array;

_array = Groundzero nearObjects ["Thing", 1000];
{_x setDamage ((getDamage _x) + 0.4)} forEach _array;

_array = Groundzero nearObjects ["Static", 1000];
{_x setDamage ((getDamage _x) + 0.4)} forEach _array;

_array = Groundzero nearObjects ["Strategic", 1000];
{_x setDamage ((getDamage _x) + 0.4)} forEach _array;

_array = Groundzero nearObjects ["NonStrategic", 1000];
{_x setDamage ((getDamage _x) + 0.4)} forEach _array;

sleep 3; // ~3

_array = Groundzero nearObjects ["Man", 1500];
{_x setDamage ((getDamage _x) + 0.2)} forEach _array;

_array = Groundzero nearObjects ["Land", 1500];
{_x setDamage ((getDamage _x) + 0.2)} forEach _array;

_array = Groundzero nearObjects ["Ship", 1500];
{_x setDamage ((getDamage _x) + 0.2)} forEach _array;

_array = Groundzero nearObjects ["Motorcycle", 1500];
{_x setDamage ((getDamage _x) + 0.2)} forEach _array;

_array = Groundzero nearObjects ["Car", 1500];
{_x setDamage ((getDamage _x) + 0.2)} forEach _array;

// radarea = "HeliHEmpty" createVehicle (position Groundzero);
[] exec "Mydlo\nukeradzone.sqs";


// exit
