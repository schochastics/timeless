test_that("chronos works with supported formats", {
    skip_on_cran()
    time <- as.POSIXct("2024-02-26 13:14:00")
    fmt <- formats_lst[["datetime"]][!grepl("%Z", formats_lst[["datetime"]])]
    times <- unique(as.character(sapply(fmt, function(x) format(time, format = x), USE.NAMES = FALSE)))
    expect_true(all(chronos(times) == time))

    date <- as.Date("2024-02-26")
    fmt <- formats_lst[["date"]]
    dates <- as.character(sapply(fmt, function(x) format(date, format = x), USE.NAMES = FALSE))
    expect_true(all(chronos(dates, out_format = "date") == date))

    expect_true(!any(is.na(chronos(bench_date))))
})

test_that("timezone conversion #14", {
    res <- chronos(bench_date[5], tz = "CET", to_tz = "UTC")
    expect_equal(res, as.POSIXct("2017-11-25 21:34:50", tz = "UTC"))
})
