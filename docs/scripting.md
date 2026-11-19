# Mission Makers & Modders

## Fitting an APS to a vehicle

A vehicle gets an APS from its config: an `aps` class with one subclass per launcher module, and the init event handler that reads it.

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
        class EventHandlers: EventHandlers {
            class aps_core {
                init = "call aps_core_fnc_vehicleInit";
            };
        };
        class aps {
            class TROPHY_L {
                displayName = "Trophy Left";
                position[] = {-1, 0, 1.5};  // model coordinates of the launcher
                turret[] = {0};             // turns with this turret; leave out to fix it to the hull
                direction = -90;            // facing relative to the turret/hull, degrees
                traverse = 93;              // covers this many degrees to each side of its facing
                elevate = 40;               // and this many degrees up and down
                range = 15;                 // m, engages when the projectile is this close
                munitions = 10;             // shots
                pk = 0.8;                   // kill chance per shot
                reloadTime = 0.1;           // s between shots
                trigger = 1;                // 1 = detonate the round, 0 = replace it with a penetrator
            };
        };
    };
};
```

The vehicle class must declare `class EventHandlers: EventHandlers` so it keeps the event handlers of its parent and of CBA; without the init handler the vehicle has no APS. A config class alone (without the event handler), presets and a script API are planned.

## Public functions

These functions are the mod's public API: their arguments and behaviour stay stable, and any change is announced in the changelog with a deprecation period. Every other function is internal and can change at any time.

| Function | Arguments | Returns | Where to run |
| --- | --- | --- | --- |
| `aps_core_fnc_vehicleInit` | 0: vehicle with an `aps` config class | nothing | Server (does nothing elsewhere) |

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
| Vehicle config class `itc_land_aps` | `aps` |
| Event handler class `itc_land_aps` with `call itc_land_aps_fnc_vehicleInit` | `aps_core` with `call aps_core_fnc_vehicleInit` |
| Setting `itc_land_aps_enabled` | `aps_core_enabled` |
| Debug variable `itc_land_aps_debug` | `aps_core_debug` |
