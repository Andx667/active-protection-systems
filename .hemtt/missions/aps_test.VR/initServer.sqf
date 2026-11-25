// Test mission for the smoke test: one crewed tank per APS type, 150 m north of the player, facing them.
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
} forEach [
    ["B_MBT_01_cannon_F", -50], // Slammer, Trophy
    ["O_MBT_02_cannon_F", 0],   // Varsuk, Drozd
    ["O_MBT_04_cannon_F", 50]   // Angara, Afghanit
];
