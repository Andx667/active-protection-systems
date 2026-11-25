#include "..\script_component.hpp"

/*
 * Author: ITC Addons Team
 * Handles the moduleFired event on the machine that owns the vehicle: takes a shot from the APS module's
 * magazine (the driver turret it is in is local here), stores when it fired, and publishes the module state to all machines. Doing this on
 * the vehicle's owner means concurrent interceptions from different shooters do not overwrite each other.
 *
 * Arguments:
 * 0: Vehicle with the APS module <OBJECT>
 * 1: Index of the module in the vehicle's APS module array <NUMBER>
 * 2: Mission time the module fired at <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle, 0, cba_missionTime] call aps_core_fnc_onModuleFired
 *
 * Public: No
 */

params [["_vehicle", objNull, [objNull]], ["_index", 0, [0]], ["_firedTime", 0, [0]]];

if (!local _vehicle) exitWith {};

private _apsModules = _vehicle getVariable [QGVAR(modules), []];
if (_index >= count _apsModules) exitWith {};

private _module = +(_apsModules select _index);
private _magazine = _module select MODULE_MAGAZINE;
private _ammo = _vehicle magazineTurretAmmo [_magazine, MAGAZINE_TURRET];
_vehicle setMagazineTurretAmmo [_magazine, (_ammo - 1) max 0, MAGAZINE_TURRET];
_module set [MODULE_LAST_FIRED, _firedTime];
_apsModules set [_index, _module];

_vehicle setVariable [QGVAR(modules), _apsModules, true];
