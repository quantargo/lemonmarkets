#' Get Balance of Account or Space
#'
#' @examples
#' \dontrun{
#' balance()
#' balance(space_id = "69fc7fbe-802d-4cd4-9f02-8965536c6896")
#' }
#' @export
balance <- function(space_id = NULL) {
  balance_url <- character(0)
  if (is.null(space_id)) {
    balance_url <- sprintf("https://%s.lemon.markets/rest/v1/state/",
                           get_trading_url())
  } else {
    balance_url <- sprintf("https://%s.lemon.markets/rest/v1/spaces/%s/state/",
                           get_trading_url(),
                           space_id)
  }

  resp <- request_lemon(balance_url)
  as.numeric(content(resp)$state$balance)
}
