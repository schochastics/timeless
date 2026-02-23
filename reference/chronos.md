# Fast general purpose parser for date(time) from input data

Fast general purpose parser for date(time) from input data

## Usage

``` r
chronos(x, formats = NULL, tz = "", to_tz = "", out_format = "datetime")
```

## Arguments

- x:

  A vector with date(time) expressions to be parsed and converted.

- formats:

  character vector of formats to try out (see
  [base::strptime](https://rdrr.io/r/base/strptime.html)). If NULL, uses
  a set of predefined formats mostly taken from the anytime package.

- tz:

  assumed input timezone. If "", uses local timezone. See details

- to_tz:

  convert datetime to timezone given in to_tz. If "", tz is used. See
  details

- out_format:

  character. Defining the format of the returned result. Can be
  "datetime", "date", or "character".

## Value

A character vector which can be transformed to `POSIXct` or date

## Details

The internal parsing is done "timezoneless". The timezone given in tz is
just added to the datetime without any conversion. If to_tz is given, a
conversion is made from tz to to_tz.

## See also

[parse_datetime](https://schochastics.github.io/chronos/reference/parse_datetime.md),
[parse_date](https://schochastics.github.io/chronos/reference/parse_date.md),
and
[parse_epoch](https://schochastics.github.io/chronos/reference/parse_epoch.md)
if you need more control over formatting

## Examples

``` r
chronos(bench_date)
#>  [1] "2017-11-25 22:22:26 UTC" "2021-05-03 06:04:08 UTC"
#>  [3] "2021-05-03 06:54:32 UTC" "2021-05-01 01:17:02 UTC"
#>  [5] "2017-11-25 22:34:50 UTC" "2021-06-02 06:31:39 UTC"
#>  [7] "2019-11-29 16:08:00 UTC" "2019-11-29 08:08:05 UTC"
#>  [9] "2021-05-02 23:31:36 UTC" "2021-05-02 23:31:39 UTC"
#> [11] "2019-11-29 08:15:47 UTC" "2017-07-19 03:21:51 UTC"
#> [13] "2014-04-26 17:24:37 UTC" "2021-04-30 21:14:00 UTC"
#> [15] "2021-04-30 21:14:10 UTC" "2021-04-30 21:14:10 UTC"
#> [17] "2014-04-26 17:24:37 UTC" "2014-04-26 17:24:37 UTC"
#> [19] "2012-08-03 18:31:59 UTC" "2017-11-25 21:31:15 UTC"
#> [21] "2017-11-25 21:31:00 UTC" "2014-12-16 06:20:00 UTC"
#> [23] "2014-12-16 06:20:00 UTC" "2014-04-26 05:13:43 UTC"
#> [25] "2014-04-26 04:13:44 UTC" "2012-08-03 18:31:59 UTC"
#> [27] "2015-09-30 18:48:56 UTC" "2021-02-21 05:44:55 UTC"
#> [29] "2021-02-22 05:44:55 UTC" "2021-02-21 05:44:55 UTC"
#> [31] "2020-07-20 05:44:55 UTC" "2026-02-23 01:06:06 UTC"
#> [33] "2026-02-23 16:00:00 UTC" "2026-02-23 06:00:00 UTC"
#> [35] "2026-02-22 09:06:06 UTC" "2026-02-23 00:00:00 UTC"
#> [37] "2026-02-22 14:00:00 UTC" "2026-02-23 18:00:00 UTC"
#> [39] "2026-05-06 21:24:00 UTC" "2026-05-27 02:45:27 UTC"
#> [41] "2009-05-08 17:57:51 UTC" "2012-09-17 10:09:00 UTC"
#> [43] "2012-09-17 10:10:09 UTC" "2021-05-02 15:51:31 UTC"
#> [45] "2021-05-02 15:51:00 UTC" "2021-05-26 07:49:00 UTC"
#> [47] "2012-09-17 18:09:00 UTC" "2021-02-21 05:44:55 UTC"
#> [49] "2021-05-25 05:44:55 UTC" "1970-10-07 05:44:55 UTC"
#> [51] "1970-10-07 05:44:55 UTC" "1970-10-07 05:44:55 UTC"
#> [53] "1970-10-07 05:44:55 UTC" "1970-10-07 05:44:55 UTC"
#> [55] "2006-02-12 19:17:00 UTC" "2006-02-12 19:17:00 UTC"
#> [57] "2019-05-14 19:11:40 UTC" "1970-10-07 05:44:55 UTC"
#> [59] "1970-10-07 05:44:55 UTC" "2013-02-03 05:44:55 UTC"
#> [61] "2013-07-01 05:44:55 UTC" "2014-04-08 22:05:00 UTC"
#> [63] "2014-04-08 22:05:00 UTC" "2014-04-08 22:05:00 UTC"
#> [65] "2014-02-04 03:00:51 UTC" "1965-08-08 00:00:00 UTC"
#> [67] "1965-08-08 13:00:01 UTC" "1965-08-08 13:00:00 UTC"
#> [69] "1965-08-08 13:00:00 UTC" "1965-08-08 00:00:00 UTC"
#> [71] "2014-02-04 03:00:51 UTC" "2012-03-19 10:11:59 UTC"
#> [73] "2012-03-19 10:11:59 UTC" "2014-03-31 05:44:55 UTC"
#> [75] "2014-03-31 05:44:55 UTC" "1971-08-21 05:44:55 UTC"
#> [77] "1971-08-01 05:44:55 UTC" "2014-04-08 22:05:00 UTC"
#> [79] "2014-04-08 22:05:00 UTC" "2014-04-02 03:00:51 UTC"
#> [81] "2014-04-02 03:00:51 UTC" "2012-03-19 10:11:59 UTC"
#> [83] "2012-03-19 10:11:59 UTC" "2014-03-31 05:44:55 UTC"
#> [85] "2014-03-31 05:44:55 UTC" "2014-03-31 05:44:55 UTC"
#> [87] "2014-03-31 05:44:55 UTC" "1971-08-21 05:44:55 UTC"
#> [89] "2014-03-30 05:44:55 UTC" "2014-03-23 05:44:55 UTC"
#> [91] "2017-11-13 14:14:20 UTC" "2014-04-08 11:25:18 UTC"
#> [93] "2014-04-08 05:44:55 UTC"
```
