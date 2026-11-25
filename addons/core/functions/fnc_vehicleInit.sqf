#include "..\script_component.hpp"

/*
 * Author: Yax
 * Initializes a vehicle's APS (Active Protection System) modules from its "aps" config class, and stores the resulting
 * module array in the vehicle's "aps_core_modules" variable (public) if any modules are defined.
 * Run on the server; on other machines it does nothing, so the init event handler can call it everywhere.
 *
 * Arguments:
 * 0: Vehicle to initialize APS modules for <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle] call aps_core_fnc_vehicleInit
 *
 * Public: Yes
 */

params [["_vehicle", objNull, [objNull]]];

// The init event runs on every machine; only the server sets the state so that joining clients do not reset it
if (!isServer) exitWith {};

// Order must match the MODULE_* indices in script_component.hpp
private _modules = ("true" configClasses (configOf _vehicle >> QUOTE(PREFIX))) apply {[
    getText (_x >> "displayName"),
    (_x >> "position") call BIS_fnc_getCfgData,
    (_x >> "turret") call BIS_fnc_getCfgData,
    getNumber (_x >> "direction"),
    getNumber (_x >> "traverse"),
    getNumber (_x >> "elevate"),
    getNumber (_x >> "range"),
    getNumber (_x >> "munitions"),
    getNumber (_x >> "pk"),
    getNumber (_x >> "reloadTime"),
    getNumber (_x >> "trigger") == 1,
    0
]};

if (_modules isEqualTo []) exitWith {};

_vehicle setVariable [QGVAR(modules), _modules, true];
