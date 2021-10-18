# Retrieve tradable instruments
# instruments_search(search = "daimler")
#' @export
instruments_search <- function(search = NULL, isin = NULL) {
  search_string <- paste(unlist(list(search = search, isin = isin)), collapse = "&")
  if (search_string == "") {
    stop("Please specify either paramter search or isin to search for instruments.")
  }

  instr_url <- sprintf("https://%s.lemon.markets/v1/instruments/?%s",
                       get_data_url(),
                       search_string)
  resp <- request_lemon(instr_url)
  do.call(rbind, lapply(content(resp)$results, data.frame))
}
