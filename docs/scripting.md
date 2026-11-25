# Mission Makers & Modders

## Fitting an APS to a vehicle

One config line gives a vehicle an APS: `aps_type`, the name of an APS type. The mod picks up every vehicle with that entry, no event handler needed.

```cpp
class CfgPatches {
    class My_Addon {
        requiredAddons[] = {"aps_core"};
        // ...
    };
};

class CfgVehicles {
    class MyTank_base;
    class MyTank: MyTank_base {
        aps_type = "trophy";
    };
};
```

| `aps_type` | Modules | Arc per module | Range | Shots per module | Kill chance |
| --- | --- | --- | --- | --- | --- |
| `"trophy"` | `TROPHY_L`, `TROPHY_R` | 186°, centred on its side | 15 m | 10 | 80 % |
| `"drozd"` | `DROZD_L`, `DROZD_R` | 90°, centred 40° left or right of the front | 15 m | 4 | 30 % |
| `"afghanit"` | `AFGHANIT_L`, `AFGHANIT_R` | 110°, centred 50° left or right of the front | 30 m | 5 | 80 % |

Without further config, the modules turn with the main turret (turret `[0]`; on vehicles without one they are fixed to the hull) and sit on the vehicle's centre line in its upper quarter. That is close enough to work on any vehicle: the range is measured from there, and the line of sight check ignores the vehicle itself.

### Fine tuning

An `aps` class with a subclass per module overrides any of its properties. Leave out what should stay as the type has it:

```cpp
class MyTank: MyTank_base {
    aps_type = "trophy";
    class aps {
        class TROPHY_L {
            position[] = {-1, 0, 1.5};  // model coordinates of the launcher
        };
        class TROPHY_R {
            position[] = {1, 0, 1.5};
            munitions = 6;
        };
    };
};
```

| Property | Meaning | Default |
| --- | --- | --- |
| `displayName` | Name in the debug log | from the type |
| `position[]` | Model coordinates of the launcher | centre line, upper quarter of the vehicle |
| `turret[]` | Turns with this turret; `{}` fixes it to the hull | `{0}` if the vehicle has it, else `{}` |
| `direction` | Facing relative to the turret/hull, degrees | from the type |
| `traverse` | Covers this many degrees to each side of its facing | from the type |
| `elevate` | And this many degrees up and down | from the type |
| `range` | m, engages when the projectile is this close | from the type |
| `munitions` | Shots | from the type |
| `pk` | Kill chance per shot, 0 to 1 | from the type |
| `reloadTime` | s between shots | from the type |
| `trigger` | 1 = detonate the round, 0 = replace it with a penetrator | from the type |

### Adding an APS type

Types are classes in `aps_types`, one subclass per launcher module with the properties above. A compat mod can add its own:

```cpp
class aps_types {
    class my_aps {
        class MY_APS_FRONT {
            displayName = "My APS Front";
            direction = 0;
            traverse = 60;
            elevate = 20;
            range = 20;
            munitions = 4;
            pk = 0.6;
            reloadTime = 0.3;
            trigger = 1;
        };
    };
};
```

Prefix the class name with your mod's tag so it does not clash with types of other mods.

## Eden editor

Every vehicle has an **APS enabled** checkbox under **Active Protection Systems** in its attributes (on by default). Unticked, the vehicle's APS does not fire for the whole mission. It has no effect on vehicles without an APS.

## Public functions

The mod has no public functions yet. Every function is internal and can change at any time.

The mod raises no public events yet.

## Debugging

| Variable | Effect |
| --- | --- |
| `aps_core_debug` | Logs every tracked rocket and missile, every APS shot (kill or miss) and why a module did not fire to the RPT (`[APS] (core) INFO:`) |

Set it with `missionNamespace setVariable ["aps_core_debug", true, true];`.

## Moving from ITC Land Systems

The APS used to be the `itc_land_aps` addon of ITC Land Systems Redux. The names changed:

| ITC Land Systems | Active Protection Systems |
| --- | --- |
| `requiredAddons[] = {"itc_land_aps"}` | `requiredAddons[] = {"aps_core"}` |
| Vehicle config class `itc_land_aps` with every module property | `aps_type = "trophy";` (or `"drozd"`, `"afghanit"`), plus an `aps` class only for what differs from the type |
| Event handler class `itc_land_aps` with `call itc_land_aps_fnc_vehicleInit` | none, remove it |
| Setting `itc_land_aps_enabled` | `aps_core_enabled` |
| Debug variable `itc_land_aps_debug` | `aps_core_debug` |
