#' Parse Date from input data
#'
#' This function uses the dateparser crate from Rust to parse datetimes (and
#' dates) from strings.
#' @param x A vector of type character with date(time) expressions to be parsed and converted.
#'
#' @return A character vector which can be transformed to `POSIXct` or date
#' @examples
#' chronos(bench_date)
#' @export
chronos <- function(x) {
    res <- chronos_rs(x)
    res[res == "false"] <- NA
    res
}
