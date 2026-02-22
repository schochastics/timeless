# Parse datetime from strings using different formats

Parse datetime from strings using different formats

## Usage

``` r
parse_datetime(x, formats = NULL, out_datetime = "%Y-%m-%d %H:%M:%S")
```

## Arguments

- x:

  A vector with date(time) expressions to be parsed and converted.

- formats:

  character vector of formats to try out (see
  [base::strptime](https://rdrr.io/r/base/strptime.html)). If NULL, uses
  a set of predefined formats mostly taken from the anytime package.

- out_datetime:

  character defining the datetime format of the parsed strings

## Value

character vector of parsed datetimes
