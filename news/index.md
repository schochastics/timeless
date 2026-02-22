# Changelog

## timeless 0.2.4.9000

- added more formats supporting subseconds

## timeless 0.2.4

CRAN release: 2024-08-31

- fixed missing rustc version

## timeless 0.2.3

CRAN release: 2024-07-04

- proper Makefile and pkg vendoring
  [\#19](https://github.com/schochastics/timeless/issues/19)
- fix deprecated warnings
  [\#20](https://github.com/schochastics/timeless/issues/20)

## timeless 0.2.2

CRAN release: 2024-07-02

- fix CRAN issue due to C level changes h/t
  [@JosiahParry](https://github.com/JosiahParry)

## timeless 0.2.1

CRAN release: 2024-03-31

- hotfix CRAN issue

## timeless 0.2.0

CRAN release: 2024-03-29

- made all functions “timezone free”
- added to_tz parameter for timezone conversion
  [\#14](https://github.com/schochastics/timeless/issues/14)

## timeless 0.1.0

CRAN release: 2024-03-04

- implemented
  [`chronos()`](https://schochastics.github.io/chronos/reference/chronos.md)
  as general purpose parser
- implemented
  [`parse_datetime()`](https://schochastics.github.io/chronos/reference/parse_datetime.md),
  [`parse_epoch()`](https://schochastics.github.io/chronos/reference/parse_epoch.md),
  and
  [`parse_date()`](https://schochastics.github.io/chronos/reference/parse_date.md)
  for more control over formatting
