#' Default Options for the Admin UI
#'
#' This function specifies the default logos that are displayed in the "Admin Panel".
#'
#' @importFrom htmltools tagList tags
#'
#' @return the default list of HTML for branding elements in the Admin Panel UI. The valid list element names are:
#' \itemize{
#'   \item \code{title} - Title/Logo element in top left corner of Admin Panel dashboard & browser tab title
#'   \item \code{sidebar_branding} - Branding (e.g. Logo) on left sidebar of Admin Panel dashboard
#'   \item \code{browser_tab_icon} - Icon to display in browser tab
#' }
#'
default_admin_ui_options <- function() {
  list(


    title = htmltools::tagList(
      htmltools::tags$a(
        href = "https://noclocks.dev",
        target = "_blank",
        htmltools::tags$img(
          src = "noclocksauthr/images/noclocks-logo-wordmark-black-transparent.png",
          style = "height: 37.5px; width: 220px; padding: 0; margin-left: -5px;",
          alt = "noClocksAuthR Logo"
        )
      ),
      htmltools::tags$head(htmltools::tags$title("noClocksAuthR"))
    ),


    sidebar_branding = htmltools::tags$a(
      href = "https://noclocks.dev",
      target = "_blank",
      htmltools::tags$img(
        style = "position: fixed; bottom: 0; left: 0; width: 230px;",
        src = "noclocksauthr/images/noclocks-logo-wordmark-black-transparent.png"
      )
    ),

    browser_tab_icon = htmltools::tags$link(
      rel = "shortcut icon",
      href = "noclocksauthr/images/favicon.ico"
    )
  )
}
