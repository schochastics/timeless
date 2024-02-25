.char2datetime <- function(x, tz = NULL) {
    if (requireNamespace("fasttime", quietly = TRUE)) {
        return(fasttime::fastPOSIXct(x, tz = tz))
    } else {
        if (is.null(tz)) {
            tz <- ""
        }
        return(as.POSIXct(x, tz))
    }
}

.char2date <- function(x) {
    if (requireNamespace("fasttime", quietly = TRUE)) {
        return(fasttime::fastDate(x))
    } else {
        return(as.Date(x))
    }
}
