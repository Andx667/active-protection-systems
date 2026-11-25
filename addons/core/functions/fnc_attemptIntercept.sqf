#include "..\script_component.hpp"

/*
 * Author: Yax
 * Attempts to intercept an incoming projectile with each of a vehicle's APS (Active Protection System) modules that report being able to
 * intercept it. On a successful chance roll (pk), destroys or replaces the incoming projectile; on a failed roll, fires a round from
 * the module at the projectile that is removed once it reaches it. Runs on the machine that owns the projectile. The module's ammo
 * count and last fired time are updated optimistically on this machine and sent to the vehicle's owner (onModuleFired), which
 * applies and publishes the authoritative state.
 *
 * Arguments:
 * 0: Incoming projectile <OBJECT>
 * 1: Vehicle with APS module(s) attempting interception <OBJECT>
 *
 * Return Value:
 * True if a module destroyed the projectile <BOOL>
 *
 * Example:
 * [_projectile, _vehicle] call aps_core_fnc_attemptIntercept
 *
 * Public: No
 */

params [["_projectile", objNull, [objNull]], ["_vehicle", objNull, [objNull]]];

private _killed = false;
private _apsModules = _vehicle getVariable [QGVAR(modules), []];
{
    if (_killed) exitWith {};
    private _canIntercept = [_vehicle, _x, _projectile] call FUNC(canIntercept);
    if (_canIntercept) then {
        private _index = _forEachIndex;
        private _module = +_x;
        private _pk = _module select MODULE_PK;
        private _triggersAmmo = _module select MODULE_TRIGGER;

        // When the vehicle is remote, apply the shot locally right away so the next frame does not fire
        // the same module again; the owner's event handler applies it to the shared state
        if (!local _vehicle) then {
            _module set [MODULE_AMMO, (_module select MODULE_AMMO) - 1];
            _module set [MODULE_LAST_FIRED, cba_missionTime];
            _apsModules set [_index, _module];
            _vehicle setVariable [QGVAR(modules), _apsModules];
        };
        [QGVAR(moduleFired), [_vehicle, _index, cba_missionTime], _vehicle] call CBA_fnc_targetEvent;

        private _kill = random 1 <= _pk;
        if (DEBUG_ENABLED) then {
            private _result = ["miss", "kill"] select _kill;
            INFO_4("%1 %2 fired at %3 m: %4",typeOf _vehicle,_module select MODULE_NAME,round (_projectile distance _vehicle),_result);
        };

        if (_kill) then {
            if (_triggersAmmo) then {
                triggerAmmo _projectile;
            } else {
                private _newProjectile = "ammo_Penetrator_PG7" createVehicle [0,0,100];
                private _pos = getPosASL _projectile;
                (_projectile call bis_fnc_getPitchBank) params ["_pitch", "_bank"];
                deleteVehicle _projectile;
                [_newProjectile, _pitch, _bank] call bis_fnc_setPitchBank;
                _newProjectile setPosASL _pos;
                triggerAmmo _newProjectile;
            };
            _killed = true;
        } else {
            // the round is removed once it reaches the projectile, so a miss cannot fly on and hit whatever is behind it;
            // it starts 1 m out so it does not hit its own vehicle
            private _to = getPosASL _projectile;
            private _from = _vehicle modelToWorldWorld (_module select MODULE_POSITION);
            _from = _from vectorAdd (_from vectorFromTo _to);
            private _round = "B_127x108_APDS" createVehicle [0,0,100];
            _round setPosASL _from;
            _round setVelocity ((_from vectorFromTo _to) vectorMultiply MISS_ROUND_SPEED);
            [{deleteVehicle _this}, _round, (_from vectorDistance _to) / MISS_ROUND_SPEED] call CBA_fnc_waitAndExecute;
        };
    };
} forEach _apsModules;

_killed
