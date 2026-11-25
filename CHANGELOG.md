# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Core - Active protection systems, moved out of ITC Land Systems Redux (`itc_land_aps`): Trophy on the M2A1 Slammer, Drozd on the T-100 Varsuk and Afghanit on the T-140 Angara intercept incoming rockets and missiles. The names changed from `itc_land_aps*` to `aps*`, see the migration table in the docs, by Andx
- Core - A vehicle gets an APS from two config lines: `aps_type = "trophy";` (or `"drozd"`, `"afghanit"`) and the type's magazines; launcher position and every other module property are optional overrides. Mods can add their own APS types (#12) by Andx
- Core - APS shots are vehicle magazines, so ACE rearm (and Zeus or script rearming) refills them (#16) by Andx
- Core - "APS enabled" checkbox in the Eden attributes of every vehicle, on by default (#12) by Andx

### Changed

- Core - Trophy, Drozd and Afghanit are closer to the real systems: Trophy has 2 shots per side with 3 s between them (was 10 with 0.1 s), Drozd covers 80° to the front and engages at 10 m (was 170° and 15 m), Afghanit covers 120° to the front (was 210°) (#13) by Andx

### Fixed

- Core - A missed intercept no longer sends a live round back along the rocket's path towards the shooter (#10) by Andx
- Core - Rockets and missiles aimed straight at the front of the T-100 Varsuk and T-140 Angara (or the front and rear of the M2A1 Slammer) are no longer missed by both launchers (#17) by Andx
