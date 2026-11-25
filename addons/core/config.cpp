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
        magazines[] = {};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgAPSTypes.hpp"
#include "Cfg3DEN.hpp"
#include "CfgVehicles.hpp"
