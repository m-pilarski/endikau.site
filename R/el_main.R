#' Title
#'
#' @param ... NULL
#'
#' @return NULL
#' @export
#'
#' @examples NULL
el_main <- function(...){
  .dots <- list(...)
  htmltools::tags$main(!!!.dots)
}

#' Title
#'
#' @param ... NULL
#' @param .el_bg_color NULL
#' @param .el_is_grid NULL
#'
#' @return NULL
#' @export
#'
#' @examples NULL
el_main_sec <- function(..., .el_bg_color=NULL, .el_is_grid=TRUE){
  .dots <- list(...)
  htmltools::tags$div(
    class="container-fluid",
    style=glue::glue("background: { .el_bg_color };"),
    htmltools::tags$div(
      class=stringi::stri_c(
        "container-xxl py-4", dplyr::if_else(.el_is_grid, " grid", "")
      ),
      !!!.dots
    )
  )
}