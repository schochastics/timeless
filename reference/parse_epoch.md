# Parse datetime from epoch

Parse datetime from epoch

## Usage

``` r
parse_epoch(x, tz = "", out_datetime = "%Y-%m-%d %H:%M:%S")
```

## Arguments

- x:

  A vector with date(time) expressions to be parsed and converted.

- tz:

  timezone of output datetime. If "", uses local timezone

- out_datetime:

  character defining the datetime format of the parsed strings

## Value

character vector of parsed dates.
