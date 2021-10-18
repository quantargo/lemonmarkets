#' @importFrom httr add_headers
request_lemon <- function(lemon_url) {
  resp <- httr::GET(lemon_url,
                    add_headers(Authorization = sprintf("Bearer %s", get_token())))
  if (resp$status_code != 200) {
    stop("not handled yet")
    # content(resp)
  }
  resp
}
