#' Get a List of All Spaces
#'
#' @examples
#' \dontrun{
#' list_spaces()
#' }
#' @export
list_spaces <- function() {
  request_url <- sprintf("https://%s.lemon.markets/rest/v1/spaces/", get_trading_url())
  resp <- lemonmarkets:::request_lemon(request_url)
  data.frame(content(resp)$results)
}
