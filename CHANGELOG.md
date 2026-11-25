# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed

- Core - A missed intercept no longer sends a live round back along the rocket's path towards the shooter (#10) by Andx

### Added

- Core - Active protection systems, moved out of ITC Land Systems Redux (`itc_land_aps`): Trophy on the M2A1 Slammer, Drozd on the T-100 Varsuk and Afghanit on the T-140 Angara intercept incoming rockets and missiles. The names changed from `itc_land_aps*` to `aps*`, see the migration table in the docs, by Andx
