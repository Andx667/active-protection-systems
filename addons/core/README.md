# Core

`aps_core`: the active protection system: module state, projectile tracking and interception, and the APS of the vanilla main battle tanks. User docs: [docs/index.md](../../docs/index.md), [docs/scripting.md](../../docs/scripting.md).

Moved from ITC Land Systems Redux (`itc_land_aps`).

## Dependencies

- CBA_A3, ACE3 (`ace_common_fnc_getTurretDirection`)

## How it works

- `fnc_vehicleInit` (XEH `serverInit` on `AllVehicles`) reads the vehicle's `aps_type`, takes that type's modules from `aps_types`, lets the vehicle's `aps` class override any module property, fills in a default position and turret, and stores the result in the public `aps_core_modules` variable, one array per module (indices: `MODULE_*` in `script_component.hpp`).
- `fnc_fired` (CBA `Fired` class event handler on `All`) follows every locally fired rocket and missile with a per-frame handler that raycasts 30 m ahead each frame; a hit on an object with `aps_core_modules` whose `aps_core_enabled` object variable (Eden attribute) is not false calls `fnc_attemptIntercept`.
- `fnc_canIntercept` measures range, elevation and line of sight from the launcher, but the traverse angle from the vehicle's centre line at the launcher's height. Measured from the launcher, a projectile heading for the centre looks to be on the far side of each side launcher, so arcs that meet at the front (Drozd, Afghanit) left a blind wedge there.
- Interception runs on the shooter's machine. A module that fires is applied locally right away and sent to the vehicle's owner as `aps_core_moduleFired`; the owner (`fnc_onModuleFired`) takes the shot from the magazine (`setMagazineTurretAmmo` needs the turret local), applies the fired time and publishes it, so several shooters do not overwrite each other.

## Files

- `CfgAPSTypes.hpp`: the APS types (`aps_types`: trophy, drozd, afghanit)
- `CfgMagazines.hpp`, `CfgAmmo.hpp`: one magazine per module. A module's shots are its magazine's ammo in the driver turret `[-1]` (the vehicle's root `magazines[]`), so ACE rearm, vanilla rearm and `setVehicleAmmo` refill them without APS code; the ammo's `ace_rearm_caliber` sets ACE's rearm time and supply cost
- `CfgVehicles.hpp`: the APS of the Slammer, Varsuk and Angara (type, magazines and launcher positions)
- `Cfg3DEN.hpp`: the "APS enabled" vehicle attribute; its expression runs on the server only, so it sets the variable public

## Settings

CBA settings in `initSettings.inc.sqf`: `aps_core_enabled`.

## CBA events

Internal events this addon handles (raised with `CBA_fnc_*Event`):

- `aps_core_moduleFired` (`XEH_postInit.sqf`)

## Functions

| Function | Public | What it does |
| --- | --- | --- |
| `fnc_attemptIntercept` |  | Attempts to intercept an incoming projectile with each of a vehicle's APS modules that report being able to intercept it. |
| `fnc_canIntercept` |  | Checks whether an APS module can intercept an incoming projectile right now: ammo, range, reload, traverse/elevation and line of sight. |
| `fnc_fired` |  | "Fired" class event handler. |
| `fnc_onModuleFired` |  | Handles the moduleFired event on the vehicle's owner: decrements the module's ammo and publishes the module state. |
| `fnc_vehicleInit` |  | Initializes a vehicle's APS modules from its `aps_type` and `aps` config class. |
