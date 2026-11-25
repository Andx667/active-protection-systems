#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        author = AUTHOR;
        authors[] = {"Yax"};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main", "ace_common", "aps_main"};
        units[] = {};
        weapons[] = {};
        magazines[] = {
            QGVAR(trophy_l), QGVAR(trophy_r),
            QGVAR(drozd_l), QGVAR(drozd_r),
            QGVAR(afghanit_l), QGVAR(afghanit_r)
        };
        ammo[] = {QGVAR(countermeasure)};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgAmmo.hpp"
#include "CfgAPSTypes.hpp"
#include "CfgMagazines.hpp"
#include "Cfg3DEN.hpp"
#include "CfgVehicles.hpp"
