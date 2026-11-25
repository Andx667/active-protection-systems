#include "script_component.hpp"

["All", "Fired", FUNC(fired)] call CBA_fnc_addClassEventHandler;
[QGVAR(moduleFired), FUNC(onModuleFired)] call CBA_fnc_addEventHandler;
