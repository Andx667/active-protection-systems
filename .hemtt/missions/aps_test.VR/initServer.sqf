// Test mission for the smoke test: one crewed tank per APS type (plus an Angara variant), 150 m north of the player,
// facing them, and an ammo truck for the rearm tests.
// The tanks are spawned instead of placed to keep mission.sqm small; place tanks in Eden for the attribute tests.
missionNamespace setVariable ["aps_core_debug", true, true];

{
    _x params ["_type", "_offset"];

    private _vehicle = createVehicle [_type, [4000 + _offset, 4150, 0], [], 0, "NONE"];
    _vehicle setDir 180;

    private _group = createVehicleCrew _vehicle;
    {
        _x disableAI "MOVE";
    } forEach units _group;

    // the APS magazines must be on the spawned vehicle (turret [-1]), or the modules never fire
    diag_log format ["[APS test] %1 APS magazines: %2", _type, (magazinesAllTurrets _vehicle) select {(_x # 0) find "aps_core_" == 0} apply {[_x # 0, _x # 1, _x # 2]}];
} forEach [
    ["B_MBT_01_cannon_F", -50], // Slammer, Trophy
    ["O_MBT_02_cannon_F", 0],   // Varsuk, Drozd
    ["O_MBT_04_cannon_F", 50],  // Angara, Afghanit
    ["O_MBT_04_command_F", 100] // Angara variant: must keep the magazines it inherits
];

// ACE rearm source for refilling spent APS shots, east of the tanks and out of the firing lines
private _ammoTruck = createVehicle ["B_Truck_01_ammo_F", [4160, 4130, 0], [], 0, "NONE"];
_ammoTruck setDir 270;
