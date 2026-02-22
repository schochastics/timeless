use chrono::{DateTime, NaiveDate, NaiveDateTime};
use dateparser::DateTimeUtc;
use extendr_api::prelude::*;
use rayon::prelude::*;

const NOT_FOUND: &str = "not found";

#[extendr]
fn parse_guess_rs(times: Vec<String>) -> Vec<String> {
    // Use parallel processing for larger datasets
    if times.len() > 100 {
        times
            .par_iter()
            .map(|input| match input.parse::<DateTimeUtc>() {
                Ok(value) => value
                    .0
                    .format("%Y-%m-%d %H:%M:%S")
                    .to_string(),
                Err(_) => NOT_FOUND.to_string(),
            })
            .collect()
    } else {
        times
            .iter()
            .map(|input| match input.parse::<DateTimeUtc>() {
                Ok(value) => value
                    .0
                    .format("%Y-%m-%d %H:%M:%S")
                    .to_string(),
                Err(_) => NOT_FOUND.to_string(),
            })
            .collect()
    }
}

#[extendr]
fn parse_datetime_rs(times: Vec<String>, formats: Vec<String>, out_format: &str) -> Vec<String> {
    // Use parallel processing for larger datasets
    if times.len() > 100 {
        times
            .par_iter()
            .map(|time_str| {
                for fmt in &formats {
                    if let Ok(naive_date) = NaiveDateTime::parse_from_str(time_str, fmt) {
                        return naive_date.format(out_format).to_string();
                    }
                }
                NOT_FOUND.to_string()
            })
            .collect()
    } else {
        times
            .iter()
            .map(|time_str| {
                for fmt in &formats {
                    if let Ok(naive_date) = NaiveDateTime::parse_from_str(time_str, fmt) {
                        return naive_date.format(out_format).to_string();
                    }
                }
                NOT_FOUND.to_string()
            })
            .collect()
    }
}
#[extendr]
fn parse_date_rs(times: Vec<String>, formats: Vec<String>, out_format: &str) -> Vec<String> {
    // Use parallel processing for larger datasets
    if times.len() > 100 {
        times
            .par_iter()
            .map(|time_str| {
                for fmt in &formats {
                    if let Ok(date) = NaiveDate::parse_from_str(time_str, fmt) {
                        if let Some(naive_datetime) = date.and_hms_milli_opt(0, 0, 0, 0) {
                            return naive_datetime.format(out_format).to_string();
                        }
                    }
                }
                NOT_FOUND.to_string()
            })
            .collect()
    } else {
        times
            .iter()
            .map(|time_str| {
                for fmt in &formats {
                    if let Ok(date) = NaiveDate::parse_from_str(time_str, fmt) {
                        if let Some(naive_datetime) = date.and_hms_milli_opt(0, 0, 0, 0) {
                            return naive_datetime.format(out_format).to_string();
                        }
                    }
                }
                NOT_FOUND.to_string()
            })
            .collect()
    }
}

#[extendr]
fn parse_epoch_rs(times: Vec<String>, out_format: &str) -> Vec<String> {
    // Use parallel processing for larger datasets
    if times.len() > 100 {
        times
            .par_iter()
            .map(|time_str| {
                if let Ok(epoch_seconds) = time_str.parse::<i64>() {
                    if let Some(dt) = DateTime::from_timestamp(epoch_seconds, 0) {
                        return dt.format(out_format).to_string();
                    }
                }
                NOT_FOUND.to_string()
            })
            .collect()
    } else {
        times
            .iter()
            .map(|time_str| {
                if let Ok(epoch_seconds) = time_str.parse::<i64>() {
                    if let Some(dt) = DateTime::from_timestamp(epoch_seconds, 0) {
                        return dt.format(out_format).to_string();
                    }
                }
                NOT_FOUND.to_string()
            })
            .collect()
    }
}

#[extendr]
fn parse_epoch_i64_rs(times: Vec<i32>, out_format: &str) -> Vec<String> {
    // Use parallel processing for larger datasets
    if times.len() > 100 {
        times
            .par_iter()
            .map(|&epoch| {
                DateTime::from_timestamp(epoch.into(), 0)
                    .map(|dt| dt.format(out_format).to_string())
                    .unwrap_or_else(|| NOT_FOUND.to_string())
            })
            .collect()
    } else {
        times
            .iter()
            .map(|&epoch| {
                DateTime::from_timestamp(epoch.into(), 0)
                    .map(|dt| dt.format(out_format).to_string())
                    .unwrap_or_else(|| NOT_FOUND.to_string())
            })
            .collect()
    }
}

extendr_module! {
    mod timeless;
    fn parse_guess_rs;
    fn parse_datetime_rs;
    fn parse_date_rs;
    fn parse_epoch_rs;
    fn parse_epoch_i64_rs;
}
