#define COMPONENT core
#define COMPONENT_BEAUTIFIED Core
#include "\z\aps\addons\main\script_mod.hpp"

#include "\z\aps\addons\main\script_macros.hpp"

// Indices into a module array of the aps_core_modules vehicle variable, see fnc_vehicleInit
#define MODULE_NAME 0
#define MODULE_POSITION 1
#define MODULE_AMMO 7
#define MODULE_PK 8
#define MODULE_TRIGGER 10
#define MODULE_LAST_FIRED 11

// m/s of the round a module fires when it misses
#define MISS_ROUND_SPEED 900

#define DEBUG_ENABLED (missionNamespace getVariable [QGVAR(debug), false])
