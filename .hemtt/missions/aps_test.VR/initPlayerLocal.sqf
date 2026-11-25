params ["_player"];

// The OPFOR tanks would shoot back
_player setCaptive true;

// Logs what hits the player and whether they are still captive (AI only ignores captives)
_player addEventHandler ["HandleDamage", {
    params ["_unit", "_selection", "_damage", "_source", "_projectile"];
    diag_log format ["[APS test] player hit by %1 from %2 (captive %3)", _projectile, typeOf _source, captive _unit];
    nil
}];

// Unlimited launcher ammo: give back every fired magazine
_player addEventHandler ["Fired", {
    params ["_unit", "", "", "", "", "_magazine"];
    _unit addMagazine _magazine;
}];
