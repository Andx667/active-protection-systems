#include "..\script_component.hpp"

/*
 * Author: Yax
 * Initializes a vehicle's APS (Active Protection System) modules from the APS type in its aps_type config entry, with the
 * module properties from its "aps" config class taking precedence, and stores the module array in the vehicle's
 * "aps_core_modules" variable (public). Called by the vehicle init event handler on the server.
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
 * Public: No
 */

params [["_vehicle", objNull, [objNull]]];

// The init event runs on every machine; only the server sets the state so that joining clients do not reset it
if (!isServer) exitWith {};

private _vehicleConfig = configOf _vehicle;
private _type = getText (_vehicleConfig >> QUOTE(DOUBLES(PREFIX,type)));
if (_type == "") exitWith {};

private _typeConfig = configFile >> QUOTE(DOUBLES(PREFIX,types)) >> _type;
if (!isClass _typeConfig) exitWith {
    WARNING_2("%1: unknown aps_type '%2'",typeOf _vehicle,_type);
};

private _overrides = _vehicleConfig >> QUOTE(PREFIX);

// A module 1 or 2 m off its real mount only shifts its range a little, and the line of sight check ignores the
// vehicle itself, so without a position the modules sit on the centre line in the upper quarter of the vehicle
(boundingBoxReal _vehicle) params ["_bbMin", "_bbMax"];
private _defaultPosition = [0, 0, (_bbMin select 2) + 0.75 * ((_bbMax select 2) - (_bbMin select 2))];
// [] = fixed to the hull
private _defaultTurret = [[], [0]] select ([0] in allTurrets [_vehicle, false]);

// the vehicle's value, else the type's, else the default
private _fnc_value = {
    params ["_module", "_property", "_default"];
    private _value = (_overrides >> configName _module >> _property) call BIS_fnc_getCfgData;
    if (isNil "_value") then {
        _value = (_module >> _property) call BIS_fnc_getCfgData;
    };
    if (isNil "_value") then {_default} else {_value}
};

// Order must match the MODULE_* indices in script_component.hpp
private _modules = ("true" configClasses _typeConfig) apply {[
    [_x, "displayName", configName _x] call _fnc_value,
    [_x, "position", _defaultPosition] call _fnc_value,
    [_x, "turret", _defaultTurret] call _fnc_value,
    [_x, "direction", 0] call _fnc_value,
    [_x, "traverse", 0] call _fnc_value,
    [_x, "elevate", 0] call _fnc_value,
    [_x, "range", 0] call _fnc_value,
    [_x, "magazine", ""] call _fnc_value,
    [_x, "pk", 0] call _fnc_value,
    [_x, "reloadTime", 0] call _fnc_value,
    ([_x, "trigger", 1] call _fnc_value) == 1,
    0
]};

if (_modules isEqualTo []) exitWith {};

private _vehicleMagazines = getArray (_vehicleConfig >> "magazines");
{
    private _magazine = _x select MODULE_MAGAZINE;
    if !(_magazine in _vehicleMagazines) then {
        WARNING_3("%1: %2 cannot fire, magazines[] has no %3",typeOf _vehicle,_x select MODULE_NAME,_magazine);
    };
} forEach _modules;

_vehicle setVariable [QGVAR(modules), _modules, true];
