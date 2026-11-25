#include "script_component.hpp"

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// ammo class -> tracked (rocket or missile), filled by fnc_fired
GVAR(trackedAmmo) = createHashMap;

#include "initSettings.inc.sqf"
