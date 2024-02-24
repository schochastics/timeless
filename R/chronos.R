#' General purpose parser for Dates from input data
#'
#' This function uses the dateparser and chrono crates from Rust to parse datetimes (and
#' dates) from strings.
#' @param x A vector of type character with date(time) expressions to be parsed and converted.
#' @param formats character vector of formats to try out (see [base::strptime]).
#' If NULL, uses a set of predefined formats mostly taken from the anytime package.
#' @param out_datetime character defining the datetime format of the parsed strings
#' @param out_date character defining the date format of the parsed strings
#' @return A character vector which can be transformed to `POSIXct` or date
#' @seealso [parse_datetime] and [parse_date] if you need more control over formatting
#' @examples
#' chronos(bench_date)
#' @export
chronos <- function(x, formats = NULL, out_datetime = "%Y-%m-%d %H:%M:%S", out_date = "%Y-%m-%d") {
    res <- parse_guess_rs(x)
    idx <- res == "not found"
    if (!any(idx)) {
        return(res)
    } else {
        tmp <- parse_datetime(x[idx], formats, out_datetime)
        res[idx] <- tmp
        idx <- res == "not found"
        if (!any(idx)) {
            return(res)
        } else {
            tmp <- parse_date(x[idx], formats, out_date)
            res[idx] <- tmp
            res[res == "not found"] <- NA
            return(res)
        }
    }
}

#' Parse datetime from strings using different formats
#' @inheritParams chronos
#' @return character vector of parsed datetimes
#' @export
parse_datetime <- function(x, formats = NULL, out_datetime = "%Y-%m-%d %H:%M:%S") {
    if (is.null(formats)) {
        formats <- formats_lst[["datetime"]]
    }
    res <- parse_datetime_rs(x, formats, out_datetime)
    res
}

#' Parse date from strings using different formats
#' @inheritParams chronos
#' @return character vector of parsed dates.
#' @export
parse_date <- function(x, formats = NULL, out_date = "%Y-%m-%d") {
    if (is.null(formats)) {
        formats <- formats_lst[["date"]]
    }
    res <- parse_date_rs(x, formats, out_date)
    res
}
