.char2datetime <- function(x, tz = "") {
    return(as.POSIXct(x, tz, format = "%Y-%m-%d %H:%M:%S"))
}

.char2date <- function(x, use_fasttime = FALSE) {
    return(as.Date(x))
}

.return_parsed <- function(x, tz = NULL, to_tz = NULL, format = "datetime") {
    if (format == "datetime") {
        res <- .char2datetime(x, tz = tz)
        if (!is.null(to_tz) && to_tz != "") {
            attr(res, "tzone") <- to_tz
        }
        return(res)
    } else if (format == "date") {
        return(.char2date(x))
    } else if (format == "character") {
        return(x)
    }
}
