#include "script_component.hpp"

{
    [_x, "cup_acc_zenit_2ds"] call FUNC(addAndForcePointer);
} forEach (allUnits select {side _x isEqualTo EAST});

{
    _x setFuel random 0.8 + 0.2;
} forEach vehicles;