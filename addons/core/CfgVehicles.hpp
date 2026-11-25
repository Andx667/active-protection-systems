// A vehicle needs aps_type and the type's magazines; the aps class overrides module properties for fine tuning
class CfgVehicles {
    // MERKAVA
    class B_MBT_01_base_F;
    class B_MBT_01_cannon_F: B_MBT_01_base_F {
        DOUBLES(PREFIX,type) = "trophy";
        magazines[] += {QGVAR(trophy_l), QGVAR(trophy_r)};
        class PREFIX {
            class TROPHY_L {
                position[] = {-1,0,1.5};
            };
            class TROPHY_R {
                position[] = {1,0,1.5};
            };
        };
    };

    // T-100
    class O_MBT_02_base_F;
    class O_MBT_02_cannon_F: O_MBT_02_base_F {
        DOUBLES(PREFIX,type) = "drozd";
        magazines[] += {QGVAR(drozd_l), QGVAR(drozd_r)};
        class PREFIX {
            class DROZD_L {
                position[] = {-1,1.5,1};
            };
            class DROZD_R {
                position[] = {1,1.5,1};
            };
        };
    };

    // T-14
    class Tank_F;
    class MBT_04_base_F: Tank_F {
        DOUBLES(PREFIX,type) = "afghanit";
        magazines[] += {QGVAR(afghanit_l), QGVAR(afghanit_r)};
        class PREFIX {
            class AFGHANIT_L {
                position[] = {-1,1.5,1};
            };
            class AFGHANIT_R {
                position[] = {1,1.5,1};
            };
        };
    };
};
