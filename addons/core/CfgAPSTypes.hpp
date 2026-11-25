// APS types a vehicle selects with aps_type. One subclass per launcher module; other mods can add types.
// direction is relative to the turret (or hull), so a type fits any vehicle.
class DOUBLES(PREFIX,types) {
    class trophy {
        class TROPHY_L {
            displayName = CSTRING(TROPHY_L_DisplayName);
            direction = -90;
            traverse = 93;
            elevate = 40;
            range = 15;
            munitions = 10;
            pk = 0.8;
            reloadTime = 0.1;
            trigger = 1;
        };
        class TROPHY_R: TROPHY_L {
            displayName = CSTRING(TROPHY_R_DisplayName);
            direction = 90;
        };
    };

    class drozd {
        class DROZD_L {
            displayName = CSTRING(DROZD_L_DisplayName);
            direction = -40;
            traverse = 45;
            elevate = 15;
            range = 15;
            munitions = 4;
            pk = 0.3;
            reloadTime = 0.5;
            trigger = 1;
        };
        class DROZD_R: DROZD_L {
            displayName = CSTRING(DROZD_R_DisplayName);
            direction = 40;
        };
    };

    class afghanit {
        class AFGHANIT_L {
            displayName = CSTRING(AFGHANIT_L_DisplayName);
            direction = -50;
            traverse = 55;
            elevate = 10;
            range = 30;
            munitions = 5;
            pk = 0.8;
            reloadTime = 0.1;
            trigger = 1;
        };
        class AFGHANIT_R: AFGHANIT_L {
            displayName = CSTRING(AFGHANIT_R_DisplayName);
            direction = 50;
        };
    };
};
