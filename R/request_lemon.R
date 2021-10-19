#' @importFrom httr add_headers GET
#' @importFrom utils URLencode
request_lemon <- function(lemon_url) {
  resp <- GET(URLencode(lemon_url),
              add_headers(Authorization = sprintf("Bearer %s", auth())))
  if (resp$status_code != 200) {
    msg <- sprintf("%s (%d)", content(resp)$detail, resp$status_code)
    stop(msg)
  }
  resp
}
