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

  ohcl <- xts(ohcl[, c("o", "h", "l", "c")], order.by = as.POSIXct(ohcl[, "t"]/1000, origin = "1970-01-01"))
  colnames(ohcl) <- c("open", "high", "low", "close")
  ohcl

}
