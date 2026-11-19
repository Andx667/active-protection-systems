# Core

`aps_core`: the active protection system: module state, projectile tracking and interception, and the APS of the vanilla main battle tanks. User docs: [docs/index.md](../../docs/index.md), [docs/scripting.md](../../docs/scripting.md).

Moved from ITC Land Systems Redux (`itc_land_aps`). `fnc_addProjectilePFH` is a copy of ITC's `itc_land_common_fnc_addProjectilePFH`, the only ITC function the APS used.

## Dependencies

- CBA_A3, ACE3 (`ace_common_fnc_getTurretDirection`)

## How it works

- `fnc_vehicleInit` (vehicle init event handler, server only) reads the vehicle's `aps` config class into the public `aps_core_modules` variable, one array per module.
- `fnc_fired` (CBA `Fired` class event handler on `All`) follows every locally fired rocket and missile with a per-frame handler that raycasts 30 m ahead each frame; a hit on an object with `aps_core_modules` calls `fnc_attemptIntercept`.
- Interception runs on the shooter's machine. A module that fires is applied locally right away and sent to the vehicle's owner as `aps_core_moduleFired`; the owner (`fnc_onModuleFired`) applies it to the shared state and publishes it, so several shooters do not overwrite each other.

## Files

- `CfgVehicles.hpp`: the APS of the Slammer, Varsuk and Angara

## Settings

CBA settings in `initSettings.inc.sqf`: `aps_core_enabled`.

## CBA events

Internal events this addon handles (raised with `CBA_fnc_*Event`):

- `aps_core_moduleFired` (`functions/fnc_postInit.sqf`)

## Functions

| Function | Public | What it does |
| --- | --- | --- |
| `fnc_addProjectilePFH` |  | Runs code every frame (or every delay seconds) for as long as a projectile is alive. |
| `fnc_attemptIntercept` |  | Attempts to intercept an incoming projectile with each of a vehicle's APS modules that report being able to intercept it. |
| `fnc_canIntercept` |  | Checks whether an APS module can intercept an incoming projectile right now: ammo, range, reload, traverse/elevation and line of sight. |
| `fnc_fired` |  | "Fired" class event handler. |
| `fnc_onModuleFired` |  | Handles the moduleFired event on the vehicle's owner: decrements the module's ammo and publishes the module state. |
| `fnc_postInit` |  | Addon postInit entry point. |
| `fnc_vehicleInit` | Yes | Initializes a vehicle's APS modules from its `aps` config class. |
