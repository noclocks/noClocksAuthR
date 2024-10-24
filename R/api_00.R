ua <- httr::user_agent("http://github.com/noclocks/noClocksAuthR")

#' Send GET Request to the noClocksAuthR API
#'
#' @param resp a noClocksAuthR API response
#'
#' @return an S3 object of class "noclocksauthr_api_res".
#'
#' @importFrom httr content http_error http_type status_code
#' @importFrom jsonlite fromJSON
#'
#' @export
#'
noclocksauthr_api_res <- function(resp) {


  if (!identical(httr::http_type(resp), "application/json")) {
    stop("API did not return json", call. = FALSE)
  }

  parsed <- jsonlite::fromJSON(
    httr::content(resp, "text", encoding = "UTF-8")
  )

  if (httr::http_error(resp)) {
    cat("noClocksAuthR API request failed\n")
    cat(paste0("Status Code: ", httr::status_code(resp)), "\n")
    stop(parsed$error, call. = FALSE)
  }


  structure(
    list(
      content = parsed,
      response = resp
    ),
    class = "noclocksauthr_api_res"
  )
}


#' print noclocksauthr_api_res
#'
#' Generic print function for \code{noclocksauthr_api_res} S3 class.
#'
#' @param x an S3 object of class \code{noclocksauthr_api_res}.
#' @param ... additional arguments.
#'
#' @return \code{invisible(NULL)}
#'
#' @export
#'
print.noclocksauthr_api_res <- function(x, ...) {
  cat("<noClocksAuthR ", x$response$url, ">\n", sep = "")
  print(x$content)

  invisible(NULL)
}


#' set noClocksAuthR API key
#'
#' The API key can be set as an Environment Variable via
#' \code{Sys.getenv("NOCLOCKSAUTHR_API_KEY")}.
#'
#' @param api_key the noClocksAuthR API key
#'
#' @export
#'
#' @return a list of the newly set `noClocksAuthR` R options
#'
#' @examples
#'
#' set_api_key(api_key = "<my noClocksAuthR API key>")
#'
#'
set_api_key <- function(api_key) {

  assign("api_key", api_key, envir = noclocksauthr)

  invisible(api_key)
}

#' @export
#' @rdname set_api_key
get_api_key <- function() {

  api_key <- noclocksauthr$api_key


  if (is.null(api_key)) {
    api_key <- Sys.getenv("NOCLOCKSAUTHR_API_KEY", unset = NA)
    if (is.na(api_key)) {
      stop("noClocksAuthR API key must be set", call. = FALSE)
    }
  }
  api_key
}



set_api_url <- function(
  api_url = "https://auth-api.noclocks.dev/v1"
) {

  assign("api_url", api_url, envir = noclocksauthr)

  invisible(list(
    api_url = api_url
  ))
}


#' Convert a list returned from the noClocksAuthR API into a data frame
#'
#' In order to avoid issues with converting R data frames into JSON objects and back
#' to R data frames, we instead convert R data frames to R lists before converting
#' them to JSON to be sent via the noClocksAuthR API.  This function then converts those
#' lists back into R data frames (or more precisely tibbles).
#'
#' @param api_list a list.  All elements in the list are vectors of the same length.
#'
#' @importFrom tibble as_tibble
#'
#' @return a tibble
#'
#' @export
#'
api_list_to_df <- function(api_list) {

  if (identical(length(api_list[[1]]), 0L)) {
    # if the data frame is 0 rows, then each of the list elements will be a list rather than
    # an atomic vector.  Here we convert these lists to character.
    api_list <- lapply(api_list, function(x) character(0))
  }

  tibble::as_tibble(api_list)
}
