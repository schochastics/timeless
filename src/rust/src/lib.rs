use chrono::{DateTime, NaiveDate, NaiveDateTime};
use dateparser::DateTimeUtc;
use extendr_api::prelude::*;
use rayon::prelude::*;

const NOT_FOUND: &str = "not found";
const PAR_THRESHOLD: usize = 100;

fn maybe_par_map<T, F>(items: &[T], f: F) -> Vec<String>
where
    T: Sync,
    F: Fn(&T) -> String + Sync + Send,
{
    if items.len() > PAR_THRESHOLD {
        items.par_iter().map(f).collect()
    } else {
        items.iter().map(f).collect()
    }
}

#[extendr]
fn parse_guess_rs(times: Vec<String>) -> Vec<String> {
    maybe_par_map(&times, |input| {
        input
            .parse::<DateTimeUtc>()
            .map(|dt| dt.0.format("%Y-%m-%d %H:%M:%S").to_string())
            .unwrap_or_else(|_| NOT_FOUND.to_string())
    })
}

#[extendr]
fn parse_datetime_rs(times: Vec<String>, formats: Vec<String>, out_format: &str) -> Vec<String> {
    maybe_par_map(&times, |time_str| {
        formats
            .iter()
            .find_map(|fmt| NaiveDateTime::parse_from_str(time_str, fmt).ok())
            .map(|dt| dt.format(out_format).to_string())
            .unwrap_or_else(|| NOT_FOUND.to_string())
    })
}

#[extendr]
fn parse_date_rs(times: Vec<String>, formats: Vec<String>, out_format: &str) -> Vec<String> {
    maybe_par_map(&times, |time_str| {
        formats
            .iter()
            .find_map(|fmt| NaiveDate::parse_from_str(time_str, fmt).ok())
            .and_then(|date| date.and_hms_opt(0, 0, 0))
            .map(|dt| dt.format(out_format).to_string())
            .unwrap_or_else(|| NOT_FOUND.to_string())
    })
}

#[extendr]
fn parse_epoch_rs(times: Vec<String>, out_format: &str) -> Vec<String> {
    maybe_par_map(&times, |time_str| {
        time_str
            .parse::<i64>()
            .ok()
            .and_then(|secs| DateTime::from_timestamp(secs, 0))
            .map(|dt| dt.format(out_format).to_string())
            .unwrap_or_else(|| NOT_FOUND.to_string())
    })
}

#[extendr]
fn parse_epoch_i64_rs(times: Vec<i32>, out_format: &str) -> Vec<String> {
    maybe_par_map(&times, |&epoch| {
        DateTime::from_timestamp(epoch.into(), 0)
            .map(|dt| dt.format(out_format).to_string())
            .unwrap_or_else(|| NOT_FOUND.to_string())
    })
}

extendr_module! {
    mod timeless;
    fn parse_guess_rs;
    fn parse_datetime_rs;
    fn parse_date_rs;
    fn parse_epoch_rs;
    fn parse_epoch_i64_rs;
}
