#' The UI for the "Admin Panel" dashboard
#'
#' The `shiny` module UI for the `noClocksAuthR` Admin Panel, accessible to Admin users.
#'
#' @param options list of HTML elements to customize branding of "Admin Panel".  Valid
#' list element names are `title`, `sidebar_branding`, and `browser_tab_icon`.  See
#' \code{\link{default_admin_ui_options}} for an example.
#'
#'
#' @importFrom shiny actionButton NS icon
#' @importFrom shinydashboard dashboardBody sidebarMenu menuItem tabItems
#' @importFrom shinydashboardPlus dashboardHeader dashboardPage dashboardSidebar
#' @importFrom htmltools HTML tags
#' @importFrom shinyjs useShinyjs
#' @importFrom shinyFeedback useShinyFeedback
#'
#' @return the UI for the "Admin Panel"
#'
#' @export
#'
admin_ui <- function(
  options = default_admin_ui_options()
) {

  # don't show profile dropdown if in Admin mode.  User cannot log out of admin mode.

  head <- shinydashboardPlus::dashboardHeader(
    title = options$title,
    profile_module_ui("noclocksauthr__profile")
  )


  sidebar <- shinydashboardPlus::dashboardSidebar(
    shinydashboard::sidebarMenu(
      id = "sidebar_menu",
      shinydashboard::menuItem(
        text = "User Access",
        tabName = "user_access",
        icon = shiny::icon("users")
      ),


      options$sidebar_branding
    )
  )



  tab_items <- shinydashboard::tabItems(
    user_access_module_ui("user_access")
  )





  body <- shinydashboard::dashboardBody(
    htmltools::tags$head(
      options$browser_tab_icon,
      htmltools::tags$link(rel = "stylesheet", href = "noclocksauthr/css/styles.css?version=1")
    ),
    shinyjs::useShinyjs(),
    shinyFeedback::useShinyFeedback(),

    htmltools::tags$div(
      style = "position: fixed; bottom: 15px; right: 15px; z-index: 1000;",
      shiny::actionButton(
        "go_to_shiny_app",
        "Shiny App",
        icon = shiny::icon("rocket"),
        class = "btn-primary btn-lg",
        style = "color: #FFFFFF;"
      )
    ),

    tab_items
  )




  shinydashboardPlus::dashboardPage(
    head,
    sidebar,
    body,
    title = "No Clocks",
    skin = "black"
  )
}


#' The server logic for the default Admin Panel dashboard
#'
#' The Shiny module server logic for the `noClocksAuthR` Admin Panel, accessible to Admin users.
#'
#' @param input the Shiny server input
#' @param output the Shiny server output
#' @param session the Shiny server session
#'
#' @return \code{invisible(NULL)}
#'
#' @importFrom shiny callModule observeEvent
#'
#' @export
#'
admin_server <- function(input, output, session) {

  shiny::callModule(
    profile_module,
    "noclocksauthr__profile"
  )

  shiny::observeEvent(input$go_to_shiny_app, {

    # browser()
    #
    # # to to the Shiny app
    # remove_query_string(mode = "push")
    #
    # browser()

    # Go to `Shiny` app
    noClocksAuthR::remove_query_string()

    session$reload()

  }, ignoreInit = TRUE)

  shiny::callModule(user_access_module, "user_access")

  invisible(NULL)
}
