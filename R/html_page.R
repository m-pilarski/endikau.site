
make_page <- function(){

  page <- htmltools::tags$html(
    htmltools::tags$meta(charset="utf-8"),
    htmltools::tags$body(
      el_navbar(),
      el_main(
        el_main_sec(
          .el_bg_color="#e9ebe5",
          htmltools::tags$div(
            class="g-col-3 text-end", style="font-size: 3rem;", "🌡"
          ),
          htmltools::tags$div(
            class="g-col-6", 
            htmltools::tags$h1(
              class="font-source-serif-4", htmltools::tags$strong("Sentimentanalyse")
            ),
            htmltools::tags$strong("Automatisierte Erkennung von Stimmungen in Texten.")
          )
        ),
        el_main_sec(
          htmltools::tags$div(class="g-col-12 g-col-xl-3 order-xl-1", "test 😬 IMG"),
          htmltools::tags$div(
            class="g-col-12 g-col-xl-3 order-xl-3", 
            htmltools::tags$div("test 😬 TOC", style="position: sticky; top: 5rem;")
          ),
          htmltools::tags$div(
            class="g-col-12 g-col-xl-6 order-xl-2", 
            htmltools::tags$h3(class="font-source-serif-4", htmltools::tags$strong("Einleitung")),
            !!!purrr::map(stringi::stri_rand_lipsum(1), htmltools::tags$p),
            htmltools::tags$h3(class="font-source-serif-4", htmltools::tags$strong("Hauptteil")),
            !!!purrr::map(stringi::stri_rand_lipsum(2), htmltools::tags$p)
          )
        )
      )
    ),
    html_enable_fonts(),
    html_enable_bootstrap(),
    html_enable_twemoji(),
    html_enable_fontawesome()
  )
  
  temp_dir <- fs::file_temp(pattern="www")
  fs::dir_create(temp_dir)
  htmltools::save_html(page, fs::path(temp_dir, "index.html"))
  rstudioapi::viewer(fs::path(temp_dir, "index.html"))

}

if(interactive()){make_page()}
