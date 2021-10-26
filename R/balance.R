#' Get Balance of Account or Space
#'
#' @param space_id character; Optional space ID for which balance shall be retrieved. See also \code{list_spaces()}
#' @examples
#' \dontrun{
#' balance()
#' balance(space_id = "e44907b7-d131-4ec9-9647-a2649480003d")
#' }
#' @export
balance <- function(space_id = NULL) {
  stopifnot(length(space_id) <= 1)

  balance_url <- character(0)

  if (is.null(space_id)) {
    balance_url <- sprintf("https://%s.lemon.markets/rest/v1/state/",
                           trading_url())
  } else {
    balance_url <- sprintf("https://%s.lemon.markets/rest/v1/spaces/%s/state/",
                           trading_url(),
                           space_id)
  }

  resp <- request_lemon(balance_url)

  bal <- NULL
  if (is.null(space_id)) {
    bal <- content(resp)$state$balance
  } else {
    bal <- content(resp)$balance
  }
  as.numeric(bal)
}
