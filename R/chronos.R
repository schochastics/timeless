#' Fast general purpose parser for date(time) from input data
#'
#' @param x A vector with date(time) expressions to be parsed and converted.
#' @param formats character vector of formats to try out (see [base::strptime]).
#' If NULL, uses a set of predefined formats mostly taken from the anytime package.
#' @param out_format character. Defining the format of the returned result.
#' Can be "datetime", "date", or "character".
#' @param tz assumed input timezone. If "", uses local timezone. See details
#' @param to_tz convert datetime to timezone given in to_tz. If "", tz is used.
#' See details
#' @details The internal parsing is done "timezoneless". The timezone given in
#' tz is just added to the datetime without any conversion. If to_tz is given, a
#' conversion is made from tz to to_tz.
#' @return A character vector which can be transformed to `POSIXct` or date
#' @seealso [parse_datetime], [parse_date], and [parse_epoch] if you need more control over formatting
#' @examples
#' chronos(bench_date)
#' @export
chronos <- function(x, formats = NULL, tz = "", to_tz = "", out_format = "datetime") {
    UseMethod("chronos")
}

#' @export
chronos.factor <- function(x, formats = NULL, tz = "", to_tz = "", out_format = "datetime") {
    x <- as.character(x)
    NextMethod("chronos")
}

#' @export
chronos.integer <- function(x, formats = NULL, tz = "", to_tz = "", out_format = "datetime") {
    parse_epoch(x, tz = tz)
}

#' @export
chronos.numeric <- function(x, formats = NULL, tz = "", to_tz = "", out_format = "datetime") {
    parse_epoch(x, tz = tz)
}

#' @export
chronos.character <- function(x, formats = NULL, tz = "", to_tz = "", out_format = "datetime") {
    out_format <- match.arg(out_format, c("datetime", "date", "character"))
    res <- parse_datetime(x, formats)
    idx <- is.na(res)
    if (!any(idx)) {
        return(.return_parsed(res, tz = tz, to_tz = to_tz, format = out_format))
    }

    tmp <- parse_guess_rs(x[idx])
    res[idx] <- tmp
    idx <- res == "not found"
    if (!any(idx)) {
        return(.return_parsed(res, tz = tz, to_tz = to_tz, format = out_format))
    }

    if (out_format == "date") {
        tmp <- parse_date(x[idx], formats)
        res[idx] <- tmp
        idx <- is.na(res)
        if (!any(idx)) {
            return(.return_parsed(res, tz = tz, to_tz = to_tz, format = out_format))
        }
    }

    tmp <- parse_epoch(x[idx])
    res[idx] <- tmp
    idx <- is.na(res)
    if (!any(idx)) {
        return(.return_parsed(res, tz = tz, to_tz = to_tz, format = out_format))
    }

    if (out_format != "date") {
        tmp <- parse_date(x[idx], formats)
        tmp <- paste(tmp, "00:00:00")
        res[idx] <- tmp
    }
    res[is.na(res)] <- NA_character_
    return(.return_parsed(res, tz = tz, to_tz = to_tz, format = out_format))
}

#' @export
chronos.Date <- function(x, formats = NULL, tz = "", to_tz = "", out_format = "datetime") {
    if (out_format == "date") {
        return(x)
    } else if (out_format == "datetime") {
        return(as.POSIXct(paste(x, "00:00:00")))
    } else {
        as.character(x)
    }
}

#' @export
chronos.POSIXct <- function(x, formats = NULL, tz = "", to_tz = "", out_format = "datetime") {
    if (out_format == "datetime") {
        return(x)
    } else if (out_format == "date") {
        return(as.Date(x))
    } else {
        as.character(x)
    }
}

#' @export
chronos.default <- function(x, formats = NULL, tz = "", to_tz = "", out_format = "datetime") {
    stop(paste0(class(x), " not supported for chronos"), call. = FALSE)
}

#' Parse datetime from strings using different formats
#' @inheritParams chronos
#' @param out_datetime character defining the datetime format of the parsed strings
#' @return character vector of parsed datetimes
#' @export
parse_datetime <- function(x, formats = NULL, out_datetime = "%Y-%m-%d %H:%M:%S") {
    if (is.null(formats)) {
        formats <- formats_lst[["datetime"]]
    }
    res <- parse_datetime_rs(x, formats, out_datetime)
    res[res == "not found"] <- NA_character_
    res
}

#' Parse date from strings using different formats
#' @inheritParams chronos
#' @param out_date character defining the date format of the parsed strings
#' @return character vector of parsed dates.
#' @export
parse_date <- function(x, formats = NULL, out_date = "%Y-%m-%d") {
    if (is.null(formats)) {
        formats <- formats_lst[["date"]]
    }
    res <- parse_date_rs(x, formats, out_date)
    res[res == "not found"] <- NA_character_
    res
}

#' Parse datetime from epoch
#' @inheritParams chronos
#' @param out_datetime character defining the datetime format of the parsed strings
#' @param tz timezone of output datetime. If "", uses local timezone
#' @return character vector of parsed dates.
#' @export
parse_epoch <- function(x, tz = "", out_datetime = "%Y-%m-%d %H:%M:%S") {
    UseMethod("parse_epoch")
}

#' @export
parse_epoch.character <- function(x, tz = "", out_datetime = "%Y-%m-%d %H:%M:%S") {
    res <- parse_epoch_rs(x, out_datetime)
    res[res == "not found"] <- NA_character_
    res
}

#' @export
parse_epoch.integer <- function(x, tz = "", out_datetime = "%Y-%m-%d %H:%M:%S") {
    as.POSIXct(x, tz = tz)
}

#' @export
parse_epoch.numeric <- function(x, tz = "", out_datetime = "%Y-%m-%d %H:%M:%S") {
    as.POSIXct(x, tz = tz)
}

#' @export
parse_epoch.default <- function(x, tz = "", out_datetime = "%Y-%m-%d %H:%M:%S") {
    stop(paste0(class(x), " not supported for parse_epoch"), call. = FALSE)
}
