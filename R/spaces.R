#' Get a List of All Spaces
#'
#' @examples
#' \dontrun{
#' list_spaces()
#' }
#' @export
spaces <- function() {
  request_url <- sprintf("https://%s.lemon.markets/rest/v1/spaces/", trading_url())
  resp <- request_lemon(request_url)
  out <- data.frame(content(resp)$results)
  out$state.balance <- as.numeric(out$state.balance)
  out$state.cash_to_invest <- as.numeric(out$state.cash_to_invest)
  out
}
