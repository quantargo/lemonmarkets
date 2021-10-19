#' Get Portfolio Positions of Space
#'
#' @param space_id character; Space ID for which balance shall be retrieved. See also \code{list_spaces()}
#' @examples
#' \dontrun{
#' get_portfolio(space_id = "e44907b7-d131-4ec9-9647-a2649480003d")
#' }
#' @return data.frame including porfolio positions.
#' @export
get_portfolio <- function(space_id) {
  request_url <- sprintf("https://%s.lemon.markets/rest/v1/spaces/%s/portfolio/",
                         get_trading_url(), space_id)
  resp <- request_lemon(request_url)

  out <- data.frame(content(resp)$results)
  out
}
