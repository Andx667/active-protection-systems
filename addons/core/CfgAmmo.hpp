class CfgAmmo {
    class RocketBase;
    // Never fired: the ammo of the APS magazines, its caliber sets ACE rearm's time and supply cost
    class GVAR(countermeasure): RocketBase {
        ace_rearm_caliber = 105;
    };
};
