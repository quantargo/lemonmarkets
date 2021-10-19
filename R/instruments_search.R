#' Retrieve tradable instruments
#'
#' @param search character; Search term to find requested instrument.
#' @param isin character; ISIN of instrument to be retrieved.
#' @param params list; search parameters to be specified in list.
#'   The list may contain the following elements:
#'   \describe{
#'     \item{mic}{Enter a Market Identifier Code (MIC) in there. Default is XMUN.}
#'     \item{isin}{Specify the ISIN you are interested in. You can also specify multiple ISINs. Maximum 10 ISINs per Request.}
#'     \item{search}{search for Name/Title, ISIN, WKN or symbol. You can also perform a partial search by only specifiying the first 4 symbols.}
#'     \item{type}{Search by Instrument type. Valid types: stock, bond, warrant, fund, etf.}
#'     \item{currency}{3 letter abbreviation, e.g. "EUR" or "USD"}
#'     \item{tradable}{TRUE or FALSE}
#'   }
#' @examples
#' \dontrun{
#'   instruments_search(search = "daimler")
#' }
#' @seealso \url{https://docs.lemon.markets/working-with-market-data#finding-a-stock}
#' @note Does not support pagination, therefore result limit of 100 instruments.
#' @export
instruments_search <- function(
  params = list(mic = NULL,
  isin = NULL,
  search = NULL,
  type = NULL,
  currency = NULL,
  tradable = NULL
 )) {
  query_params <- unlist(params, use.names = TRUE)

  search_string <- paste(names(query_params), query_params, sep="=", collapse = "&")
  if (search_string == "") {
    stop("Please specify either paramter search or isin to search for instruments.")
  }

  instr_url <- sprintf("https://%s.lemon.markets/v1/instruments/?%s",
                       get_data_url(),
                       search_string)
  resp <- request_lemon(instr_url)
  do.call(rbind, lapply(content(resp)$results, data.frame))
}
