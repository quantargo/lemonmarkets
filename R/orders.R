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
#' @rdname orders
create_order <- function(space_id, isin, quantity, valid_until = Sys.time() + 86400, activate = TRUE) {
  side <- ifelse(quantity >= 0, "buy", "sell")

  request_url <- sprintf("https://%s.lemon.markets/rest/v1/spaces/%s/orders",
                         get_trading_url(),
                         space_id)

  request_body <- list(
    isin = isin,
    side = side,
    quantity = abs(quantity),
    valid_until = as.integer(unclass(valid_until))
  )

  out <- request_post_lemon(request_url, body = request_body)
  df_out <- data.frame(t(content(out)))

  if (activate & !is.null(df_out$uuid)) {
    df_out$status <- activate_order(space_id, df_out$uuid)
  }
  df_out
}


#' Get Orders of Space
#'
#' @param space_id character; Space ID for which balance shall be retrieved. See also \code{list_spaces()}
#' @examples
#' \dontrun{
#' get_orders(space_id = "e44907b7-d131-4ec9-9647-a2649480003d")
#' }
#' @return data.frame including orders
#' @export
#' @rdname orders
get_orders <- function(space_id) {
  request_url <- sprintf("https://%s.lemon.markets/rest/v1/spaces/%s/orders",
                         get_trading_url(), space_id)
  resp <- request_lemon(request_url)

  out <- content(resp)$results
  out <- do.call(rbind, lapply(out, function(x) data.frame(lapply(x, function(y) if(is.null(y)) NA else y))))
  out
}

#' @importFrom httr DELETE
#' @param order_id character; UUID of order to be deleted.
#' @export
#' @rdname orders
delete_order <- function(space_id, order_id) {
  request_url <- sprintf("https://%s.lemon.markets/rest/v1/spaces/%s/orders/%s/",
                         get_trading_url(),
                         space_id,
                         order_id)

  out <- request_lemon(request_url, DELETE)
  content(out)
}

#' @importFrom httr PUT
#' @param verbose logical; Specify if output shall be printed to the console.
#' @export
#' @rdname orders
activate_order <- function(space_id, order_id, verbose = getOption("verbose")) {
  request_url <- sprintf("https://%s.lemon.markets/rest/v1/spaces/%s/orders/%s/activate/",
                         get_trading_url(),
                         space_id,
                         order_id)
  out <- request_lemon(request_url, PUT)
  if (verbose) cat("Status of order '%s' successfully changed to '%s'", order_id, out$status)
  out$status
}
