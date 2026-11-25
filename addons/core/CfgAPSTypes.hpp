// APS types a vehicle selects with aps_type. One subclass per launcher module; other mods can add types.
// direction is relative to the turret (or hull), so a type fits any vehicle.
// Shots are the count of the module's magazine (CfgMagazines.hpp). Coverage, range and shots follow public sources (docs/index.md); pk, Trophy's reload time and Drozd's range
// (10 m instead of 7 m, so fast rounds are not missed between two frames) are balance choices.
class DOUBLES(PREFIX,types) {
    class trophy {
        class TROPHY_L {
            displayName = CSTRING(TROPHY_L_DisplayName);
            direction = -90;
            traverse = 93;
            elevate = 40;
            range = 15;
            magazine = QGVAR(trophy_l);
            pk = 0.8;
            reloadTime = 3;
            trigger = 1;
        };
        class TROPHY_R: TROPHY_L {
            displayName = CSTRING(TROPHY_R_DisplayName);
            magazine = QGVAR(trophy_r);
            direction = 90;
        };
    };

    class drozd {
        class DROZD_L {
            displayName = CSTRING(DROZD_L_DisplayName);
            direction = -20;
            traverse = 20;
            elevate = 15;
            range = 10;
            magazine = QGVAR(drozd_l);
            pk = 0.3;
            reloadTime = 0.5;
            trigger = 1;
        };
        class DROZD_R: DROZD_L {
            displayName = CSTRING(DROZD_R_DisplayName);
            magazine = QGVAR(drozd_r);
            direction = 20;
        };
    };

    class afghanit {
        class AFGHANIT_L {
            displayName = CSTRING(AFGHANIT_L_DisplayName);
            direction = -30;
            traverse = 30;
            elevate = 10;
            range = 30;
            magazine = QGVAR(afghanit_l);
            pk = 0.8;
            reloadTime = 0.1;
            trigger = 1;
        };
        class AFGHANIT_R: AFGHANIT_L {
            displayName = CSTRING(AFGHANIT_R_DisplayName);
            magazine = QGVAR(afghanit_r);
            direction = 30;
        };
    };
};
