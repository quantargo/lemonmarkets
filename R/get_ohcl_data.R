#' Get Market data in OHCL Format
#'
#' @param isin character; ISIN of instrument to be retrieved.
#' @param freq character; Frequency of time series to be retrieved, one of 'daily', 'hourly', 'min'
#' @param interval character; Interval of time series, defaults to 1. E.g. freq = "hourly" and interval = 2 means every to hours.
#' @param from character; Starting date to be retrieved in ISO format YYYY-mm-dd
#' @param is_live logical; Specify if data through live API shall be retrieved.
#' @importFrom httr content
#' @importFrom zoo zoo
#' @export
get_ohcl_data <- function(
  isin,
  freq = "daily",
  interval = 1,
  from = Sys.Date() - 30,
  is_live = Sys.getenv("LEMON_MARKETS_IS_LIVE", FALSE)) {

  request_url <- sprintf("https://%s.lemon.markets/v1/ohlc/d1/?isin=%s&epoch=false&from=%s",
                         isin,
                         from)

  ohcl <- request_lemon(request_url)
  ohcl <- do.call(rbind, lapply(content(ohcl)$results, data.frame))

  ohcl <- zoo(ohcl[, c("o", "h", "l", "c")], order.by = as.POSIXct(ohcl[, "t"]/1000, origin = "1970-01-01"))
  colnames(ohcl) <- c("open", "high", "low", "close")
  ohcl

}
