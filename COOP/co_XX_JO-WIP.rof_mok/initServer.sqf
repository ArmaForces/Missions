#include "script_component.hpp"

{
    [_x, "cup_acc_zenit_2ds"] call FUNC(addAndForcePointer);
} forEach (allUnits select {side _x isEqualTo EAST});
