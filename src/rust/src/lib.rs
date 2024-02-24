use chrono::{DateTime, NaiveDate, NaiveDateTime, TimeZone, Utc};
use dateparser::DateTimeUtc;
use extendr_api::prelude::*;

#[extendr]
fn parse_guess_rs(times: Vec<String>) -> Vec<String> {
    times
        .iter()
        .map(|input| match input.parse::<DateTimeUtc>() {
            Ok(value) => value.0.format("%Y-%m-%d %H:%M:%S").to_string(),
            Err(_e) => "not found".to_string(),
        })
        .collect()
}

#[extendr]
fn parse_datetime_rs(times: Vec<String>, formats: Vec<String>, out_format: &str) -> Vec<String> {
    times
        .iter()
        .map(|time_str| {
            for fmt in &formats {
                if let Ok(date) = NaiveDateTime::parse_from_str(time_str, fmt) {
                    return Utc.from_utc_datetime(&date).format(out_format).to_string();
                }
            }
            "not found".to_string()
        })
        .collect()
}

#[extendr]
fn parse_date_rs(times: Vec<String>, formats: Vec<String>, out_format: &str) -> Vec<String> {
    times
        .iter()
        .map(|time_str| {
            for fmt in &formats {
                if let Ok(date) = NaiveDate::parse_from_str(time_str, fmt) {
                    let date_time_utc = Utc.from_utc_date(&date);
                    return date_time_utc.format(out_format).to_string();
                }
            }
            "not found".to_string()
        })
        .collect()
}

#[extendr]
fn parse_epoch_rs(times: Vec<String>, out_format: &str) -> Vec<String> {
    times
        .iter()
        .map(|time_str| {
            if let Ok(epoch_seconds) = time_str.parse::<i64>() {
                let date_time = Utc.timestamp(epoch_seconds, 0);
                return date_time.format(out_format).to_string();
            }
            "not found".to_string()
        })
        .collect()
}

extendr_module! {
    mod chronos;
    fn parse_guess_rs;
    fn parse_datetime_rs;
    fn parse_date_rs;
    fn parse_epoch_rs;
}
