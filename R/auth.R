#'  Get Lemon Markets Bearer Token
#'
#' Retrive a bearer/session token to access the Lemonmarkets
#' API.
#'
#' @param client_id character; Client ID to be used.
#' @param client_secret character; Client Secret to be used.
#' @param renew logical; Specify if token shall be renewed, even if already existing.
#' @importFrom httr content
#' @export
auth <- function(client_id = Sys.getenv("LEMON_MARKETS_CLIENT_ID"),
                      client_secret = Sys.getenv("LEMON_MARKETS_CLIENT_SECRET"),
                 renew = FALSE) {

  lemon_token <- getOption("LEMON_MARKETS_TOKEN")
  if (!is.null(lemon_token) & !renew){
    return(lemon_token)
  }

  token = httr::POST("https://auth.lemon.markets/oauth2/token",
                     body = list(client_id = client_id,
                                 client_secret = client_secret,
                                 grant_type = "client_credentials"))
  token_content <- content(token)
  if (is.null(token_content$access_token)) {
    stop("Authentication error. Have you correctly specified the environment variables 'LEMON_MARKETS_CLIENT_ID' and 'LEMON_MARKETS_CLIENT_SECRET' with Sys.setenv()? You can also consider putting them into an .Renviron file for a permanent setting.")
  }

  lemon_token <- token_content$access_token
  options(LEMON_MARKETS_TOKEN = lemon_token)
  invisible(lemon_token)
}
