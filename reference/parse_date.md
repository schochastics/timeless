# Parse date from strings using different formats

Parse date from strings using different formats

## Usage

``` r
parse_date(x, formats = NULL, out_date = "%Y-%m-%d")
```

## Arguments

- x:

  A vector with date(time) expressions to be parsed and converted.

- formats:

  character vector of formats to try out (see
  [base::strptime](https://rdrr.io/r/base/strptime.html)). If NULL, uses
  a set of predefined formats mostly taken from the anytime package.

- out_date:

  character defining the date format of the parsed strings

## Value

character vector of parsed dates.
