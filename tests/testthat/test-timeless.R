test_that("chronos works with supported formats", {
    time <- as.POSIXct("2024-02-26 13:14:00")
    fmt <- formats_lst[["datetime"]][!grepl("%Z", formats_lst[["datetime"]])]
    times <- as.character(sapply(fmt, function(x) format(time, format = x), USE.NAMES = FALSE))
    expect_true(all(chronos(times) == time))

    date <- as.Date("2024-02-26")
    fmt <- formats_lst[["date"]]
    dates <- as.character(sapply(fmt, function(x) format(date, format = x), USE.NAMES = FALSE))
    expect_true(all(chronos(dates, out_format = "date") == date))

    expect_true(!any(is.na(chronos(bench_date))))
})
