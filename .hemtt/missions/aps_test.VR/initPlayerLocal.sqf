params ["_player"];

// The OPFOR tanks would shoot back
_player setCaptive true;

// Unlimited launcher ammo: give back every fired magazine
_player addEventHandler ["Fired", {
    params ["_unit", "", "", "", "", "_magazine"];
    _unit addMagazine _magazine;
}];
