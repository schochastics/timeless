
<!-- README.md is generated from README.Rmd. Please edit that file -->

# chronos <img src="man/figures/logo.png" align="right" height="139" alt="" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/schochastics/chronos/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/schochastics/chronos/actions/workflows/R-CMD-check.yaml)
[![CRAN
status](https://www.r-pkg.org/badges/version/chronos)](https://CRAN.R-project.org/package=chronos)
<!-- badges: end -->

A fast general purpose date/time converter using the Rust crate
[dateparser](https://crates.io/crates/dateparser) and
[chrono](https://crates.io/crates/chrono).

## Installation

You can install the development version of chronos like so:

``` r
remotes::install_github("schochastics/chronos")
#or
pak::pak("schochastics/chronos")
```

``` r
library(chronos)
```

## Formats

chronos understands 93 different date(time) formats out of the box

``` r
bench_date
#>  [1] "1511648546"                          "1620021848429"                      
#>  [3] "1620024872717915000"                 "2021-05-01T01:17:02.604456Z"        
#>  [5] "2017-11-25T22:34:50Z"                "Wed, 02 Jun 2021 06:31:39 GMT"      
#>  [7] "2019-11-29 08:08-08"                 "2019-11-29 08:08:05-08"             
#>  [9] "2021-05-02 23:31:36.0741-07"         "2021-05-02 23:31:39.12689-07"       
#> [11] "2019-11-29 08:15:47.624504-08"       "2017-07-19 03:21:51+00:00"          
#> [13] "2014-04-26 05:24:37 PM"              "2021-04-30 21:14"                   
#> [15] "2021-04-30 21:14:10"                 "2021-04-30 21:14:10.052282"         
#> [17] "2014-04-26 17:24:37.123"             "2014-04-26 17:24:37.3186369"        
#> [19] "2012-08-03 18:31:59.257000000"       "2017-11-25 13:31:15 PST"            
#> [21] "2017-11-25 13:31 PST"                "2014-12-16 06:20:00 UTC"            
#> [23] "2014-12-16 06:20:00 GMT"             "2014-04-26 13:13:43 +0800"          
#> [25] "2014-04-26 13:13:44 +09:00"          "2012-08-03 18:31:59.257000000 +0000"
#> [27] "2015-09-30 18:48:56.35272715 UTC"    "2021-02-21"                         
#> [29] "2021-02-21 PST"                      "2021-02-21 UTC"                     
#> [31] "2020-07-20+08:00"                    "01:06:06"                           
#> [33] "4:00pm"                              "6:00 AM"                            
#> [35] "01:06:06 PST"                        "4:00pm PST"                         
#> [37] "6:00 AM PST"                         "6:00pm UTC"                         
#> [39] "May 6 at 9:24 PM"                    "May 27 02:45:27"                    
#> [41] "May 8, 2009 5:57:51 PM"              "September 17, 2012 10:09am"         
#> [43] "September 17, 2012, 10:10:09"        "May 02, 2021 15:51:31 UTC"          
#> [45] "May 02, 2021 15:51 UTC"              "May 26, 2021, 12:49 AM PDT"         
#> [47] "September 17, 2012 at 10:09am PST"   "2021-Feb-21"                        
#> [49] "May 25, 2021"                        "oct 7, 1970"                        
#> [51] "oct 7, 70"                           "oct. 7, 1970"                       
#> [53] "oct. 7, 70"                          "October 7, 1970"                    
#> [55] "12 Feb 2006, 19:17"                  "12 Feb 2006 19:17"                  
#> [57] "14 May 2019 19:11:40.164"            "7 oct 70"                           
#> [59] "7 oct 1970"                          "03 February 2013"                   
#> [61] "1 July 2013"                         "4/8/2014 22:05"                     
#> [63] "04/08/2014 22:05"                    "4/8/14 22:05"                       
#> [65] "04/2/2014 03:00:51"                  "8/8/1965 12:00:00 AM"               
#> [67] "8/8/1965 01:00:01 PM"                "8/8/1965 01:00 PM"                  
#> [69] "8/8/1965 1:00 PM"                    "8/8/1965 12:00 AM"                  
#> [71] "4/02/2014 03:00:51"                  "03/19/2012 10:11:59"                
#> [73] "03/19/2012 10:11:59.3186369"         "3/31/2014"                          
#> [75] "03/31/2014"                          "08/21/71"                           
#> [77] "8/1/71"                              "2014/4/8 22:05"                     
#> [79] "2014/04/08 22:05"                    "2014/04/2 03:00:51"                 
#> [81] "2014/4/02 03:00:51"                  "2012/03/19 10:11:59"                
#> [83] "2012/03/19 10:11:59.3186369"         "2014/3/31"                          
#> [85] "2014/03/31"                          "3.31.2014"                          
#> [87] "03.31.2014"                          "08.21.71"                           
#> [89] "2014.03.30"                          "2014.03"                            
#> [91] "171113 14:14:20"                     "2014年04月08日11时25分18秒"         
#> [93] "2014年04月08日"
```

plus all formats supported by
[anytime](https://github.com/eddelbuettel/anytime).

`chronos()` parses each date(time) into a character with a form that can
be easily transformed into a `date` or `POSIXct` object by any standard
datetime R function. (**This will eventually be included in chronos**)

``` r
chronos(bench_date)
#>  [1] "2017-11-25 22:22:26" "2021-05-03 06:04:08" "2021-05-03 06:54:32"
#>  [4] "2021-05-01 01:17:02" "2017-11-25 22:34:50" "2021-06-02 06:31:39"
#>  [7] "2019-11-29 16:08:00" "2019-11-29 16:08:05" "2021-05-03 06:31:36"
#> [10] "2021-05-03 06:31:39" "2019-11-29 16:15:47" "2017-07-19 03:21:51"
#> [13] "2014-04-26 15:24:37" "2021-04-30 19:14:00" "2021-04-30 19:14:10"
#> [16] "2021-04-30 19:14:10" "2014-04-26 15:24:37" "2014-04-26 15:24:37"
#> [19] "2012-08-03 16:31:59" "2017-11-25 21:31:15" "2017-11-25 21:31:00"
#> [22] "2014-12-16 06:20:00" "2014-12-16 06:20:00" "2014-04-26 05:13:43"
#> [25] "2014-04-26 04:13:44" "2012-08-03 18:31:59" "2015-09-30 18:48:56"
#> [28] "2021-02-21 21:45:53" "2021-02-21 21:45:53" "2021-02-21 21:45:53"
#> [31] "2020-07-19 21:45:53" "2024-02-24 00:06:06" "2024-02-24 15:00:00"
#> [34] "2024-02-24 05:00:00" "2024-02-24 09:06:06" "2024-02-25 00:00:00"
#> [37] "2024-02-24 14:00:00" "2024-02-24 18:00:00" "2024-05-06 19:24:00"
#> [40] "2024-05-27 00:45:27" "2009-05-08 15:57:51" "2012-09-17 08:09:00"
#> [43] "2012-09-17 08:10:09" "2021-05-02 15:51:31" "2021-05-02 15:51:00"
#> [46] "2021-05-26 07:49:00" "2012-09-17 18:09:00" "2021-02-21 21:45:53"
#> [49] "2021-05-25 20:45:53" "1970-10-07 21:45:53" "1970-10-07 21:45:53"
#> [52] "1970-10-07 21:45:53" "1970-10-07 21:45:53" "1970-10-07 21:45:53"
#> [55] "2006-02-12 18:17:00" "2006-02-12 18:17:00" "2019-05-14 17:11:40"
#> [58] "1970-10-07 21:45:53" "1970-10-07 21:45:53" "2013-02-03 21:45:53"
#> [61] "2013-07-01 20:45:53" "2014-04-08 20:05:00" "2014-04-08 20:05:00"
#> [64] "2014-04-08 20:05:00" "2014-04-02 01:00:51" "1965-08-07 23:00:00"
#> [67] "1965-08-08 12:00:01" "1965-08-08 12:00:00" "1965-08-08 12:00:00"
#> [70] "1965-08-07 23:00:00" "2014-04-02 01:00:51" "2012-03-19 09:11:59"
#> [73] "2012-03-19 09:11:59" "2014-03-31 20:45:53" "2014-03-31 20:45:53"
#> [76] "1971-08-21 21:45:53" "1971-08-01 21:45:53" "2014-04-08 20:05:00"
#> [79] "2014-04-08 20:05:00" "2014-04-02 01:00:51" "2014-04-02 01:00:51"
#> [82] "2012-03-19 09:11:59" "2012-03-19 09:11:59" "2014-03-31 20:45:53"
#> [85] "2014-03-31 20:45:53" "2014-03-31 20:45:53" "2014-03-31 20:45:53"
#> [88] "1971-08-21 21:45:53" "2014-03-30 20:45:53" "2014-03-24 21:45:53"
#> [91] "2017-11-13 13:14:20" "2014-04-08 09:25:18" "2014-04-08 20:45:53"
```

## Functions

`chronos()` is the powerhouse of the package and tries as hard as
possible to parse every input. under the hood it calls three functions
which can also be used in isolation:

-   `parse_datetime()`: a fast datetime parser that tries several
    different formats until it can parse the input

-   `parse_date()`: a fast date parser that tries several different
    formats until it can parse the input

-   `parse_epoch()`: a fast epoch timestamp parser

## other packages

[anytime](https://github.com/eddelbuettel/anytime) is the most accepted
general purpose date(time) converter.

It does not recognize all accepted formats of chronos out of the box

``` r
dplyr::coalesce(
    anytime::anytime(bench_date),
    anytime::anydate(bench_date)
)
#>  [1] NA                         "1620-02-17 23:53:28 LMT" 
#>  [3] NA                         "2021-05-01 01:17:02 CEST"
#>  [5] "2017-11-25 22:34:50 CET"  "2021-06-02 06:31:39 CEST"
#>  [7] "2019-11-29 08:08:08 CET"  "2019-11-29 08:08:05 CET" 
#>  [9] "2021-05-02 23:31:36 CEST" "2021-05-02 23:31:39 CEST"
#> [11] "2019-11-29 08:15:47 CET"  "2017-07-19 03:21:51 CEST"
#> [13] "2014-04-26 05:24:37 CEST" "2021-04-30 21:14:00 CEST"
#> [15] "2021-04-30 21:14:10 CEST" "2021-04-30 21:14:10 CEST"
#> [17] "2014-04-26 17:24:37 CEST" "2014-04-26 17:24:37 CEST"
#> [19] "2012-08-03 18:31:59 CEST" "2017-11-25 13:31:15 CET" 
#> [21] "2017-11-25 00:00:00 CET"  "2014-12-16 06:20:00 CET" 
#> [23] "2014-12-16 06:20:00 CET"  "2014-04-26 13:13:43 CEST"
#> [25] "2014-04-26 13:13:44 CEST" "2012-08-03 18:31:59 CEST"
#> [27] "2015-09-30 18:48:56 CEST" "2021-02-21 00:00:00 CET" 
#> [29] "2021-02-21 00:00:00 CET"  "2021-02-21 00:00:00 CET" 
#> [31] "2020-07-20 08:00:00 CEST" NA                        
#> [33] NA                         NA                        
#> [35] NA                         NA                        
#> [37] NA                         NA                        
#> [39] NA                         NA                        
#> [41] "2009-05-08 00:00:00 CEST" "2012-09-17 00:00:00 CEST"
#> [43] "2012-09-17 00:00:00 CEST" "2021-05-02 00:00:00 CEST"
#> [45] "2021-05-02 00:00:00 CEST" "2021-05-26 00:00:00 CEST"
#> [47] "2012-09-17 00:00:00 CEST" "2021-02-21 00:00:00 CET" 
#> [49] "2021-05-25 00:00:00 CEST" "1970-10-07 00:00:00 CET" 
#> [51] NA                         "1970-10-07 00:00:00 CET" 
#> [53] NA                         "1970-10-07 00:00:00 CET" 
#> [55] "2006-02-12 00:00:00 CET"  "2006-02-12 19:17:00 CET" 
#> [57] "2019-05-14 19:11:40 CEST" NA                        
#> [59] "1970-10-07 00:00:00 CET"  "2013-02-03 00:00:00 CET" 
#> [61] "2013-07-01 00:00:00 CEST" "2014-04-08 22:05:00 CEST"
#> [63] "2014-04-08 22:05:00 CEST" NA                        
#> [65] "2014-04-02 03:00:51 CEST" "1965-08-08 00:00:00 CET" 
#> [67] "1965-08-08 00:00:00 CET"  "1965-08-08 00:00:00 CET" 
#> [69] "1965-08-08 00:00:00 CET"  "1965-08-08 00:00:00 CET" 
#> [71] "2014-04-02 03:00:51 CEST" "2012-03-19 10:11:59 CET" 
#> [73] "2012-03-19 10:11:59 CET"  "2014-03-31 00:00:00 CEST"
#> [75] "2014-03-31 00:00:00 CEST" NA                        
#> [77] NA                         "2014-04-08 22:05:00 CEST"
#> [79] "2014-04-08 22:05:00 CEST" "2014-04-02 03:00:51 CEST"
#> [81] "2014-04-02 03:00:51 CEST" "2012-03-19 10:11:59 CET" 
#> [83] "2012-03-19 10:11:59 CET"  "2014-03-31 00:00:00 CEST"
#> [85] "2014-03-31 00:00:00 CEST" "2014-03-31 00:00:00 CEST"
#> [87] "2014-03-31 00:00:00 CEST" NA                        
#> [89] "2014-03-30 00:00:00 CET"  "2014-03-01 00:00:00 CET" 
#> [91] "1711-03-14 14:13:28 LMT"  NA                        
#> [93] NA
```

The list of formats supported out-of-the-box can be retrieved with
`anytime::getFormats()`. `chronos` implements these formats natively
too.

Concerning runtime, `chronos` seems to be quite a bit faster than
`anytime`.

``` r
microbenchmark::microbenchmark(
    chronos(bench_date),
    anytime::anytime(bench_date)
)
#> Unit: microseconds
#>                          expr       min        lq      mean    median        uq
#>           chronos(bench_date)   206.619   222.784   298.873   262.221   341.232
#>  anytime::anytime(bench_date) 30547.359 32948.543 35276.276 34722.712 37066.449
#>        max neval
#>    839.685   100
#>  55435.301   100
```

Note however that chronos does return only a character vector that needs
to be converted to a `POSIXct`. This could be done efficiently with
[fasttime](https://github.com/s-u/fasttime)

**Disclaimer**:  
While it might seem that `chronos` has an edge over `anytime`, it is far
less battle tested and robust. I am grateful for everyone who can take
the package for a spin and report issues.
