request_lemon <- function(lemon_url) {
  resp <- httr::GET(lemon_url,
                    add_headers(Authorization = sprintf("Bearer %s", get_token())))
  if (instr$status_code != 200) {
    content(resp)
  }
}
