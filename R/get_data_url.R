get_data_url <- function(is_live = Sys.getenv("LEMON_MARKETS_IS_LIVE", FALSE)) {
  out <- "paper-data"
  if (is_live) {
    out <- "data"
  }
  out
}
