#' Get Market data quotes
#'
#' @param isin character; ISIN of instrument to be retrieved.
# @param from character; Starting date to be retrieved in ISO format YYYY-mm-dd
#' @importFrom httr content
#' @importFrom zoo zoo
#' @export
get_quotes <- function(isin) {
  request_url <- sprintf("https://%s.lemon.markets/v1/quotes/?isin=%s&epoch=false",
                         get_data_url(),
                         isin)

  quotes <- request_lemon(request_url)
  quotes <- do.call(rbind, lapply(content(quotes)$results, data.frame))
  quotes$t <- as.POSIXct(quotes$t, tz="Europe/Vienna")
  quotes
}
