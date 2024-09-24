# TODO: 
# - LOAD ALL DEPENDENCIES TOGETER TO AVOID REDUNDANCY (e.g., BOOTSTRAP)
# - MAKE PREP_GLOBAL_ASSET FUN SO THAT DEPENDENCIES ARE NOT NEEDED FOR EVERY SITE

#' Title
#'
#' @param .navbar NULL
#' @param .main NULL
#'
#' @return NULL
#' @export
#'
#' @examples NULL
make_page <- function(.navbar=el_navbar(), .main=el_main()){

  page <- htmltools::tags$html(
    htmltools::tags$meta(charset="utf-8"),
    htmltools::tags$head(htmltools::tags$title("EnDiKaU: Sentimentanalyse")),
    htmltools::tags$body(
      lang="de",
      el_navbar(),
      el_main(
        el_main_sec(
          .el_bg_color="#e9ebe5",
          htmltools::tags$div(
            class="g-col-1 g-col-xl-3 text-end", style="font-size: 3rem;", emoji::emoji("thermometer")
          ),
          htmltools::tags$div(
            class="g-col-11 g-col-xl-6", 
            htmltools::tags$h1("Sentimentanalyse"),
            "Automatisierte Erkennung von Stimmungen in Texten."
          )
        ),
        el_main_sec(
          htmltools::tags$div(
            class="g-col-12 g-col-xl-3 order-xl-3", 
            format_en_toc(
              list(
                "einleitung"="Einleitung",
                "lexikon"="Lexikon&shy;basierte Sentiment&shy;analyse",
                list(
                  "lexikon-funktionsweise"="Funktions&shy;weise",
                  "lexikon-kritik"="Kritik"
                ),
                "transformer"="Machine-Learning-Basierte Sentiment&shy;analyse",
                list(
                  "transformer-funktionsweise"="Funktions&shy;weise"
                )
              )
            )
          ),
          htmltools::tags$div(
            class="g-col-12 g-col-xl-6 order-xl-2 g-start-xl-4", 
            htmltools::tags$div(
              class="content-sec",
              htmltools::tags$h3("Einleitung"),
              !!!purrr::map(stringi::stri_rand_lipsum(1), htmltools::tags$p),
              htmltools::tags$div(
                class="card",
                htmltools::tags$div(
                  class="card-header",
                  "Wortwolke", emoji::emoji("cloud")
                ),
                htmltools::tags$div(
                  class="card-body",
                  word_cloud_element()
                )
              ),
              htmltools::tags$div(
                class="card",
                htmltools::tags$div(
                  class="card-header",
                  "Ausprobieren", emoji::emoji("bulb")
                ),
                htmltools::tags$div(
                  class="card-body",
                  htmltools::tags$iframe(
                    src="https://shiny.dsjlu.wirtschaft.uni-giessen.de/sentiment_dict/"
                  )
                )
              )
            ),
            htmltools::tags$div(
              class="content-sec",
              htmltools::tags$h3("Hauptteil"),
              !!!purrr::map(stringi::stri_rand_lipsum(5), htmltools::tags$p),
              # htmltools::tags$iframe(
              #   height="600pt", width="100%", frameborder="no", id="myIframe", loading="lazy",
              #   src="https://shiny.dsjlu.wirtschaft.uni-giessen.de/sentiment_dict/"
              # )
            )
          )
        )
      ),
#       # https://www.w3schools.com/howto/tryit.asp?filename=tryhow_js_navbar_hide_scroll
#       htmltools::HTML('<script> 
# var prevScrollpos = window.pageYOffset;
# window.onscroll = function() {
# var currentScrollPos = window.pageYOffset;
#   if (prevScrollpos > currentScrollPos) {
#     document.getElementById("page-navbar-container").style.top = "0 !important";
#   } else {
#     document.getElementById("page-navbar-container").style.top = "-50px !important";
#   }
#   prevScrollpos = currentScrollPos;
# }
# </script>')
    ),
    html_load_fonts(),
    html_load_bootstrap(
      .var_override=list(
        # Colors
        "$body-bg: #f5f7f1;",
        "$body-color: #1e1e24;",
        # Enable CSS Grid
        "$enable-grid-classes: false;",
        "$enable-cssgrid: true;"
      )
    ),
    html_load_twemoji(),
    html_load_fontawesome(),
    html_load_wordcloud2(),
    html_load_custom_sass(
      .sass=list(
        sass::sass_file("inst/www/assets/vendor/bootstrap/scss/bootstrap.scss"),
        sass::sass_file("inst/www/assets/vendor/bootstrap/scss/mixins/_breakpoints.scss"),
        sass::sass_file("inst/www/assets/scss/_toc.scss"),
        sass::sass_file("inst/www/assets/scss/_text-style.scss")
      )
    )#,
    # html_load_custom_js()
  )
  
  # temp_dir <- fs::file_temp(pattern="www")
  # fs::dir_create(temp_dir)
  temp_dir <- fs::path_real(here::here("../endikau.shares/site"))
  htmltools::save_html(page, fs::path(temp_dir, "index.html"))
  rstudioapi::viewer(fs::path(temp_dir, "index.html"))

}

if(interactive()){make_page()}
