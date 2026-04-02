## Resubmission of 0.3.0

Fixes based on CRAN pre-test feedback:

- Fixed test failure in timezone conversion test by using IANA timezone name
  ("Europe/Berlin") instead of abbreviated "CET"
- Configure scripts now report `rustc` version before checking for `cargo`,
  so the version is always reported even when the build fails
- NOTE about `R_UnboundValue`: This non-API call originates from the upstream
  `extendr` framework (v0.8.1), which is the latest release. It will be
  resolved when a new version of extendr is published with C API compliance fixes.
