#' Adds the contents of `inst/srcjs/` to `noclocksauthr/`
#'
#' @importFrom shiny addResourcePath
#' @importFrom httr set_config config
#'
#' @return \code{invisible(NULL)}
#'
#' @noRd
#'
.onLoad <- function(...) {
  shiny::addResourcePath("noclocksauthr", system.file("assets", package = "noClocksAuthR"))
  httr::set_config(httr::config(http_version = 0))
  set_api_url()

  invisible(NULL)
}
