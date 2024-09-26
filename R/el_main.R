#' Title
#'
#' @param ... NULL
#'
#' @return NULL
#' @export
#'
#' @examples NULL
nd_main <- function(...){
  .dots <- list(...)
  tags$main(!!!.dots)
}

#' Title
#'
#' @param ... NULL
#' @param .bg_color NULL
#' @param .is_grid NULL
#'
#' @return NULL
#' @export
#'
#' @examples NULL
nd_main_sec <- function(..., .bg_color=NULL, .is_grid=TRUE){
  .dots <- list(...)
  tags$div(
    class="container-fluid",
    style=glue::glue("background: { .bg_color };"),
    tags$div(
      class=stringi::stri_c(
        "container-xxl py-4", dplyr::if_else(.is_grid, " grid", "")
      ),
      !!!.dots
    )
  )
}