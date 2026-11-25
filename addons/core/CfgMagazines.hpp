// One magazine per APS module; a vehicle lists them in its root magazines[] so rearming refills them
class CfgMagazines {
    class VehicleMagazine;
    class GVAR(trophy_l): VehicleMagazine {
        scope = 2;
        displayName = CSTRING(TROPHY_L_DisplayName);
        ammo = QGVAR(countermeasure);
        count = 2;
    };
    class GVAR(trophy_r): GVAR(trophy_l) {
        displayName = CSTRING(TROPHY_R_DisplayName);
    };

    class GVAR(drozd_l): GVAR(trophy_l) {
        displayName = CSTRING(DROZD_L_DisplayName);
        count = 4;
    };
    class GVAR(drozd_r): GVAR(drozd_l) {
        displayName = CSTRING(DROZD_R_DisplayName);
    };

    class GVAR(afghanit_l): GVAR(trophy_l) {
        displayName = CSTRING(AFGHANIT_L_DisplayName);
        count = 5;
    };
    class GVAR(afghanit_r): GVAR(afghanit_l) {
        displayName = CSTRING(AFGHANIT_R_DisplayName);
    };
};
