#' Title
#'
#' @return NULL
#' @export
#'
#' @examples NULL
nd_navbar <- function(){
  htmltools::tags$div(
    id="page-navbar-container",
    htmltools::tags$nav(
      class="navbar navbar-expand-md py-0 align-middle fixed-top",
      id="page-navbar",
      htmltools::tags$div(
        class="container-fluid",
        htmltools::tags$a(
          class="navbar-brand", href="#", 
          "EnDiKaU"
        ),
        htmltools::tags$button(
          class="navbar-toggler",
          type="button",
          `data-bs-toggle`="collapse",
          `data-bs-target`="#navbarSupportedContent",
          `aria-controls`="navbarSupportedContent",
          `aria-expanded`="false",
          `aria-label`="Toggle navigation",
          htmltools::tags$i(class="fa-solid fa-bars")
        ),
        htmltools::tags$div(
          class="collapse navbar-collapse",
          id="navbarSupportedContent",
          htmltools::tags$ul(
            class="navbar-nav me-auto mb-2 mb-md-0",
            htmltools::tags$li(
              class="nav-item dropdown",
              htmltools::tags$a(
                class="nav-link dropdown-toggle",
                href="#",
                role="button",
                `data-bs-toggle`="dropdown",
                `aria-expanded`="false",
                htmltools::tags$i(class="fa-solid fa-calculator"), "Methoden",
              ),
              htmltools::tags$ul(
                class="dropdown-menu",
                htmltools::tags$li(htmltools::tags$a(class="dropdown-item", href="#", "Methode 1")),
                htmltools::tags$li(htmltools::tags$a(class="dropdown-item", href="#", "Methode 2")),
                htmltools::tags$li(htmltools::tags$hr(class="dropdown-divider")),
                htmltools::tags$li(htmltools::tags$a(class="dropdown-item", href="#", "Methode 3"))
              )
            ),
            htmltools::tags$li(
              class="nav-item dropdown",
              htmltools::tags$a(
                class="nav-link dropdown-toggle",
                href="#",
                role="button",
                `data-bs-toggle`="dropdown",
                `aria-expanded`="false",
                htmltools::tags$i(class="fa-solid fa-earth-americas"), "Fallstudien",
              ),
              htmltools::tags$ul(
                class="dropdown-menu",
                htmltools::tags$li(htmltools::tags$a(class="dropdown-item", href="#", "Fallstudie 1")),
                htmltools::tags$li(htmltools::tags$a(class="dropdown-item", href="#", "Fallstudie 2"))
              )
            )
          )
        )
      )
    ),
    htmltools::tags$div(id="page-navbar-spacer")
  )
}