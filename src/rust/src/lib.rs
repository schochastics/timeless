use dateparser::DateTimeUtc;
use extendr_api::prelude::*;

#[extendr]
fn chronos_rs(times: Vec<String>) -> Vec<String> {
    times
        .iter()
        .map(|input| match input.parse::<DateTimeUtc>() {
            Ok(value) => value.0.format("%Y-%m-%d %H:%M:%S").to_string(),
            Err(_e) => "false".to_string(),
        })
        .collect()
}

// Macro to generate exports.
// This ensures exported functions are registered with R.
// See corresponding C code in `entrypoint.c`.
extendr_module! {
    mod chronos;
    fn chronos_rs;
}
