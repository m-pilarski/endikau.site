
make_page <- function(){
  library(htmltools)
  library(htmlwidgets)
  navbar <- list(
    tags$header(
      tags$nav(
        class="navbar navbar-expand-sm py-0 align-middle fixed-top",
        id="page-navbar-container",
        tags$div(
          class="container-fluid",
          style="color: var(--bs-body-bg); background: var(--bs-body-color);",
          tags$a(
            class="navbar-brand font-monoton", href="#", style="color: var(--bs-body-bg); font-size: 2rem;",
            "EnDiKaU"
          ), 
          tags$button(
            class="navbar-toggler",
            type="button",
            `data-bs-toggle`="collapse",
            `data-bs-target`="#navbarSupportedContent",
            `aria-controls`="navbarSupportedContent",
            `aria-expanded`="false",
            `aria-label`="Toggle navigation",
            tags$i(class="fa-solid fa-bars", style="color: var(--bs-body-bg);")
          ),
          tags$div(
            class="collapse navbar-collapse",
            id="navbarSupportedContent",
            tags$ul(
              class="navbar-nav me-auto mb-2 mb-sm-0",
              tags$li(
                class="nav-item",
                tags$a(
                  class="nav-link active", 
                  `aria-current`="page", 
                  href="#", 
                  "Home", 
                  style="color: var(--bs-body-bg);"
                )
              ),
              tags$li(
                class="nav-item dropdown",
                tags$a(
                  class="nav-link dropdown-toggle",
                  href="#",
                  role="button",
                  `data-bs-toggle`="dropdown",
                  `aria-expanded`="false",
                  "Methoden",
                  style="color: var(--bs-body-bg);"
                ),
                tags$ul(
                  class="dropdown-menu",
                  tags$li(tags$a(class="dropdown-item", href="#", "Methode 1")),
                  tags$li(tags$a(class="dropdown-item", href="#", "Methode 2")),
                  tags$li(tags$hr(class="dropdown-divider")),
                  tags$li(tags$a(class="dropdown-item", href="#", "Methode 3"))
                )
              ),
              tags$li(
                class="nav-item dropdown",
                tags$a(
                  class="nav-link dropdown-toggle",
                  href="#",
                  role="button",
                  `data-bs-toggle`="dropdown",
                  `aria-expanded`="false",
                  "Fallstudien",
                  style="color: var(--bs-body-bg);"
                ),
                tags$ul(
                  class="dropdown-menu",
                  tags$li(tags$a(class="dropdown-item", href="#", "Fallstudie 1")),
                  tags$li(tags$a(class="dropdown-item", href="#", "Fallstudie 2"))
                )
              )
            )
          )
        )
      ),
      tags$div(id="page-navbar-spacer")
    )
  )
  
  content <- list(
    htmltools::tags$body(
      htmltools::tags$section(
        style="background: #b6b8b3;",
        htmltools::tags$div(
          class="container-xxl grid py-2",
          htmltools::tags$div(
            class="g-col-3 text-end", style="font-size: 3rem;", "⚖️"
          ),
          htmltools::tags$div(
            class="g-col-6", 
            htmltools::tags$h1(
              class="font-source-serif-4", tags$strong("Sentimentanalyse")
            ),
            "Hier steht etwas wichtiges…"
          ),
          htmltools::tags$div(class="g-col-3", "test 😬 test")
        )
      ),
      htmltools::tags$section(
        htmltools::tags$div(
          class="container-xxl grid py-2",
          htmltools::tags$div(class="g-col-3", "test 😬 test"),
          htmltools::tags$div(
            class="g-col-6", 
            htmltools::tags$h3(class="font-source-serif-4", tags$strong("Einleitung")),
            !!!purrr::map(stringi::stri_rand_lipsum(1), tags$p),
            htmltools::tags$h3(class="font-source-serif-4", tags$strong("Hauptteil")),
            !!!purrr::map(stringi::stri_rand_lipsum(2), tags$p)
          ),
          htmltools::tags$div(class="g-col-2", "test 😬 test")
        )
      )
    )
  )
  
  fonts <- list(
    htmlDependency(
      name="font-opensans",
      version="40",
      src=fs::path_package(
        "endikau.site", "www", "assets", "fonts", "open-sans"
      ),
      stylesheet=fs::path("font.css"),
      all_files=TRUE
    ),
    htmlDependency(
      name="font-source-serif-4",
      version="8",
      src=fs::path_package(
        "endikau.site", "www", "assets", "fonts", "source-serif-4"
      ),
      stylesheet=fs::path("font.css"),
      all_files=TRUE
    ),
    htmlDependency(
      name="font-monoton",
      version="19",
      src=fs::path_package(
        "endikau.site", "www", "assets", "fonts", "monoton"
      ),
      stylesheet=fs::path("font.css"),
      all_files=TRUE
    )
  )
  
  page <- htmltools::tags$html(
    htmltools::tags$meta(charset="utf-8"),
    !!!fonts,
    !!!navbar,
    !!!content,
    html_enable_bootstrap(),
    html_enable_twemoji(),
    html_enable_fontawesome(),
    htmlDependency(
      "adjustNavbarSpacer", version="0",
      src=fs::path_package(
        "endikau.site", "www", "assets", "js"
      ),
      script="navbar_height.js"
    )
  )
  
  temp_dir <- fs::file_temp(pattern="www")
  fs::dir_create(temp_dir)
  htmltools::save_html(page, fs::path(temp_dir, "index.html"))
  rstudioapi::viewer(fs::path(temp_dir, "index.html"))

}

if(interactive()){make_page()}
