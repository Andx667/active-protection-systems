# Active Protection Systems

**Active Protection Systems** (APS) intercept incoming rockets and missiles before they hit the vehicle. The mod fits an APS to the vanilla main battle tanks, and mod makers can fit it to their own vehicles.

The APS was part of [ITC Land Systems Redux](https://github.com/Andx667/ITC_Land_Systems) and is now its own mod. The project is entirely open-source and any contributions are welcome.

!!! warning "Not released"
    This repo keeps the APS code that was removed from ITC Land Systems Redux. There is no Workshop item or release yet.

!!! info "Requirements"
    Active Protection Systems requires [CBA_A3](https://github.com/CBATeam/CBA_A3/releases/latest) and [ACE3](https://github.com/acemod/ACE3/releases/latest).

## Vehicles

| Tank | Classname | System | Arc per module | Range | Shots per module | Time between shots | Kill chance |
| --- | --- | --- | --- | --- | --- | --- | --- |
| **M2A1 Slammer** | `B_MBT_01_cannon_F` | **Trophy** left and right | 186°, centred on its side (together all round) | 15 m | 2 | 3 s | 80 % |
| **T-100 Varsuk** | `O_MBT_02_cannon_F` | **Drozd** left and right | 40°, centred 20° left or right of the front (together 80° to the front) | 10 m | 4 | 0.5 s | 30 % |
| **T-140 Angara** (all variants) | `MBT_04_base_F` and every class derived from it | **Afghanit** left and right | 60°, centred 30° left or right of the front (together 120° to the front) | 30 m | 5 | 0.1 s | 80 % |

The coverage, range and number of shots follow public information on the real systems: Trophy has one ready round per launcher and a slow reload, Drozd covers 60 to 80° to the front and intercepts at about 7 m (10 m here, so fast rounds are not missed between two frames), Afghanit is reported with five tubes per side covering 120° to the front. Little is published on the real kill chances or Trophy's reload time; those values are balance choices.

## How it works

- Every rocket and missile in flight is watched. When it is heading for a vehicle with an APS, each module checks whether the round is within its range and arc, it has line of sight to it, it has shots left and it is not reloading.
- The first module that can engage fires. On a kill the round is detonated short of the vehicle; on a miss it flies on, and the next module (or the next check) can try again. The shot of a module that misses stops at the round, it does not fly on towards the shooter.
- The modules are mounted on the turret, so their arcs turn with it.
- Shells, bullets and grenades are not intercepted, only rockets and missiles.
- Each module has its own magazine, for example **Trophy Left**. Rearming refills it like any other vehicle magazine: with ACE rearm from an ammo truck or ammo crate (it shows up in the rearm menu), and with Zeus or script rearming.

## Settings

Under **Addon Options → Active Protection Systems** (CBA settings):

| Setting | Effect | Default | Scope |
| --- | --- | --- | --- |
| **Enable APS** | Vehicles with an active protection system intercept incoming rockets and missiles | On | Server-wide |

In the **Eden editor**, every vehicle has an **APS enabled** checkbox under **Active Protection Systems** (on by default) to switch off the APS of that vehicle.

Fitting an APS to other vehicles takes one config line, see [Mission Makers & Modders](scripting.md).
