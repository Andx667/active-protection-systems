#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        author = AUTHOR;
        url = "https://github.com/Andx667/active-protection-systems";
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main"};
        units[] = {};
        weapons[] = {};
        VERSION_CONFIG;
    };
};
