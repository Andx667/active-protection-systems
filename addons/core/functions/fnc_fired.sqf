#include "..\script_component.hpp"

/*
 * Author: Yax
 * "Fired" class event handler. For locally fired rocket/missile projectiles, adds a per-frame handler that raycasts ahead of the
 * projectile every frame and attempts an APS intercept against any object it detects with APS modules, until the projectile dies.
 *
 * Arguments:
 * 0: Unit that fired <OBJECT>
 * 1: Weapon classname <STRING>
 * 2: Muzzle classname <STRING>
 * 3: Firing mode <STRING>
 * 4: Ammo classname <STRING>
 * 5: Magazine classname <STRING>
 * 6: Fired projectile <OBJECT>
 * 7: Gunner <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit, _weapon, _muzzle, _mode, _ammo, _magazine, _projectile, _gunner] call aps_core_fnc_fired
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]], "", "", "", ["_ammo", "", [""]], "", ["_projectile", objNull, [objNull]]];

if (!local _unit) exitWith {};
if (!GVAR(enabled)) exitWith {};

// runs for every bullet of every local unit, so the config lookup is cached per ammo class
private _tracked = GVAR(trackedAmmo) getOrDefaultCall [_ammo, {
    getText (configFile >> "CfgAmmo" >> _ammo >> "simulation") in ["shotRocket", "shotMissile"]
}, true];
if (!_tracked) exitWith {};

if (DEBUG_ENABLED) then {
    INFO_3("tracking %1 fired by %2 at %3 m/s",_ammo,typeOf _unit,round vectorMagnitude velocity _projectile);
};

// every frame: a rocket covers several metres per frame and a module's window is only its range
[{
    params ["_projectile", "_pfhId"];
    if (!alive _projectile) exitWith {
        [_pfhId] call CBA_fnc_removePerFrameHandler;
    };

    private _begin = getPosASL _projectile;
    private _end = _begin vectorAdd (vectorDir _projectile vectorMultiply 30);
    { // forEach lineIntersectsWith
        // a killed projectile can stay alive for a few frames: stop tracking it so no module fires at it again
        if (!isNil {_x getVariable QGVAR(modules)} && {[_projectile, _x] call FUNC(attemptIntercept)}) exitWith {
            [_pfhId] call CBA_fnc_removePerFrameHandler;
        };
    } forEach lineIntersectsWith [_begin, _end];
}, 0, _projectile] call CBA_fnc_addPerFrameHandler;
