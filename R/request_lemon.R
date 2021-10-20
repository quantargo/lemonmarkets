#' @importFrom httr add_headers GET
#' @importFrom utils URLencode
request_lemon <- function(lemon_url, FUN = GET, ...) {
  resp <- FUN(URLencode(lemon_url),
              ...,
              add_headers(Authorization = sprintf("Bearer %s", auth())))
  if (resp$status_code < 200 | resp$status_code >= 300) {
    msg_content <- content(resp)
    msg <- sprintf("%s (Status Code %d)", msg_content[[1]], resp$status_code)
    stop(msg)
  }
  resp
}

#' @importFrom httr POST
request_post_lemon <- lemon <- function(lemon_url, body = NULL, ...) {
  resp <- POST(URLencode(lemon_url),
               body = body,
               ...,
               add_headers(Authorization = sprintf("Bearer %s", auth())))
  if (resp$status_code < 200 & resp$status_code >= 300) {
    msg <- sprintf("%s (Status Code %d)", content(resp)$space, resp$status_code)
    stop(msg)
  }
  resp
}
