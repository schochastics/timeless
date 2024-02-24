#' General purpose parser for Dates from input data
#'
#' This function uses the dateparser and chrono crates from Rust to parse datetimes (and
#' dates) from strings.
#' @param x A vector of type character with date(time) expressions to be parsed and converted.
#'
#' @return A character vector which can be transformed to `POSIXct` or date
#' @seealso [parse_datetime] and [parse_date] if you need more control over formatting
#' @examples
#' chronos(bench_date)
#' @export
chronos <- function(x) {
    res <- parse_guess_rs(x)
    idx <- res == "not found"
    if (!any(idx)) {
        return(res)
    } else {
        tmp <- parse_datetime(x[idx])
        res[idx] <- tmp
        idx <- res == "not found"
        if (!any(idx)) {
            return(res)
        } else {
            tmp <- parse_date(x[idx])
            res[idx] <- tmp
            res[res == "not found"] <- NA
            return(res)
        }
    }
}

#' Parse datetime from strings using different formats
#' @inheritParams chronos
#' @param formats character vector of formats to try out (see [base::strptime]).
#' If missing, uses a set of predefined formats from the anytime package.
#' @param out_format character defining the format of the parsed strings
#' @return character vector of parsed datetimes
#' @export
parse_datetime <- function(x, formats, out_format = "%Y-%m-%d %H:%M:%S") {
    if (missing(formats)) {
        formats <- formats_lst[["datetime"]]
    }
    res <- parse_datetime_rs(x, formats, out_format)
    res
}

#' Parse date from strings using different formats
#' @inheritParams parse_datetime
#' @return character vector of parsed dates.
#' @export
parse_date <- function(x, formats, out_format = "%Y-%m-%d") {
    if (missing(formats)) {
        formats <- formats_lst[["date"]]
    }
    res <- parse_date_rs(x, formats, out_format)
    res
}
