#' Run Shiny Application
#'
#' Launch the shiny application.
#'
#' @param ... other parameters passed to [shiny::runapp()]
#'
#' @export
#'
run_shiny <- function(...) {
  if (!requireNamespace("shiny", quietly = TRUE)) {
    stop('Shiny is needed to run the application. You can install it with `install.package("shiny")`')
  }
  shinyapp <- system.file("shinyapp.R", package = "cartofr")
  runApp(shinyapp, ...)
}
