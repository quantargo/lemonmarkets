#' Create Order
#'
#' @param space_id character; Space ID for which balance shall be retrieved. See also \code{list_spaces()}
#' @param quantity integer; Number of stocks to be bought/sold.
#' @param valid_until POSIXct; Time until order shall be valid.
#' @param activate logical; Automatically activate order.
#' @param isin character; ISIN of instrument to be retrieved.
# @param from character; Starting date to be retrieved in ISO format YYYY-mm-dd
#' @importFrom httr content
#' @importFrom zoo zoo
#' @examples
#' \dontrun{
#'   create_order(space_id = "e44907b7-d131-4ec9-9647-a2649480003d",
#'                isin = "DE0008404005",
#'                quantity = 1)
#' }
#' @export
create_order <- function(space_id, isin, quantity, valid_until = Sys.time() + 86400, activate = TRUE) {
  side <- ifelse(quantity >= 0, "buy", "sell")

  request_url <- sprintf("https://%s.lemon.markets/rest/v1/spaces/%s/orders/?isin=%s&side=%s&quantity=%d&valid_until=%d",
                         get_trading_url(),
                         space_id,
                         isin,
                         side,
                         abs(quantity),
                         as.integer(unclass(valid_until)))

  out <- request_lemon(request_url)
  data.frame(content(out)$results)
}

