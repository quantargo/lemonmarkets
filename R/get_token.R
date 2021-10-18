#'  Get Lemon Markets Bearer Token
#'
#' Retrive a bearer/session token to access the Lemonmarkets
#' API.
#'
#' @param client_id character; Client ID to be used.
#' @param client_secret character; Client Secret to be used.
#' @export
get_token <- function(client_id = Sys.getenv("LEMON_MARKETS_CLIENT_ID"),
                      client_secret = Sys.getenv("LEMON_MARKETS_CLIENT_SECRET")) {

  lemon_token <- getOption("LEMON_MARKETS_TOKEN")
  if (!is.null(lemon_token)){
    return(lemon_token)
  }

  token = httr::POST("https://auth.lemon.markets/oauth2/token",
                     body = list(client_id = client_id,
                                 client_secret = client_secret,
                                 grant_type = "client_credentials"))
  content(token)$access_token
  options(LEMON_MARKETS_TOKEN = lemon_token)
  lemon_token
}
