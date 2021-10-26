#' Get Portfolio Positions of Space
#'
#' @param space_id character; Space ID for which balance shall be retrieved. See also \code{list_spaces()}
#' @examples
#' \dontrun{
#' get_portfolio(space_id = "e44907b7-d131-4ec9-9647-a2649480003d")
#' }
#' @return data.frame including porfolio positions.
#' @export
portfolio <- function(space_id) {
  request_url <- sprintf("https://%s.lemon.markets/rest/v1/spaces/%s/portfolio/",
                         trading_url(), space_id)
  resp <- request_lemon(request_url)

  out <- do.call(rbind, lapply(content(resp)$results, data.frame))
  out$quantity <- as.integer(out$quantity)
  out$average_price <- as.numeric(out$average_price)
  out$latest_total_value <- as.numeric(out$latest_total_value)

  out
}
